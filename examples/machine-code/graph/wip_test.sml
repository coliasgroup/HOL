open HolKernel Parse boolLib bossLib;
open decompileLib testutils

(*
echo 'load "wip_test";' | ../../../bin/hol
*)

val _ = decompileLib.decomp "/home/x/i/v/seL4-verification-reproducibility/tmp/td/RISCV64-O2-gcc-14.2.0/kernel" false ""

val _ = OS.Process.exit OS.Process.success
