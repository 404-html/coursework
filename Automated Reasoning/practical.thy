theory practical
imports Main Real
begin


(*  --------------------------------------------------------------  *)
(* |                           PART 1:                            | *)
(* |                     PROPOSITIONAL LOGIC                      | *)
(* |                       AND QUANTIFIERS                        | *)
(*  --------------------------------------------------------------  *)
   
(*  ---------------------------  *)
(* |   Problem 1 (2 marks):   | *)
(*  ---------------------------  *)
lemma "(P \<longrightarrow> Q) \<longrightarrow> (P \<longrightarrow> \<not>Q) \<longrightarrow> (P \<longrightarrow> R)"
apply (rule impI)
apply (rule impI)
apply (rule impI)
apply (drule mp)
apply assumption
apply (drule mp)
apply assumption
apply (erule notE)
apply assumption
done

(*  ---------------------------  *)
(* |   Problem 2 (2 marks):   | *)
(*  ---------------------------  *)
lemma "(P \<longrightarrow> Q) \<Longrightarrow> (R \<longrightarrow> S) \<and> P \<and> R \<longrightarrow> Q \<and> S"
apply (rule impI)
apply (erule conjE)
apply (erule conjE)
apply (rule conjI)
apply (erule mp)
apply assumption
apply (erule mp)
apply assumption
done

(*  ---------------------------  *)
(* |   Problem 3 (3 marks):   | *)
(*  ---------------------------  *)
lemma "(\<not>P \<and> \<not>Q) \<longleftrightarrow> \<not>(P \<or> Q)"
apply (rule iffI)
apply (rule notI)
apply (erule conjE)
apply (erule disjE)
apply (erule notE)
apply assumption
apply (erule_tac ?P = "Q" in notE)
apply assumption
apply (rule conjI)
apply (rule notI)
apply (erule notE)
apply (rule disjI1)
apply assumption
apply (rule notI)
apply (erule notE)
apply (rule disjI2)
apply assumption
done
  
(*  ---------------------------  *)
(* |   Problem 4 (3 marks):   | *)
(*  ---------------------------  *)
lemma "\<not> (\<exists>x. \<not> P x) \<Longrightarrow> (\<forall>x. P x)"
apply (rule allI)
apply (rule notnotD)
apply (rule notI)
apply (erule notE)
apply (rule exI)
apply assumption
done

(*  ---------------------------  *)
(* |   Problem 5 (5 marks):   | *)
(*  ---------------------------  *)
lemma "\<exists>x. drunk x \<longrightarrow> (\<forall>y. drunk y)" 
apply (cut_tac P = "(\<forall>y. drunk y)" in excluded_middle)
apply (erule disjE)
apply (rule ccontr)
apply (erule notE)
apply (rule allI)
apply (rule ccontr)
apply (erule notE)
apply (rule_tac x = "y" in exI)
apply (rule impI)
apply (erule notE)
apply assumption
apply (rule_tac x = "y" in exI)
apply (rule impI)
apply assumption
done

(*  --------------------------------------------------------------  *)
(* |                           PART 2:                            | *)
(* |                     STRUCTURED PROOF AND                     | *)
(* |                   POWERFUL REASONING TOOLS                   | *)
(*  --------------------------------------------------------------  *)
(*   From this point on you can use any of the following tactics: 
     auto, simp, blast, fast, force, fastforce, 
     presburger, algebra, unfold, induction.
     
     However, you are NOT allowed to use metis, meson and smt.
*)

(*  ---------------------------  *)
(* |   Problem 6 (3 marks):   | *)
(*  ---------------------------  *)
(* Fill in the blanks in the following proof: *)
lemma "\<not>(\<forall>P. (\<forall> y::int. \<exists>x::int. P x y) \<longrightarrow> (\<exists>x. \<forall>y. P x y))"
proof simp (* This step is given. Don't erase this, and don't try writing before this line. *)
    fix y :: 'int assume 1:"\<exists>P. (\<exists>x. P x y)"
    obtain x where "\<exists>P. (P x y)" using 1 by auto
    fix x :: 'int assume 2:"\<exists>P. (\<exists>x. P x y) \<and> (\<exists>xa. \<not> P x xa)"
    obtain P where
    fix x :: 'int assume 2:"\<exists>P. (\<exists>xa. \<not> P x xa)"
    obtain x :: 'int where "\<exists>P. (P x y)" using 1 by auto
    obtain P where "P x y" by auto

    fix P :: "'int\<Rightarrow>'int\<Rightarrow>bool"
oops


definition "R12 (x::int) y \<equiv> 12 dvd (x-y)"

(*  ---------------------------  *)
(* |   Problem 7 (2 marks):   | *)
(*  ---------------------------  *)
(* Fill in the blanks in the following proof: *)
theorem reflR: "R12 x x" 
proof (unfold R12_def dvd_def) (* This step is given. Don't erase this, and don't try writing before this line. *)
  show "\<exists>k. x - x = 12 * k"
  proof-
    have "x - x = 12 * 0" by simp
    hence "x - x =  0" by simp
    hence "0 = 0" by simp
    hence "True" by simp
    thus ?thesis by simp
  qed
qed

(*  ---------------------------  *)
(* |   Problem 8 (3 marks):   | *)
(*  ---------------------------  *)
(* Fill in the blanks in the following proof: *)
theorem symR: "R12 x y \<longleftrightarrow> R12 y x" 
proof (unfold R12_def dvd_def, auto) (* This step is given. Don't erase this. *)
  fix k assume "(x - y) = 12 * k" (* This step is given. Don't erase this, don't try writing before this line. *)
  hence "(y - x) = 12 * - k" by simp
  thus "\<And>k. x - y = 12 * k \<Longrightarrow> \<exists>k. y - x = 12 * k" by auto
next
  fix k assume "(y - x) = 12 * k"  (* This step is given. Don't change anything before this. *)
  hence "(x - y) = 12 * - k" by simp
  thus "\<And>k. y - x = 12 * k \<Longrightarrow> \<exists>k. x - y = 12 * k" by auto
qed

(*  ---------------------------  *)
(* |   Problem 9 (3 marks):   | *)
(*  ---------------------------  *)
(* Fill in the blanks in the following proof: *)
theorem transR: "R12 x y \<Longrightarrow> R12 y z \<Longrightarrow> R12 x z" 
proof (unfold R12_def dvd_def, auto)  (* This step is given. Don't change anything before this. *)
  fix k ka assume "(x - y) = 12 * k" "(y - z) = 12 * ka"
  hence 1:"(x - z) = 12 * (k + ka)" by simp
  obtain kb where "kb = (k + ka)" using assms by auto
  hence "(x - z) = 12 * kb" using 1 by auto
  thus " \<And>k ka. x - y = 12 * k \<Longrightarrow> y - z = 12 * ka \<Longrightarrow> \<exists>k. x - z = 12 * k" by auto
qed 


(* you may find these equalities useful at some point. 
   Do not erase this lemma *)
lemma numeral_simps: "3 = Suc 2" "2 = Suc 1" "1 = Suc 0" by simp+


(*  ----------------------------  *)
(* |   Problem 10 (2 marks):   | *)
(*  ----------------------------  *)
(* Define gauss_sum (1 pt) (the sum of all naturals from 1 to n)
   Do not modify the structure of the definition; 
   only fill in the missing part.
*)
primrec gauss_sum :: "nat \<Rightarrow> nat" where
  "gauss_sum (Suc n) = gauss_sum n + n + 1"
| "gauss_sum 0 = 0"

(* state theorem, prove (1 pt).  *)
theorem "2 * (gauss_sum n) = n * ( n + 1 )"
proof (induction n)
  case 0
    show "2 * (gauss_sum 0) = 0 * ( 0 + 1 )" by simp
  case (Suc n)
    from Suc obtain m where "m = Suc n"
      "2 * (gauss_sum m) =  m * ( m + 1 )" by simp
    thus " 2 * (gauss_sum (Suc n)) = Suc n * (Suc n + 1)" by simp
qed

(*  ----------------------------  *)
(* |   Problem 11 (2 marks):   | *)
(*  ----------------------------  *)
(* define sum_of_odds (1 pt), state theorem, prove (1 pt).*)
primrec sum_of_odds  :: "nat \<Rightarrow> nat" where
    "sum_of_odds (Suc n) = sum_of_odds n + 2 * n + 1"
  | "sum_of_odds 0 = 0"

theorem "sum_of_odds n = n * n"
proof (induction n)
  case 0
    show "sum_of_odds 0 = 0 * 0" by simp
  case (Suc n)
    from Suc obtain m where "m = Suc n"
      "sum_of_odds m = m * m" by simp
    thus "sum_of_odds (Suc n) = Suc n * Suc n "by auto
qed
  
(*  ----------------------------  *)
(* |   Problem 12 (5 marks):   | *)
(*  ----------------------------  *)
primrec power_sum :: "nat \<Rightarrow> nat \<Rightarrow> nat" where
  "power_sum n (Suc m) = (power_sum n m) + (n - 1) * n^(Suc m)"
| "power_sum n 0 = (n - 1)"


theorem "n > 0 \<Longrightarrow> power_sum n m = n^(m+1) - 1" 
proof (induction m)
  case 0
    show "power_sum n 0 = n^(0+1) - 1" by simp
  case (Suc m)
    have "power_sum n (Suc m) = (power_sum n m) + (n - 1) * n^(Suc m)" by simp
    moreover have "\<dots> = n^(m + 1) - 1 + (n - 1) * n^(m + 1)" using Suc.IH Suc.prems Suc_eq_plus1 by presburger
    moreover have "\<dots> = n^(m + 1) + (n - 1)* n^(m + 1)- 1 " by (simp add: Suc.prems Suc_leI)
    moreover have "\<dots> = (n - 1 + 1)*n^(m + 1) - 1" by simp
    moreover have "\<dots> = n^(m + 2) - 1" by (simp add: Suc.prems)
    ultimately have "\<dots> = n^((Suc m) + 1) - 1" by simp
    thus "power_sum n (Suc m) = n^((Suc m)+1) - 1" 
      using \<open>(n - 1 + 1) * n ^ (m + 1) - 1 = n ^ (m + 2) - 1\<close> 
            \<open>n ^ (m + 1) + (n - 1) * n ^ (m + 1) - 1 = (n - 1 + 1) * n ^ (m + 1) - 1\<close>
            \<open>n ^ (m + 1) - 1 + (n - 1) * n ^ (m + 1) = n ^ (m + 1) + (n - 1) * n ^ (m + 1) - 1\<close> 
            \<open>power_sum n (Suc m) = power_sum n m + (n - 1) * n ^ Suc m\<close> 
            \<open>power_sum n m + (n - 1) * n ^ Suc m = n ^ (m + 1) - 1 + (n - 1) * n ^ (m + 1)\<close>
      by linarith
qed


(*  ----------------------------  *)
(* |   Problem 13 (5 marks):   | *)
(*  ----------------------------  *)
lemma "\<forall>x\<in>X. \<forall>y\<in>X. x = y \<Longrightarrow> card X \<le> 1" 
proof -
  assume a:"\<forall>x\<in>X. \<forall>y\<in>X. x = y"
  show "card X \<le> 1"
    proof cases
      assume "X = {}"
      thus "card X \<le> 1" by auto
    next
      assume 1:"X \<noteq> {}"
      show "card X \<le> 1"
      proof -
        have 2:"\<forall>x\<in>X. \<forall>y\<in>X. x = y" using a by simp
        obtain x where "x\<in>X" using 1 by auto
        hence "X = {x}" using a by force
        hence "card X = 1" by auto
        thus "card X \<le> 1" by auto
      qed
    qed
qed

(*  --------------------------------------------------------------  *)
(* |                            PART 3:                           | *)
(* |                   FORMALISING AND REASONING                  | *)
(* |                ABOUT GEOMETRIES USING LOCALES                | *)
(*  --------------------------------------------------------------  *)

(*  From this point on you can also use metis and meson, but not smt.   *)

(*  ----------------------------  *)
(* |   Problem 14 (2 marks):   | *)
(*  ----------------------------  *)
(* State formally the following axioms 
   (first 3 are given; one point per each of the others): *)
locale Simple_Geometry =
  fixes plane :: "'a set"
  fixes lines :: "('a set) set"
  assumes A1: "plane \<noteq> {}"
      and A2: "\<forall>l \<in> lines. l \<subseteq> plane \<and> l \<noteq> {}"
      and A3: "\<forall>p \<in> plane. \<forall>q \<in> plane. \<exists>l \<in> lines. {p,q} \<subseteq> l"
      and A4: "\<forall>l1 \<in> lines. \<forall>l2 \<in> lines. \<forall>p1 p2. 
               (l1 \<noteq> l2 \<and> p1 \<in> l1 \<and> p1 \<in> l2 \<and> p2 \<in> l1 \<and> p2 \<in> l2) \<longrightarrow>( p1 = p2)"
      and A5: "\<forall>l \<in> lines. \<exists>p \<in> plane. p \<notin> l "

(*  ---------------------------  *)
(* |   Problem 15 (1 point):   | *)
(*  ---------------------------  *)
(* Formalise the statement: the set of lines is non-empty *)
lemma (in Simple_Geometry) one_line_exists: "\<exists>l \<in> lines. l \<subseteq> plane"
proof -
  show ?thesis by (meson A1 A2 A3 equals0I)
qed  

(*  ----------------------------  *)
(* |   Problem 16 (2 marks):   | *)
(*  ----------------------------  *)
lemma (in Simple_Geometry) two_points_exist: 
  "\<exists>p1 p2. p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> plane" 
proof -
  have "\<exists>l \<in> lines. l \<subseteq> plane" using one_line_exists by auto
  hence "\<exists>l \<in> lines. \<exists>p1 \<in> plane. l \<subseteq> plane \<and> p1 \<notin> l " using A5 by auto
  hence "\<exists>l \<in> lines. \<exists>p1 \<in> plane. \<exists>p2 \<in> plane. l \<subseteq> plane \<and> p1 \<notin> l  \<and> p2 \<in> l" 
        using A2 by (metis bot.extremum_unique rev_subsetD subsetI)
  hence "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. p1 \<noteq> p2" by force
  hence "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. \<exists>l2 \<in> lines. {p1, p2} \<subseteq> l2 \<and> p1 \<noteq> p2" 
        using A3 by meson
  thus ?thesis by auto
qed

(*  ----------------------------  *)
(* |   Problem 17 (3 marks):   | *)
(*  ----------------------------  *)
lemma (in Simple_Geometry) three_points_exist: 
  "\<exists>p1 p2 p3. distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> plane" 
proof -
  have "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. p1 \<noteq> p2" using two_points_exist by auto
  hence "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. \<exists>l \<in> lines.  
         p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> l" 
         using A3 by meson
  hence "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. \<exists>p3 \<in> plane. \<exists>l \<in> lines.  
         p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> l  \<and> p3 \<notin> l" 
         using A5 by meson
  hence "\<exists>p1 \<in> plane. \<exists>p2 \<in> plane. \<exists>p3 \<in> plane. \<exists>l \<in> lines.  
         p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> l  \<and> p3 \<notin> l \<and> p1 \<noteq> p3 \<and> p2 \<noteq> p3" 
         by auto
  thus ?thesis by auto
qed

(*  ----------------------------  *)
(* |   Problem 18 (3 marks):   | *)
(*  ----------------------------  *)
(* REMEMVER THAT CARD OF INFINITE SETS IS 0! *)
lemma (in Simple_Geometry) card_of_plane_greater: 
  "finite plane \<Longrightarrow> card plane \<ge> 3" 
proof (rule ccontr)
  assume a:"finite plane" "\<not> 3 \<le> card plane"
  have 1:"\<exists>p1 p2 p3. distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> plane" using three_points_exist by auto
  hence 2:"\<exists>p1 p2 p3. distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> plane \<and> card plane = 3"
          by (metis a card.insert card_empty card_mono distinct.simps(2) finite.emptyI finite.insertI list.set(1) list.set(2) numeral_3_eq_3)
  hence 3:"card plane = 3 \<and> 3 > card plane" using a 2 by auto
  thus "False" using less_irrefl by auto
qed

(*  ----------------------------  *)
(* |   Problem 19 (2 marks):   | *)
(*  ----------------------------  *)
(* GIVE THE SMALLEST MODEL! *)
definition "plane_3 \<equiv> {1::int,2::int,3::int}"
definition "lines_3 \<equiv> {{1::int,2::int},{1::int,3::int},{2::int,3::int}}"
interpretation Simple_Geometry_smallest_model: 
  Simple_Geometry plane_3 lines_3
apply standard
proof
  show "plane_3 = {} \<Longrightarrow> False" by (simp add: plane_3_def)
  show "\<forall>l\<in>lines_3. l \<subseteq> plane_3 \<and> l \<noteq> {}" by (simp add: plane_3_def lines_3_def)
  show "\<forall>p\<in>plane_3. \<forall>q\<in>plane_3. \<exists>l\<in>lines_3. {p, q} \<subseteq> l"
        by (simp add: plane_3_def lines_3_def)
  show "\<forall>l1\<in>lines_3.
        \<forall>l2\<in>lines_3.
        \<forall>p1 p2. l1 \<noteq> l2 \<and> p1 \<in> l1 \<and> p1 \<in> l2 \<and> p2 \<in> l1 \<and> p2 \<in> l2 \<longrightarrow> p1 = p2"
        by sledgehammer
  oops
      


(*
lemma (in Simple_Geometry) "False"
proof -
  show ?thesis by sledgehamme
*)

(*  ----------------------------  *)
(* |   Problem 20 (5 marks):   | *)
(*  ----------------------------  *)
lemma (in Simple_Geometry) 
  how_to_produce_different_lines:
assumes
    "l \<in> lines" 
    "{a, b} \<subseteq> l" "a \<noteq> b"
    "p \<notin> l"
    "n \<in> lines" "{a, p} \<subseteq> n" 
    "m \<in> lines" "{b, p} \<subseteq> m"
shows "m \<noteq> n"
  oops


(*  ----------------------------  *)
(* |   Problem 21 (4 marks):   | *)
(*  ----------------------------  *)
lemma (in Simple_Geometry) 
  how_to_produce_different_points:
assumes
    "l \<in> lines" 
    "{a, b} \<subseteq> l" "a \<noteq> b"
    "p \<notin> l"
    "n \<in> lines" "{a, p, c} \<subseteq> n"  
    "m \<in> lines" "{b, p, d} \<subseteq> m"
    "p \<noteq> c"
shows "c \<noteq> d" 
  oops


(*  ---------------------------  *)
(* |   Problem 22 (1 point):   | *)
(*  ---------------------------  *)
(* 1 point: 
 Formalise the following axiom: 
   if a point p lies outside of a line l then there 
   must exist at least one line m that passes through p, 
   which does not intersect l *)
locale Non_Projective_Geometry = 
  Simple_Geometry +
  assumes parallels_Ex: (*  FILL THIS SPACE  *)
  

(*  ----------------------------  *)
(* |   Problem 23 (2 marks):   | *)
(*  ----------------------------  *)
(* Give a model of Non-Projective Geometry with cardinality 4. 
   Show that it is indeed a model using the command "interpretation" *)

 (*  FILL THIS SPACE  *)


(*  ----------------------------  *)
(* |   Problem 24 (3 marks):   | *)
(*  ----------------------------  *)
(*  Formalise and prove: 
     "it is not true that every pair of lines intersect"  *)
lemma (in Non_Projective_Geometry) non_projective: 
   (*  fill this space *)
   oops

(* The following are some auxiliary lemmas that may be useful.
   You don't need to use them if you don't want. *)
lemma construct_set_of_card1:  
  "card x = 1 \<Longrightarrow> \<exists> p1. x = {p1}"
  by (metis One_nat_def card_eq_SucD)
lemma construct_set_of_card2:  
  "card x = 2 \<Longrightarrow> \<exists> p1 p2 . distinct [p1,p2] \<and> x = {p1,p2}" 
  by (metis card_eq_SucD distinct.simps(2) 
      distinct_singleton list.set(1) list.set(2) numeral_2_eq_2)
lemma construct_set_of_card3: 
  "card x = 3 \<Longrightarrow> \<exists> p1 p2 p3. distinct [p1,p2,p3] \<and> x = {p1,p2,p3}" 
  by (metis card_eq_SucD distinct.simps(2) 
      distinct_singleton list.set(1) list.set(2) numeral_3_eq_3)
lemma construct_set_of_card4: 
  "card x = 4 \<Longrightarrow> \<exists> p1 p2 p3 p4. distinct [p1,p2,p3,p4] \<and> x = {p1,p2,p3,p4}" 
  by (metis (no_types, lifting) card_eq_SucD construct_set_of_card3 
      Suc_numeral add_num_simps(1) add_num_simps(7) 
      distinct.simps(2) empty_set list.set(2))
  
(* GIVEN *)
locale Projective_Geometry = 
  Simple_Geometry + 
  assumes A6: "\<forall>l \<in> lines. \<forall>m \<in> lines. \<exists>p \<in> plane. p \<in> l \<and> p \<in> m"
      and A7: "\<forall>l \<in> lines. \<exists>x. card x = 3 \<and> x \<subseteq> l"
  

(*  ----------------------------  *)
(* |   Problem 25 (3 marks):   | *)
(*  ----------------------------  *)
(*   Prove this alternative to axiom A7   *)
lemma (in Projective_Geometry) A7': 
  "\<forall>l \<in> lines. \<exists>p1 p2 p3. {p1,p2,p3} \<subseteq> plane \<and> distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> l" 
  oops


(*  ----------------------------  *)
(* |   Problem 26 (3 marks):   | *)
(*  ----------------------------  *)
(* Prove yet another alternative to axiom A7  *)
lemma (in Projective_Geometry) A7'': 
  "l \<in> lines \<Longrightarrow> {p,q} \<subseteq> l  \<Longrightarrow> (\<exists>r \<in> plane. r \<notin> {p,q} \<and> r \<in> l)"
  oops


(*  ----------------------------  *)
(* |   Problem 27 (5 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) two_lines_per_point:
  "\<forall>p \<in> plane. \<exists>l \<in> lines. \<exists>m \<in> lines. l \<noteq> m \<and> p \<in> l \<inter> m" 
  oops


(*  ----------------------------  *)
(* |   Problem 28 (4 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) external_line: 
  "\<forall>p \<in> plane. \<exists>l \<in> lines. p \<notin> l" 
  oops
  

(*  ----------------------------  *)
(* |   Problem 29 (6 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) three_lines_per_point:
  "\<forall>p \<in> plane. \<exists>l m n. distinct [l,m,n] \<and> {l,m,n} \<subseteq> lines \<and> p \<in> l \<inter> m \<inter> n" 
  oops


(*  -----------------------------  *)
(* |   Problem 30 (8 marks):   | *)
(*  -----------------------------  *)
lemma (in Projective_Geometry) at_least_seven_points: 
  "\<exists>p1 p2 p3 p4 p5 p6 p7. distinct [p1,p2,p3,p4,p5,p6,p7] \<and> {p1,p2,p3,p4,p5,p6,p7} \<subseteq> plane" 
  oops

  
(*  -----------------------------  *)
(* |   Problem 31 (3 marks):    | *)
(*  -----------------------------  *)
(*  Give a model of Projective Geometry with 7 points; use the 
    command "interpretation" to prove that it is indeed a model. *)

 (*  FILL THIS BLANK *)


end
