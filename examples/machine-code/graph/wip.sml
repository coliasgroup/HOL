
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

val bit_field_insert_h_l = store_thm("bit_field_insert_h_l",
  ``((h = 19) /\ (l = 9)) ==> (bit_field_insert h l (v:word32) (w:word32) =
     ((v << (32 - ((h + 1) - l)) >>> (32 - (h + 1))) || (w << (32 - l)) >>> (32 - l) || (w >>> (h + 1)) << (h + 1)):word32)``,
  blastLib.BBLAST_TAC);

val _ = export_theory();
