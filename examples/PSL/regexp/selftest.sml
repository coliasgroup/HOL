(*---------------------------------------------------------------------------*)
(* Regular expressions and a regexp matcher.                                 *)
(* Originated from Konrad Slind, tweaked by MJCG for Accellera PSL SEREs     *)
(* An automata-based matcher added by Joe Hurd                               *)
(*---------------------------------------------------------------------------*)

open HolKernel Parse boolLib bossLib regexpLib;

(******************************************************************************
* Set the trace level of the regular expression library:
* 0: silent
* 1: 1 character (either - or +) for each list element processed
* 2: matches as they are discovered
* 3: transitions as they are calculated
* 4: internal state of the automata
******************************************************************************)
val _ = set_trace "regexpTools" 0;


(*---------------------------------------------------------------------------*)
(* Examples of the matchers.                                                 *)
(*---------------------------------------------------------------------------*)

fun CHECK r s = EVAL “amatch ^r ^(stringSyntax.fromMLstring s)”;

fun die s = (print (s ^ "\n"); OS.Process.exit OS.Process.failure)
fun QCHECK q r s =
    let
      open testutils
    in
      tprint s;
      require_msg (check_result (aconv q o rhs o concl)) thm_to_string
                  (CHECK r) s
    end

val TCHECK = QCHECK T;
val FCHECK = QCHECK F;

val _ = regexpTools.prefix_sat_conv := regexpTools.chr_sat_conv;

val Alph_123 = fst(listSyntax.dest_list(rhs(concl(EVAL(Term`EXPLODE"123"`)))));
val Alph_ab = fst(listSyntax.dest_list(rhs(concl(EVAL(Term`EXPLODE"ab"`)))));
(* to mask out datatype *) fun Any x = x + 1
val Any = ``Dot : char regexp``;
val Epsilon = ``One : char regexp``;
val One = rhs(concl(EVAL(Term`Atom((=) (HD(EXPLODE "1")))`)));
val Two = rhs(concl(EVAL(Term`Atom((=) (HD(EXPLODE "2")))`)));
val a = rhs(concl(EVAL(Term`Atom((=) (HD(EXPLODE "a")))`)));
val b = rhs(concl(EVAL(Term`Atom((=) (HD(EXPLODE "b")))`)));
val c = rhs(concl(EVAL(Term`Atom((=) (HD(EXPLODE "c")))`)));

val r0 = Term `^One # ^Two`;
val r1 = Term `Repeat (^One # ^Two)`;
val r2 = Term `Repeat ^Any # ^One`;
val r3 = Term `^r2 # ^r1`;

val ones_and_twos = [
  TCHECK r0 "12",
  TCHECK r1 "12",
  TCHECK r1 "1212",
  TCHECK r1 "121212121212121212121212",
  FCHECK r1 "12123",
  FCHECK r2 "",
  TCHECK r2 "1",
  TCHECK r2 "0001",
  FCHECK r2 "0002",
  TCHECK r3 "00011212",
  FCHECK r3 "00011213",
  TCHECK (Term`Repeat(Repeat ^Any)`) "",
  TCHECK (Term`Repeat(Repeat ^Any)`) "0",
  TCHECK (Term`Repeat(Repeat ^Any)`) "0123",
  TCHECK (Term`Repeat (^Any # Repeat ^Any)`) "0",
  TCHECK (Term`Repeat (^Any # Repeat ^Any)`) "01",
  TCHECK (Term`Repeat (^Any # Repeat ^Any)`) "012",
  TCHECK (Term`^a # Repeat(^a || ^b) # Repeat(^b # ^a)`) "abba"
];

(* At most 2 a's. Alphabet = {a,b} *)
val AtMostTwo_a = Term `Repeat ^b
                     ||  Repeat ^b # (^a || ^a # Repeat ^b # ^a) # Repeat ^b`;

(* Exactly 2 a's. Alphabet = {a,b} *)
val ExactlyTwo_a = Term `Repeat ^b # ^a # Repeat ^b # ^a # Repeat ^b`;

(* All strings of length 0-3 *)
val UpTo3 = Term `^Epsilon || ^Any || ^Any#^Any || ^Any#^Any#^Any`;

(* All strings with no occurrences of aa or bb *)
val NoRepeats = Term `^Any || Repeat (^a # ^b) || Repeat (^b # ^a)`;

val as_and_bs = [
  TCHECK AtMostTwo_a "",
  TCHECK AtMostTwo_a "b",
  TCHECK AtMostTwo_a "a",
  TCHECK AtMostTwo_a "aa",
  TCHECK AtMostTwo_a "ab",
  TCHECK AtMostTwo_a "ba",
  TCHECK AtMostTwo_a "bb",
  TCHECK AtMostTwo_a "abbbbabbbb",
  TCHECK AtMostTwo_a "bbbbabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
  FCHECK AtMostTwo_a "abbbbabbbab",


  FCHECK ExactlyTwo_a "",
  FCHECK ExactlyTwo_a "b",
  FCHECK ExactlyTwo_a "a",
  TCHECK ExactlyTwo_a "aa",
  FCHECK ExactlyTwo_a "ab",
  FCHECK ExactlyTwo_a "ba",
  FCHECK ExactlyTwo_a "bb",
  TCHECK ExactlyTwo_a "abbbbabbbb",
  TCHECK ExactlyTwo_a "bbbbabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbab",
  FCHECK ExactlyTwo_a "abbbbabbbab",

  TCHECK UpTo3 "",
  TCHECK UpTo3 "b",
  TCHECK UpTo3 "a",
  TCHECK UpTo3 "aa",
  FCHECK UpTo3 "abbbbabbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",

  TCHECK NoRepeats "",
  TCHECK NoRepeats "a",
  TCHECK NoRepeats "b",
  FCHECK NoRepeats "aa",
  TCHECK NoRepeats "ab",
  TCHECK NoRepeats "ba",
  FCHECK NoRepeats "bb",
  TCHECK NoRepeats "ababababababababababababababababababababababababababab",
  FCHECK NoRepeats "abababababababababababbababababababababababababababab"
];

(* Some tests of the Prefix operator *)
val Prefix12 = Term `Prefix ^r0`;
val PrefixExactlyTwo_a =
  Term `Prefix (Repeat ^b # ^a # Repeat ^b # ^a # Repeat ^b)`;

val prefixes = [
  TCHECK Prefix12 "1",
  FCHECK Prefix12 "11",
  TCHECK PrefixExactlyTwo_a ""
]

(* Some tests of the export functions
val Prefix12_dfa = try (regexpLib.export_dfa Alph_123) Prefix12;
*)
(*---------------------------------------------------------------------------*)
