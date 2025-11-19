
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

val foo = store_thm("foo",
  ``w2n ((w2w ((w2w ((x && 63w):word64)):word6)):word64) = w2n (x && 63w)``,
  rw [w2n_w2w] \\ blastLib.BBLAST_TAC);

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

val tm_x =
  ``(bit_field_insert h l (v:word32) (w:word32) =
     ((v << (32 - ((h + 1) - l)) >>> (32 - (h + 1))) || (w << (32 - l)) >>> (32 - l) || (w >>> (h + 1)) << (h + 1)):word32)``;

fun bit_field_insert_h_l h l = store_thm("bit_field_insert_" ^ Int.toString h ^ "_" ^ Int.toString l,
  (tm_x
    |> Term.subst [``h:num`` |-> numSyntax.mk_numeral (Arbnum.fromInt h)])
    |> Term.subst [``l:num`` |-> numSyntax.mk_numeral (Arbnum.fromInt l)],
  blastLib.BBLAST_TAC);

val tm_y =
  ``(bit_field_insert h 0 (v:word32) (w:word32) =
     ((v << (32 - (h + 1)) >>> (32 - (h + 1))) || (w >>> (h + 1)) << (h + 1)):word32)``;

fun bit_field_insert_h_0 h = store_thm("bit_field_insert_" ^ Int.toString h ^ "_0",
  tm_y
    |> Term.subst [``h:num`` |-> numSyntax.mk_numeral (Arbnum.fromInt h)],
  blastLib.BBLAST_TAC);

val bit_field_inserts = [
  bit_field_insert_h_0 1,
  bit_field_insert_h_0 2,
  bit_field_insert_h_0 3,
  bit_field_insert_h_0 4,
  bit_field_insert_h_0 5,
  bit_field_insert_h_0 6,
  bit_field_insert_h_0 7,
  bit_field_insert_h_0 8,
  bit_field_insert_h_0 9,
  bit_field_insert_h_0 10
  ];

val bit_field_insert_19_9 = bit_field_insert_h_l 19 9;

val bit_field_insert_11_9 = store_thm("bit_field_insert_11_9",
  ``(bit_field_insert 11 9 (v:word32) (w:word32) =
     ((v << (32 - ((11 + 1) - 9)) >>> (32 - (11 + 1))) || (w << (32 - 9)) >>> (32 - 9) || (w >>> (11 + 1)) << (11 + 1)):word32)``,
  blastLib.BBLAST_TAC);

val export_init_rw = save_thm("export_init_rw",
  CONJ (LIST_CONJ bit_field_inserts) bit_field_insert_11_9);
*)

val _ = export_theory();
