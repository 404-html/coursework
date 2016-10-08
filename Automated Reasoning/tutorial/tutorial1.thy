theory tutorial1
imports Main

begin

theorem "A \<longrightarrow> B \<longrightarrow> A"
apply (rule impI)
apply (rule impI)
apply assumption
done
thm mp
lemma exercise4: "(R\<longrightarrow>P)\<longrightarrow>(((\<not>R\<or>P)\<longrightarrow>(Q\<longrightarrow>S))\<longrightarrow>(Q\<longrightarrow>S))" 
apply (rule impI)
apply (rule impI)
apply (rule_tac P = "\<not> R \<or> P" in mp)
apply assumption
apply (rule_tac P = "\<not>R" and Q = "R" in disjE)
apply (rule excluded_middle)
apply (erule disjI1)
apply (rule disjI2)
apply (erule_tac P = "R" in mp)
apply assumption
done

lemma exercise42: "(R\<longrightarrow>P)\<longrightarrow>(((\<not>R\<or>P)\<longrightarrow>(Q\<longrightarrow>S))\<longrightarrow>(Q\<longrightarrow>S))"
apply (rule impI)
apply (rule impI)
apply (rule impI)
apply (erule impCE)
apply (erule impE)
apply (erule disjI1)
apply (erule mp)
apply assumption
apply (erule impE)
apply (erule disjI2)
apply (erule mp)
apply assumption
done

lemma exercise51: "( P \<longrightarrow>( Q \<longrightarrow> R )) \<longrightarrow>  (( P \<longrightarrow> Q )\<longrightarrow>( P\<longrightarrow> R))"
apply (rule impI)
apply (rule impI)
apply (rule impI)
apply (drule mp)
apply assumption
apply (erule mp)
apply (erule mp)
apply assumption
done

lemma exercise52: "\<not>\<not>P \<longrightarrow> P"
apply (rule impI)
apply (erule notnotD)
done

lemma exercise53: "(P \<longrightarrow> Q \<and> R) \<longrightarrow> ((P \<longrightarrow> Q) \<and> (P \<longrightarrow> R))"
apply (rule impI)
apply (rule context_conjI)
apply (rule impI)
apply (drule mp)
apply assumption
apply (drule conjunct1)
apply assumption
apply (rule impI)
apply (drule mp)
apply assumption
apply (drule conjunct2)
apply assumption
done

lemma exercise54: "(\<not>P \<longrightarrow> Q)\<longrightarrow>(\<not>Q \<longrightarrow> P)"
apply (rule impI)
apply (rule impI)
apply (rule classical)
apply (erule notE)
apply (erule mp)
apply assumption
done

lemma exercise55: "P \<or> \<not> P"
apply (rule disjCI)
apply (erule notnotD)
done

end
