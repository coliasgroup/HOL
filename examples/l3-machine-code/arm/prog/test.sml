open arm_progLib;

use "arm_tests.sml";

val fails = ref ([]:string list);

fun attempt hex =
   arm_spec_hex hex
   handle HOL_ERR _ => (fails := hex::(!fails); [TRUTH]);

val () = (List.map attempt arm_tests; print "Done.\n")

val failed = !fails

val dec = arm_stepLib.arm_decode_hex ""

val l = List.map dec failed
