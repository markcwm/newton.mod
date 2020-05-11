# Newton Dynamics

Newton Dynamics 3.13 library wrapper for OpenB3DMax.

Dynamics.mod
============

Newton dynamics library source for version 3.13 is included with this module and no additional modules are required. The module works on Win/Mac/Linux but only builds with Blitzmax NG as there is an unresolved issue with threads. Currently only simple body and mesh physics have been wrapped.

Openb3dmax.mod
==============

The Newton Dynamics wrapper for OpenB3DMax. This implements simple body physics for cube and sphere primitives, only one example is included so far.

Installation
============

* Copy **newton.mod** to your `BlitzMax/mod` folder, module folder names must end in **.mod**
* If Windows, make sure you have a working version of MinGW. If Mac, make sure you have XCode installed. If Linux, have a look at this guide:
 [How To: Install BlitzMax NG on Win/Mac/Ubuntu 64-bit](https://www.syntaxbomb.com/index.php/topic,61.0.html)
* Open a Terminal, cd to `BlitzMax/bin` and for NG in 64-bit use `bmk makemods -d -w -g x64 newton`, on Mac/Linux you need `./bmk`

License
=======

Both the library and wrapper are licensed under the zlib open source license.

