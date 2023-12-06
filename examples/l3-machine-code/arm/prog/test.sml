open arm_progLib;

(* val () = print "Testing...\n"
val th = arm_spec_hex "e12fff1e"
val () = print "PASS\n" *)

use "arm_tests.sml";

val fails = ref ([]:string list);

fun attempt hex =
   arm_spec_hex hex
   handle HOL_ERR _ => (fails := hex::(!fails); [TRUTH]);

val () = (List.map attempt arm_tests; print "Done.\n")

val failed = !fails

val dec = arm_stepLib.arm_decode_hex ""

val l = List.map dec failed
