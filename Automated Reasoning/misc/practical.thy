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
  obtain P where 1:"\<forall> y::int. \<forall>x::int. P x y \<longleftrightarrow> x = y" by auto
  hence 2:"(\<forall>y. \<exists>x. P x y) \<and> (\<forall>x. \<exists>xa. \<not> P x xa)" by presburger
  thus "\<exists>P. (\<forall>y::int. \<exists>x::int. P x y) \<and>
        (\<forall>x. \<exists>xa::int. \<not> P x xa)" by blast
qed
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
    moreover have "\<dots> = n^((Suc m) + 1) - 1" by simp
    ultimately show "power_sum n (Suc m) = n^((Suc m)+1) - 1" by presburger
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
      and A4: "\<forall>l1 \<in> lines. \<forall>l2 \<in> lines. 
               (l1 \<noteq> l2 \<and> p1 \<in> l1 \<and> p1 \<in> l2 \<and> p2 \<in> l1 \<and> p2 \<in> l2  \<longrightarrow> p1 = p2)"
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
apply default
unfolding plane_3_def lines_3_def
apply simp+
apply auto
done

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
proof (rule ccontr)
  assume 1:"\<not> m \<noteq> n"
  from 1 assms have "a \<in> m \<and> b \<in> m \<and> a \<noteq> b \<and> a \<in> l \<and> b \<in> l" by auto
  hence "m = l" using A4 assms(1) assms(7) by blast
  hence "p \<in> l" using assms by auto
  thus "False"  using assms(4) by auto
qed

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
proof -
  have "m \<noteq> n" using assms how_to_produce_different_lines by auto
  hence "m \<noteq> n \<and> d \<in> m \<and> c \<in> n \<and> p \<in> m \<and>  p \<in> n" using assms insert_subset by auto
  hence " d \<in> m \<and> c \<notin> m" using A4 assms by blast
  thus ?thesis by auto
qed

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
  assumes parallels_Ex: "\<forall> l1 \<in> lines.  \<forall>p1 \<in>plane.
    p1 \<notin> l1 \<longrightarrow> (\<exists>l2 \<in> lines. p1 \<in> l2 \<and> ( \<forall>p2 \<in> l1 . p2 \<notin> l2))"

(*  ----------------------------  *)
(* |   Problem 23 (2 marks):   | *)
(*  ----------------------------  *)
(* Give a model of Non-Projective Geometry with cardinality 4. 
   Show that it is indeed a model using the command "interpretation" *)
definition "plane_4 \<equiv> {1::int,2::int,3::int,4::int}"
definition "lines_4 \<equiv> {{1,2},{2,3},{3,4},{4,1},{1,3},{4,2}}"
interpretation Non_Projective_Geometry_smallest_model: 
  Non_Projective_Geometry plane_4 lines_4
apply default
unfolding plane_4_def lines_4_def
apply simp+
apply linarith
apply simp+
done

(*  ----------------------------  *)
(* |   Problem 24 (3 marks):   | *)
(*  ----------------------------  *)
(*  Formalise and prove: 
     "it is not true that every pair of lines intersect"  *)
lemma (in Non_Projective_Geometry) non_projective: 
  "\<exists>l1 \<in> lines. \<exists>l2 \<in> lines. \<forall> p \<in> l1. p \<notin> l2"
proof -
  obtain p1 p2 where 1:"p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> plane" 
         using two_points_exist by auto
  then obtain l1 where "p1 \<noteq> p2 \<and> {p1,p2} \<subseteq> l1 \<and> {p1,p2} \<subseteq> plane \<and> {l1} \<subseteq> lines"
         using A3 by auto
  then obtain p3 where "distinct[p1,p2] \<and> {p1,p2} \<subseteq> l1 \<and> 
         {p1,p2,p3} \<subseteq> plane \<and> {l1} \<subseteq> lines \<and> p3 \<notin> l1"
         using A5 by auto
  hence 1:"distinct[p1,p2,p3] \<and> p1 \<in> plane \<and> p2 \<in> plane \<and> p3 \<in> plane \<and> l1 \<in> lines \<and> 
         {p1,p2} \<subseteq> l1 \<and> p3 \<notin> l1 "
         by auto
  hence 2:"\<exists>l2 \<in> lines. p3 \<in> l2 \<and> ( \<forall>p \<in> l1 . p \<notin> l2)"
         using parallels_Ex by meson
  hence "\<exists>l2. l1 \<in> lines \<and> l2 \<in> lines \<and> p3 \<in> l2 \<and>( \<forall>p \<in> l1 . p \<notin> l2)" 
         using 1 2 by auto
  thus ?thesis by blast
qed

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
proof -
  have "\<forall>l \<in> lines. \<exists>x. card x = 3 \<and> x \<subseteq> l" using A7 by auto
  hence "\<forall>l \<in> lines. \<exists>x. \<exists> p1 p2 p3. distinct [p1,p2,p3] \<and> x = {p1,p2,p3} \<and> x \<subseteq> l"
        using construct_set_of_card3 by metis
  hence "\<forall>l \<in> lines. \<exists>p1 p2 p3. distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> l"
        by metis
  hence "\<forall>l \<in> lines. \<exists>p1 p2 p3. distinct [p1,p2,p3] \<and> {p1,p2,p3} \<subseteq> l \<and> {p1,p2,p3} \<subseteq> plane"
        using A2 by fast
  thus ?thesis by fast
qed

(*  ----------------------------  *)
(* |   Problem 26 (3 marks):   | *)
(*  ----------------------------  *)
(* Prove yet another alternative to axiom A7  *)
lemma (in Projective_Geometry) A7'': 
  "l \<in> lines \<Longrightarrow> {p,q} \<subseteq> l  \<Longrightarrow> (\<exists>r \<in> plane. r \<notin> {p,q} \<and> r \<in> l)"
proof simp
  assume 1:"l \<in> lines" "p \<in> l \<and> q \<in> l"
  show "\<exists>r\<in>plane. r \<noteq> p \<and> r \<noteq> q \<and> r \<in> l"
  proof -
    obtain p q r where 2:"l \<in> lines \<and> 
         {p,q,r} \<subseteq> plane \<and> distinct [p,q,r] \<and> {p,q,r} \<subseteq> l"
         using A7' 1 by auto
    hence 3:"p \<in> l \<and> q \<in> l \<and> r \<in> l" by blast
    have "r \<noteq> p \<and> r \<noteq> q" using 2 by auto
    hence "r\<in>plane \<and> r \<noteq> p \<and> r \<noteq> q \<and> r \<in> l" using 2 3 by auto
    thus ?thesis using 2 by (metis distinct.simps(2) insertI1 insert_subset list.simps(15))
  qed
qed

(*  ----------------------------  *)
(* |   Problem 27 (5 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) two_lines_per_point:
  "\<forall>p \<in> plane. \<exists>l \<in> lines. \<exists>m \<in> lines. l \<noteq> m \<and> p \<in> l \<inter> m"   
proof - 
  have "\<forall>p \<in> plane . \<exists>l1 \<in> lines. p \<in> l1" using A3 by (meson insert_subset)
  hence "\<forall>p \<in> plane. \<exists>p2 \<in> plane. \<exists>l1 \<in> lines. p \<in> l1 \<and> p2 \<notin> l1"
        using A5 by meson
  hence "\<forall>p \<in> plane. \<exists>p2 \<in> plane. \<exists>l1 \<in> lines. \<exists>l2 \<in> lines. 
        p \<in> l1 \<and> p2 \<notin> l1 \<and> {p,p2} \<subseteq> l2"
        using A3 by auto
  hence "\<forall>p \<in> plane. \<exists>p2 \<in> plane. \<exists>l1 \<in> lines. \<exists>l2 \<in> lines. 
        p \<in> l1 \<and> p2 \<notin> l1 \<and> {p,p2} \<subseteq> l2 \<and> p \<in> l2 \<and> p2 \<in> l2" by fastforce
  hence "\<forall>p \<in> plane.  \<exists>l1 \<in> lines. \<exists>l2 \<in> lines. 
        p \<in> l1 \<and>  p \<in> l2 \<and>
        l1 \<noteq> l2" by metis
  hence "\<forall>p \<in> plane. \<exists>l1 \<in> lines. \<exists>l2 \<in> lines. 
        p \<in> l1 \<and>  p \<in> l2 \<and>
        l1 \<noteq> l2 \<and>  p \<in> l1 \<inter> l2 " by blast
  thus ?thesis by meson
qed


(*  ----------------------------  *)
(* |   Problem 28 (4 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) external_line: 
  "\<forall>p \<in> plane. \<exists>l \<in> lines. p \<notin> l" 
proof default
  fix p assume pp:"p \<in> plane"
  show "\<exists>l\<in>lines. p \<notin> l"
  proof -
    obtain l where ll:"l \<in> lines" and pl:"p \<in> l" using A3 pp by blast
    obtain p2 where p2p:"p2 \<in> plane" and p2nl:"p2 \<notin> l" using A5 ll by blast
    obtain l1 where l1l:"l1 \<in> lines" and l1:"{p,p2} \<subseteq> l1" using pp p2p A3 by auto
    obtain p3 where p3p:"p3 \<in> plane" and p3nl1:"p3 \<notin> l1" using A5 l1l by blast
    obtain l2 where l2l:"l2 \<in> lines" and l2:"{p2,p3} \<subseteq> l2" using p2p p3p A3 by auto
    have l1nl2:"l1 \<noteq> l2" using p3nl1 l2 by fast
    have pnp2:"p \<noteq> p2" using pl p2nl by fast
    have pnl2:"p \<notin> l2"
    proof (rule ccontr,simp)
      assume "p \<in> l2"
      hence "p = p2" using A4 l1l l2l l1nl2 l1 l2 by blast
      thus "False" using pnp2 by auto
    qed
    thus ?thesis using l2l pnl2 by auto
  qed
qed

(*  ----------------------------  *)
(* |   Problem 29 (6 marks):   | *)
(*  ----------------------------  *)
lemma (in Projective_Geometry) three_lines_per_point:
  "\<forall>p \<in> plane. \<exists>l m n. distinct [l,m,n] \<and> {l,m,n} \<subseteq> lines \<and> p \<in> l \<inter> m \<inter> n" 
proof default
  fix p assume pp:"p \<in> plane"
  show "\<exists>l m n. distinct [l, m, n] \<and> {l, m, n} \<subseteq> lines \<and> p \<in> l \<inter> m \<inter> n"
  proof -
    obtain a where al:"a \<in> lines" and pna:"p \<notin> a" using external_line pp by blast
    obtain p1 p2 p3 where p1p:"p1 \<in> plane" and p2p:"p2 \<in> plane" and p3p:"p3 \<in> plane" and
      dp:"distinct[p1,p2,p3]" and a:"{p1,p2,p3} \<subseteq> a" using A7' al by auto
    obtain l m n where ll:"l \<in> lines" and ml:"m \<in> lines" and nl:"n \<in> lines" and 
      l:"{p,p1} \<subseteq> l" and m:"{p,p2} \<subseteq> m" and n:"{p,p3} \<subseteq> n" using A3 pp p1p p2p p3p by metis
    have anl:"a \<noteq> l" and ann:"a \<noteq> n" and anm:"a \<noteq> m" using pna a l n m by auto
    from a have p1a:"p1 \<in> a" and p2a:"p2 \<in> a" and p3a:"p3 \<in> a" by auto
    have lnm:"l \<noteq> m"
    proof (rule ccontr, simp)
      assume lm:"l = m"
      have npl:"{p,p1,p2} \<subseteq> l" using l m lm by simp
      hence p1p2:"p1 = p2" using A4 anl p1a p2a al lm ml by blast
      thus "False" using dp by auto
    qed
    have mnn:"m \<noteq> n"
    proof (rule ccontr, simp)
      assume mn:"m = n"
      have npm:"{p,p2,p3} \<subseteq> m" using m n mn by simp
      hence p2p3:"p2 = p3" using A4 anm p2a p3a al mn nl by blast
      thus "False" using dp by auto
    qed
    have nnl:"n \<noteq> l"
    proof (rule ccontr, simp)
      assume nl:"n = l"
      have npn:"{p,p1,p3} \<subseteq> n" using l n nl by simp
      hence p1p3:"p1 = p3" using A4 ann p1a p3a al nl ll by blast
      thus "False" using dp by auto
    qed
    have dl:"distinct[l,m,n]" using lnm mnn nnl by auto
    thus ?thesis using dl ll ml nl l m n by auto
  qed
qed

(*  -----------------------------  *)
(* |   Problem 30 (8 marks):   | *)
(*  -----------------------------  *)
lemma (in Projective_Geometry) at_least_seven_points: 
  "\<exists>p1 p2 p3 p4 p5 p6 p7. distinct [p1,p2,p3,p4,p5,p6,p7] \<and> {p1,p2,p3,p4,p5,p6,p7} \<subseteq> plane" 
proof - 
  obtain l where ll:"l \<in> lines" using one_line_exists by auto
  obtain p7 where p7p:"p7 \<in> plane" and p7nl:"p7 \<notin> l" using A5 ll by auto
  obtain p1 p2 p3 where p1p:"p1 \<in> plane" and p2p:"p2 \<in> plane" and p3p:"p3 \<in> plane" and 
    dp1:"distinct [p1,p2,p3]" and l:"{p1,p2,p3} \<subseteq> l" using A7' ll by auto
  obtain l1 l2 l3 where l1l:"l1 \<in> lines" and l2l:"l2 \<in> lines" and  l3l:"l3 \<in> lines" and
    l1:"{p7,p1} \<subseteq> l1" and l2:"{p7,p2} \<subseteq> l2" and l3:"{p7,p3} \<subseteq> l3" using A3 p1p p2p p3p p7p by metis
  have dp2:"distinct[p1,p2,p3,p7]" using dp1 p7nl l by fastforce
  have lnl1:"l \<noteq> l1" and  lnl2:"l \<noteq> l2" and  lnl3:"l \<noteq> l3" using p7nl l1 l2 l3 l by auto
  have l1nl2:"l1 \<noteq> l2"
  proof (rule ccontr, simp)
    assume "l1 = l2"
    hence "{p1,p2,p7} \<subseteq> l1" using l1 l2 by simp
    hence "p1 = p2" using A4 lnl1 p1p p2p l1l l ll by force
    thus "False" using dp2 by auto
  qed
  have l2nl3:"l2 \<noteq> l3"
  proof (rule ccontr, simp)
    assume "l2 = l3"
    hence "{p2,p3,p7} \<subseteq> l2" using l2 l3 by simp
    hence "p2 = p3" using A4 lnl2 p2p p3p l2l l ll by force
    thus "False" using dp2 by auto
  qed
  have l1nl3:"l1 \<noteq> l3"
  proof (rule ccontr, simp)
    assume "l1 = l3"
    hence "{p1,p3,p7} \<subseteq> l1" using l1 l3 by simp
    hence "p1 = p3" using A4 lnl1 p1p p3p l1l l ll by force
    thus "False" using dp2 by auto
  qed
  have dl:"distinct[l1,l2,l3]" using l1nl2 l2nl3 l1nl3 by auto
  obtain p4 where p4p:"p4 \<in> plane" and p4n:"p4 \<notin> {p1,p7}" and p4l1:"p4 \<in> l1"
    using l1 l1l p1p p7p A7'' by force
  obtain p5 where p5p:"p5 \<in> plane" and p5n:"p5 \<notin> {p2,p7}" and p5l2:"p5 \<in> l2"
    using l2 l2l p2p p7p A7'' by force
  obtain p6 where p6p:"p6 \<in> plane" and p6n:"p6 \<notin> {p3,p7}" and p6l3:"p6 \<in> l3"
    using l3 l3l p1p p7p A7'' by force
  have dp3:"distinct[p1,p4,p7]" "distinct[p2,p5,p7]" "distinct[p3,p6,p7]" using dp2 p4n p5n p6n by auto
  have p1np5:"p1\<noteq>p5"
  proof (rule ccontr, simp)
    assume "p1 = p5"
    hence "{p1,p5,p7} \<subseteq> l1" "{p1,p5,p7} \<subseteq> l2" using l1 l2 p5l2 by auto
    hence "p5 = p7" using A4 l1nl2 l1l l2l by force
    thus "False" using dp3 by auto
  qed
  moreover have p1np6:"p1\<noteq>p6"
  proof (rule ccontr, simp)
    assume "p1 = p6"
    hence "{p1,p6,p7} \<subseteq> l1" "{p1,p6,p7} \<subseteq> l3" using l1 l3 p6l3 by auto
    hence "p6 = p7" using A4 l1nl3 l1l l3l by force
    thus "False" using dp3 by auto
  qed
  moreover have p2np4:"p2\<noteq>p4"
  proof (rule ccontr, simp)
    assume "p2 = p4"
    hence "{p2,p4,p7} \<subseteq> l1" "{p2,p4,p7} \<subseteq> l2" using l1 l2 p4l1 by auto
    hence "p4 = p7" using A4 l1nl2 l1l l2l by force
    thus "False" using dp3 by auto
  qed
  moreover have p2np6:"p2\<noteq>p6"
  proof (rule ccontr, simp)
    assume "p2 = p6"
    hence "{p2,p6,p7} \<subseteq> l2" "{p2,p6,p7} \<subseteq> l3" using l2 l3 p6l3 by auto
    hence "p6 = p7" using A4 l2nl3 l2l l3l by force
    thus "False" using dp3 by auto
  qed
  moreover have p3np4:"p3\<noteq>p4"
  proof (rule ccontr, simp)
    assume "p3 = p4"
    hence "{p3,p4,p7} \<subseteq> l1" "{p3,p4,p7} \<subseteq> l3" using l1 l3 p4l1 by auto
    hence "p4 = p7" using A4 l1nl3 l1l l3l by force
    thus "False" using dp3 by auto
  qed
  moreover have p3np5:"p3\<noteq>p5"
  proof (rule ccontr, simp)
    assume "p3 = p5"
    hence "{p3,p5,p7} \<subseteq> l2" "{p3,p5,p7} \<subseteq> l3" using l2 l3 p5l2 by auto
    hence "p5 = p7" using A4 l2nl3 l3l l2l by force
    thus "False" using dp3 by auto
  qed
  moreover have p4np5:"p4\<noteq>p5"
  proof (rule ccontr, simp)
    assume "p4 = p5"
    hence "{p4,p5,p7} \<subseteq> l1" "{p4,p5,p7} \<subseteq> l2" using l1 l2 p4l1 p5l2 by auto
    hence "p5 = p7" using A4 l1nl2 l1l l2l by force
    thus "False" using dp3 by auto
  qed
  moreover have p4np6:"p4\<noteq>p6"
  proof (rule ccontr, simp)
    assume "p4 = p6"
    hence "{p4,p6,p7} \<subseteq> l1" "{p4,p6,p7} \<subseteq> l3" using l1 l3 p4l1 p6l3 by auto
    hence "p6 = p7" using A4 l1nl3 l1l l3l by force
    thus "False" using dp3 by auto
  qed
  moreover have p5np6:"p5\<noteq>p6"
  proof (rule ccontr, simp)
    assume "p5 = p6"
    hence "{p5,p6,p7} \<subseteq> l2" "{p6,p5,p7} \<subseteq> l3" using l3 l2 p6l3 p5l2 by auto
    hence "p5 = p7" using A4 l2nl3 l3l l2l by force
    thus "False" using dp3 by auto
  qed
  ultimately have dpf:"distinct[p1,p2,p3,p4,p5,p6,p7]" using dp2 dp3 by simp
  have allp:"{p1,p2,p3,p4,p5,p6,p7} \<subseteq> plane" using p1p p2p p3p p4p p5p p6p p7p by blast
  show ?thesis using dpf allp by blast
qed
  
(*  -----------------------------  *)
(* |   Problem 31 (3 marks):    | *)
(*  -----------------------------  *)
(*  Give a model of Projective Geometry with 7 points; use the 
    command "interpretation" to prove that it is indeed a model. *)
definition "plane_7 \<equiv> {1::int,2::int,3::int,4::int,5::int,6::int,7::int}"
definition "lines_7 \<equiv> {{1::int,2::int,4::int},
                       {1::int,3::int,5::int},
                       {2::int,3::int,6::int},
                       {4::int,5::int,6::int},
                       {1::int,6::int,7::int},
                       {2::int,5::int,7::int},
                       {3::int,4::int,7::int}}"
interpretation Projective_Geometry_smallest_model: 
  Projective_Geometry plane_7 lines_7
apply default
unfolding plane_7_def lines_7_def
apply simp+
apply linarith (*this takes a while*)
apply simp
apply simp
apply auto
proof -
  obtain x where 1:"x = {1::int,2::int,4::int}" "x \<subseteq> {1::int,2::int,4::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {1::int, 2::int, 4::int}" by blast
next
  obtain x where 1:"x = {1::int,3::int,5::int}" "x \<subseteq> {1::int,3::int,5::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {1::int,3::int,5::int}" by blast
next
  obtain x where 1:"x = {2::int,3::int,6::int}" "x \<subseteq> {2::int,3::int,6::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {2::int,3::int,6::int}" by blast
next
  obtain x where 1:"x = {4::int,5::int,6::int}" "x \<subseteq> {4::int,5::int,6::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {4::int,5::int,6::int}" by blast
next
  obtain x where 1:"x = {1::int,6::int,7::int}" "x \<subseteq> {1::int,6::int,7::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {1::int,6::int,7::int}" by blast
next
  obtain x where 1:"x = {2::int,5::int,7::int}" "x \<subseteq> {2::int,5::int,7::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {2::int,5::int,7::int}" by blast
next
  obtain x where 1:"x = {3::int,4::int,7::int}" "x \<subseteq> {3::int,4::int,7::int}" "card x = 3" by simp
  then show "\<exists>x. card x = 3 \<and> x \<subseteq> {3::int,4::int,7::int}" by blast
qed

end
