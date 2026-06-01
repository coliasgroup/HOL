
open HolKernel Parse boolLib bossLib BasicProvers;

val _ = new_theory "GraphLangWIP";
val _ = ParseExtras.temp_loose_equality()

open wordsTheory wordsLib pairTheory listTheory relationTheory;
open pred_setTheory arithmeticTheory combinTheory;
open arm_decompTheory set_sepTheory progTheory addressTheory;
open m0_decompTheory riscv_progTheory;
open arm_decompLib m0_decompLib;

(*
echo 'load "wip";' | ../../../bin/hol
*)

(*
work here
*)

val _ = export_theory();
