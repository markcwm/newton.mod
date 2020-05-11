' newton.openb3dmax

SuperStrict

'Rem

Rem
bbdoc: Newton wrapper for OpenB3DMax
about:
Implements the declarations in Newton.Dynamics module
End Rem
Module Newton.Openb3dmax

ModuleInfo "Version: 1.00"
ModuleInfo "License: zlib"
ModuleInfo "Copyright: Newton Dynamics - 2003-2011 Julio Jerez and Alain Suero"
ModuleInfo "Copyright: Newton Wrapper - 2015-2016 Bruce A Henderson"
ModuleInfo "Copyright: Newton for OpenB3DMax - 2016 James Boyd (HiToro/DruggedBunny)"

'EndRem

Import Openb3dmax.B3dglgraphics
Import Newton.Dynamics

Include "inc/newtonbody.bmx"
Include "inc/newtonground.bmx"
Include "inc/newtoncube.bmx"
Include "inc/newtonsphere.bmx"
Include "inc/functions.bmx"
