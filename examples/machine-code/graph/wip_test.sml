open HolKernel Parse boolLib bossLib;
open decompileLib testutils

(*
echo 'load "wip_test";' | ../../../bin/hol
*)

val _ = decompileLib.decomp "foo/test" false ""

val _ = OS.Process.exit OS.Process.success
