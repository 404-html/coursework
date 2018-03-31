theory tutorial4
imports Main

begin

lemma exercise1a: "(P\<longrightarrow>(Q\<longrightarrow>R))\<longrightarrow>((P\<longrightarrow>Q)\<longrightarrow>(P\<longrightarrow>R))"
proof
  assume e1a1: "(P\<longrightarrow>(Q\<longrightarrow>R))"
  show "((P\<longrightarrow>Q)\<longrightarrow>(P\<longrightarrow>R))" 
  proof 
    assume e1a11: "P\<longrightarrow>Q"
    show "P\<longrightarrow>R"
    proof
      assume p:"P"
      from e1a11 p have q:"Q" by (rule mp)
      from e1a1 p have e1a12:"Q\<longrightarrow>R" by (rule mp)
      from e1a12 q show "R" by (rule mp)
    qed
  qed
qed

lemma exercise1b: "(\<forall>x. P x \<longrightarrow> Q) \<longrightarrow> (\<exists>x. P x \<longrightarrow> Q)"
proof
  assume e1b1: "(\<forall>x. P x \<longrightarrow> Q)"
  show e1b2: "(\<exists>x. P x \<longrightarrow> Q)"
  proof
    from e1b1 show "P a\<longrightarrow>Q" by (rule spec)
  qed
qed

lemma exercise1c: assumes "\<not> (\<exists>x .P x)" shows "\<forall>x .\<not> P x"
proof (rule classical)
  assume as:"\<not> (\<forall>x .\<not> P x)"
  from as obtain a where pa:"P a" by blast
  hence "(\<exists>x .P x)" by blast
  with assms show ?thesis by blast
qed

lemma exercise1d: assumes "\<not> (\<forall>x . P x)" shows "\<exists>x .\<not> P x"
proof -
  from assms obtain a where "\<not>P a" by blast
  hence "\<exists>x .\<not> P x" by blast
  thus ?thesis by blast
qed

lemma exercise1e: "(R\<longrightarrow>P)\<longrightarrow>(((\<not>R\<or>P)\<longrightarrow>(Q\<longrightarrow>S))\<longrightarrow>(Q\<longrightarrow>S))"
proof
  assume rtp:"(R\<longrightarrow>P)"
  show "((\<not>R\<or>P)\<longrightarrow>(Q\<longrightarrow>S))\<longrightarrow>(Q\<longrightarrow>S)"
  proof
    assume rtptqs:"((\<not>R\<or>P)\<longrightarrow>(Q\<longrightarrow>S))"
    show "Q\<longrightarrow>S"
    proof
      assume q:"Q"
      from rtp have nrop:"(\<not>R\<or>P)" by blast
      from rtptqs nrop have qts:"(Q\<longrightarrow>S)" by (rule mp)
      from qts q show "S" by blast
    qed
  qed
qed

lemma exercise2:"(\<forall>x.\<not> rich x \<longrightarrow> rich (father x)) \<longrightarrow>
                 (\<exists>x. rich (father (father x))\<and>rich x)"
proof
  assume e21:"(\<forall>x.\<not> rich x \<longrightarrow> rich (father x))"
  show "(\<exists>x. rich (father (father x))\<and>rich x)"
  proof -
    have "\<exists>x .rich x"
    proof (rule classical)
      fix a
      assume "\<not> (\<exists>x .rich x)"
      then have "\<forall>x.\<not> rich x" by blast
      then have "\<not> rich a" by blast
      with e21 have "rich (father a)" by blast
      then show ?thesis by blast
    qed
    then obtain x where x: "rich x" by blast
    show ?thesis
  proof cases
    assume "rich (father (father x))"
    with x show ?thesis by blast
  next
    assume e221n: "\<not> rich (father (father x))"
    with e21 have "rich (father (father (father x)))" by blast
    moreover have "rich (father x)"
    proof (rule classical)
      assume "\<not>rich (father x)"
      with e21 have "rich (father (father x))" by blast
      with e221n show ?thesis by contradiction
    qed
    ultimately show ?thesis by auto
  qed
qed


end