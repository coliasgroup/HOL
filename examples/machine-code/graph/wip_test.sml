open HolKernel Parse boolLib bossLib;
open decompileLib testutils

(*
echo 'load "wip_test";' | ../../../bin/hol
*)


val thm = decompileLib.decomp "aarch64/test" false ""

val _ = OS.Process.exit OS.Process.success
