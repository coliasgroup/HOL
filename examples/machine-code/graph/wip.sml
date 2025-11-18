
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
val bit_field_insert_h_l = store_thm("bit_field_insert_h_l",
  ``((h = 19) /\ (l = 9)) ==> (bit_field_insert h l (v:word32) (w:word32) =
     ((v << (32 - ((h + 1) - l)) >>> (32 - (h + 1))) || (w << (32 - l)) >>> (32 - l) || (w >>> (h + 1)) << (h + 1)):word32)``,
  blastLib.BBLAST_TAC);
*)

(*
fun bit_field_insert_h_l h l = store_thm("bit_field_insert_" ^ Int.toString h ^ "_" ^ Int.toString l,
  ``((h = (^(wordsSyntax.mk_wordii (h, 32)):num)) /\ (l = (^(wordsSyntax.mk_wordii (l, 32))):num)) ==> (bit_field_insert h l (v:word32) (w:word32) =
     ((v << (32 - ((h + 1) - l)) >>> (32 - (h + 1))) || (w << (32 - l)) >>> (32 - l) || (w >>> (h + 1)) << (h + 1)):word32)``,
  blastLib.BBLAST_TAC);
*)

val tm_x =
  ``(bit_field_insert h l (v:word32) (w:word32) =
     ((v << (32 - ((h + 1) - l)) >>> (32 - (h + 1))) || (w << (32 - l)) >>> (32 - l) || (w >>> (h + 1)) << (h + 1)):word32)``;

fun bit_field_insert_h_l h l = store_thm("bit_field_insert_" ^ Int.toString h ^ "_" ^ Int.toString l,
  (tm_x
    |> Term.subst [``h:num`` |-> numSyntax.mk_numeral (Arbnum.fromInt h)])
    |> Term.subst [``l:num`` |-> numSyntax.mk_numeral (Arbnum.fromInt l)],
  blastLib.BBLAST_TAC);

val bit_field_inserts = [
  bit_field_insert_h_l 1 0,
  bit_field_insert_h_l 2 0,
  bit_field_insert_h_l 3 0,
  bit_field_insert_h_l 4 0,
  bit_field_insert_h_l 5 0,
  bit_field_insert_h_l 6 0,
  bit_field_insert_h_l 7 0,
  bit_field_insert_h_l 8 0,
  bit_field_insert_h_l 9 0,
  bit_field_insert_h_l 10 0
  ];

val bit_field_insert_19_9 = bit_field_insert_h_l 19 9;

val bit_field_insert_11_9 = store_thm("bit_field_insert_11_9",
  ``(bit_field_insert 11 9 (v:word32) (w:word32) =
     ((v << (32 - ((11 + 1) - 9)) >>> (32 - (11 + 1))) || (w << (32 - 9)) >>> (32 - 9) || (w >>> (11 + 1)) << (11 + 1)):word32)``,
  blastLib.BBLAST_TAC);

val export_init_rw = save_thm("export_init_rw",
  CONJ (LIST_CONJ bit_field_inserts) bit_field_insert_11_9);

val _ = export_theory();
