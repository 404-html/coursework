theory tutorial2
imports Main

begin

lemma exercise21: "(ALL x. P x \<longrightarrow> Q) \<longrightarrow> (EX x. P x \<longrightarrow> Q)"
apply (rule impI)
apply (frule_tac x = a in spec)
apply (rule exI)
apply assumption
done

lemma exercise22:"\<not>(\<exists>x. P x)\<longrightarrow>(\<forall>y.\<not>P y)"
apply (rule impI)
apply (rule allI)
apply (rule notI)
apply (erule notE)
apply (rule exI)
apply assumption
done

text {*This is really messy and need to be clean up using rule_tac*}
lemma exercise23:"\<not>(\<forall>x. P x)\<longrightarrow>(\<exists>y.\<not>P y)"
apply (rule impI)
apply (rule notnotD)
apply (rule notI)
apply (erule notE)
apply (rule allI)
apply (rule notnotD)
apply (rule notI)
apply (erule notE)
apply (rule exI)
apply assumption
done
  
thm notI

end
