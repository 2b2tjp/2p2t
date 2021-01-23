#!/usr/bin/env bash

(
PS1="$"
basedir="$(cd "$1" && pwd -P)"
workdir="$basedir/work"
gitcmd="git -c commit.gpgsign=false -c core.safecrlf=false"

echo "Rebuilding patch files from current fork state..."

function cleanupPatches {
    cd "$1"
    for patch in *.patch; do
        echo "$patch"
        diffs=$($gitcmd diff --staged "$patch" | grep --color=none -E "^(\+|\-)" | grep --color=none -Ev "(\-\-\- a|\+\+\+ b|^.index)")

        if [ "x$diffs" == "x" ] ; then
            $gitcmd reset HEAD "$patch" >/dev/null
            $gitcmd checkout -- "$patch" >/dev/null
        fi
    done
}

function savePatches {
    what=$1
    what_name=$(basename "$what")
    target=$2
    echo "Formatting patches for $what..."

    cd "$basedir/${what_name}-Patches/"
    if [ -d "$basedir/$target/.git/rebase-apply" ]; then
        # in middle of a rebase, be smarter
        echo "REBASE DETECTED - PARTIAL SAVE"
        last=$(cat "$basedir/$target/.git/rebase-apply/last")
        next=$(cat "$basedir/$target/.git/rebase-apply/next")
        for i in $(seq -f "%04g" 1 1 $last)
        do
            if [ $i -lt $next ]; then
                rm ${i}-*.patch
            fi
        done
    else
        rm -rf *.patch
    fi

    cd "$basedir/$target"

    $gitcmd format-patch --zero-commit --full-index --no-signature --no-stat -N -o "$basedir/${what_name}-Patches/" upstream/upstream >/dev/null
    cd "$basedir"
    $gitcmd add -A "$basedir/${what_name}-Patches"
    cleanupPatches "$basedir/${what_name}-Patches"
    echo "  Patches saved for $what to $what_name-Patches/"
}

savePatches "$workdir/Spigot/Spigot-API" "Paper-API"
savePatches "$workdir/Spigot/Spigot-Server" "Paper-Server"
) || exit 1
