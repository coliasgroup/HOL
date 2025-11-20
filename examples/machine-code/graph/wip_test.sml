open HolKernel Parse boolLib bossLib;
open decompileLib testutils

(*
echo 'load "wip_test";' | ../../../bin/hol

val thm = PolyML.Exception.traceException
    ((fn () => let val _ = decompileLib.decomp "aarch64/test" false "" in () end),
     (fn (fs, ex) => let val _ = (print "fdjsklfs"; List.app print fs) in () end))

PolyML.Compiler.debug := true;
open PolyML.Debug;
breakEx (Fail "");
breakIn "decomp";
open HolKernel;
load "wip_test";
*)

val _ = decompileLib.decomp "riscv64/test" false ""

val _ = OS.Process.exit OS.Process.success
