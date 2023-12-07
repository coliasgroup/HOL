open arm_progLib;


(*
PolyML.Compiler.debug := true;
fun addList a l =
   let
       fun f (b,c) = a+b+c
   in
       case l of
             [] => a
           | (x::y) =>
               let
                   val v = f x
                   val l' = y
               in
                   addList v l
               end
   end;
open PolyML.Debug;
breakIn "f";
addList 0 [(1,2), (3, 4)];
*)

(*
*)
(* val () = print "Testing...\n"; *)
(* val th = arm_spec_hex "e12fff1e"; *)
(* val th = arm_spec_hex "e16f5f15"; *)
(* val () = print "PASS\n"; *)
(*
*)

(*
use "arm_tests.sml";

val fails = ref ([]:string list);

fun attempt hex =
   arm_spec_hex hex
   handle HOL_ERR _ => (fails := hex::(!fails); [TRUTH]);

val () = (List.map attempt arm_tests; print "Done.\n")

val failed = !fails

val dec = arm_stepLib.arm_decode_hex ""

val l = List.map dec failed
*)

(*
  "e1810f91" (*         strex   r0, r1, [r1]  *) ::
  "e95d7ffc" (*         ldmdb   sp, {r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^  *) ::
  "e95d7fff" (*         ldmdb   sp, {r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, sl, fp, ip, sp, lr}^  *) ::
  "e16f5f15" (*         clz     r5, r5  *) ::
  "e16f3f13" (*         clz     r3, r3  *) ::
  "112fff1e" (*         bxne    lr  *) ::
  "912fff1e" (*         bxls    lr  *) ::
  "012fff1e" (*         bxeq    lr  *) ::
  "e12fff1e" (*         bx      lr  *) ::
*)
