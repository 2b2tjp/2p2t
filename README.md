2p2t
===========

High performance Paper fork that aims to fix performance, exploits, gameplay and mechanics inconsistencies.

This branch is `feature/async-chunk-gen` and may contain experimental code.
It should work well, but maybe not if you modified 2p2t.yml. (see Important note below)

- Async advancement data load/save
- Async statistic data load/save
- Async chunk generation
- Async chunk data saving
- Async chunk loading

Important
------
- Do NOT set `settings.max-chunk-gen-threads` to greater than 1 unless you know what you are doing.
- This branch is not compatible with master branch. Do not merge, please copy patch files to master branch instead.

Documentation
------
Access the Paper docs here: [paper.readthedocs.io](https://paper.readthedocs.io/)  
Access the Paper API javadocs here: [destroystokyo.com/javadocs](https://destroystokyo.com/javadocs/)

How To (Server Admins)
------
Paperclip is a jar file that you can download and run just like a normal jar file.

Run the Paperclip jar directly from your server. Just like old times

Paper requires [**Java 8**](http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html) or above.

How To (Compiling Jar From Source)
------
To compile Paper, you need JDK 8, maven, and an internet connection.

Clone this repo, run `./paper jar` from *bash*, get files.

How To (Pull Request)
------
See [Contributing](CONTRIBUTING.md)

What is 2p2t?
-------------
2paper2tools

Special Thanks To:
-------------

![YourKit-Logo](https://www.yourkit.com/images/yklogo.png)

[YourKit](http://www.yourkit.com/), makers of the outstanding java profiler, support open source projects of all kinds with their full featured [Java](https://www.yourkit.com/java/profiler/index.jsp) and [.NET](https://www.yourkit.com/.net/profiler/index.jsp) application profilers. We thank them for granting Paper an OSS license so that we can make our software the best it can be.
