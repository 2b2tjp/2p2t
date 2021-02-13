#!/usr/bin/env bash

(
set -e
nms="net/minecraft/server"
export MODLOG=""
PS1="$"
basedir="$(cd "$1" && pwd -P)"
gitcmd="git -c commit.gpgsign=false"

workdir="$basedir/work"
minecraftversion=$(cat "$workdir/BuildData/info.json"  | grep minecraftVersion | cut -d '"' -f 4)
decompiledir="$workdir/Minecraft/$minecraftversion"

export importedmcdev=""
function import {
    export importedmcdev="$importedmcdev $1"
    file="${1}.java"
    target="$workdir/Spigot/Spigot-Server/src/main/java/$nms/$file"
    base="$decompiledir/$nms/$file"

    if [[ ! -f "$target" ]]; then
        export MODLOG="$MODLOG  Imported $file from mc-dev\n";
        echo "Copying $base to $target"
        cp "$base" "$target"
    else
        echo "UN-NEEDED IMPORT: $file"
    fi
}

(
    cd "$workdir/Spigot/Spigot-Server/"
    lastlog=$($gitcmd log -1 --oneline)
    if [[ "$lastlog" = *"mc-dev Imports"* ]]; then
        $gitcmd reset --hard HEAD^
    fi
)

import AxisAlignedBB
import BaseBlockPosition
import BiomeBase
import BlockBed
import BiomeBigHills
import BiomeJungle
import BiomeMesa
import BlockBeacon
import BlockChest
import BlockFalling
import BlockFurnace
import BlockIceFrost
import BlockObserver
import BlockPosition
import BlockRedstoneComparator
import BlockSnowBlock
import BlockStateEnum
import ChunkCache
import ChunkCoordIntPair
import ChunkProviderFlat
import ChunkProviderGenerate
import ChunkProviderHell
import ChunkProviderTheEnd
import CombatTracker
import CommandAbstract
import CommandScoreboard
import CommandWhitelist
import ControllerJump
import DataBits
import DataConverterMaterialId
import DataInspectorBlockEntity
import DataPalette
import DefinedStructure
import DragonControllerLandedFlame
import EnchantmentManager
import Enchantments
import EnderDragonBattle
import EntityIllagerIllusioner
import EntityLlama
import EntitySquid
import EntityTypes
import EntityWaterAnimal
import EntityWitch
import EnumItemSlot
import EULA
import FileIOThread
import IHopper
import ItemBlock
import ItemFireworks
import ItemMonsterEgg
import IRangedEntity
import LegacyPingHandler
import LotoSelectorEntry
import NavigationAbstract
import NBTTagCompound
import NBTTagList
import Packet
import PacketEncoder
import PacketPlayInUseEntity
import PacketPlayInWindowClick
import PacketPlayOutMapChunk
import PacketPlayOutPlayerListHeaderFooter
import PacketPlayOutScoreboardTeam
import PacketPlayOutTitle
import PacketPlayOutUpdateTime
import PacketPlayOutWindowItems
import PathfinderAbstract
import PathfinderGoal
import PathfinderGoalFloat
import PathfinderGoalGotoTarget
import PathfinderWater
import PersistentScoreboard
import PersistentVillage
import PlayerConnectionUtils
import RegionFile
import Registry
import RegistryBlockID
import RegistryMaterials
import RemoteControlListener
import RecipeBookServer
import ServerPing
import SoundEffect
import StructureBoundingBox
import StructurePiece
import StructureStart
import TileEntityEnderChest
import TileEntityLootable
import WorldGenAcaciaTree
import WorldGenBase
import WorldGenBigTree
import WorldGenBonusChest
import WorldGenCactus
import WorldGenCavesHell
import WorldGenClay
import WorldGenCanyon
import WorldGenCaves
import WorldGenDeadBush
import WorldGenDesertWell
import WorldGenDungeons
import WorldGenEndCity
import WorldGenEndCityPieces
import WorldGenEnder
import WorldGenEndGateway
import WorldGenEndIsland
import WorldGenEndTrophy
import WorldGenFactory
import WorldGenFire
import WorldGenFlatInfo
import WorldGenFlatLayerInfo
import WorldGenFlowers
import WorldGenForest
import WorldGenForestTree
import WorldGenFossils
import WorldGenGrass
import WorldGenGroundBush
import WorldGenHellLava
import WorldGenHugeMushroom
import WorldGenJungleTree
import WorldGenLakes
import WorldGenLargeFeature
import WorldGenMineshaft
import WorldGenLightStone1
import WorldGenLightStone2
import WorldGenLiquids
import WorldGenMegaTree
import WorldGenMegaTreeAbstract
import WorldGenMelon
import WorldGenMinable
import WorldGenMineshaftPieces
import WorldGenMineshaftStart
import WorldGenMonument
import WorldGenMonumentPieces
import WorldGenMushrooms
import WorldGenNether
import WorldGenNetherPieces
import WorldGenPackedIce1
import WorldGenPackedIce2
import WorldGenPumpkin
import WorldGenReed
import WorldGenRegistration
import WorldGenSand
import WorldGenStrongholdPieces
import WorldGenStronghold
import WorldGenSwampTree
import WorldGenTaiga1
import WorldGenTaiga2
import WorldGenTaigaStructure
import WorldGenTallPlant
import WorldGenTreeAbstract
import WorldGenTrees
import WorldGenWaterLily
import WorldGenWoodlandMansion
import WorldGenWoodlandMansionPieces
import WorldProvider

cd "$workdir/Spigot/Spigot-Server/"
rm -rf nms-patches applyPatches.sh makePatches.sh >/dev/null 2>&1
$gitcmd add . -A >/dev/null 2>&1
echo -e "mc-dev Imports\n\n$MODLOG" | $gitcmd commit . -F -
)
