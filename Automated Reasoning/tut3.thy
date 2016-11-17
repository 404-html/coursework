theory tut3 
imports
Main

begin

locale Geom =
  fixes on :: "'p \<Rightarrow> 'l \<Rightarrow> bool"
  assumes line_on_two_pts: "a \<noteq> b \<Longrightarrow> \<exists>l. on a l \<and> on b l" 
  and line_on_two_pts_unique: "\<lbrakk> a \<noteq> b; on a l; on b l; on a m; on b m \<rbrakk> \<Longrightarrow> l = m"
  and two_points_on_line: "\<exists>a b. a \<noteq> b \<and> on a l \<and> on b l"
  and three_points_not_on_line: "\<exists>a b c. a \<noteq> b \<and> a \<noteq> c \<and> b \<noteq> c \<and> \<not> (\<exists>l. on a l \<and> on b l \<and> on c l)"
begin


lemma exists_pt_not_on_line: "\<exists>x. \<not> on x l"
proof -
   obtain a b c where l3: "\<not> (on a l \<and> on b l \<and> on c l)" using three_points_not_on_line by blast 
   thus ?thesis by blast 
qed

lemma two_lines_through_each_point: "\<exists>l m. \<forall>x. on x l \<and> on x m \<longrightarrow> l \<noteq> m"
proof -
  obtain w x l where wl: "on w l" and xl: "on x l" 
       using two_points_on_line  by blast
  obtain z where n_zl: "\<not> on z l" using exists_pt_not_on_line by blast 
  obtain m where wm: "on w m" and zm: "on z m" using line_on_two_pts wl by force 
  have "l \<noteq> m" using n_zl zm by blast 
  thus ?thesis using  wl wm by blast
qed

lemma two_lines_unique_intersect_pt: 
   assumes lm: "l \<noteq> m" and "on x l" and "on x m" and "on y l" and "on y m" shows "x = y"
proof (rule ccontr)
   assume "x \<noteq> y" then have "l = m" using line_on_two_pts_unique assms by simp
   thus "False" using lm by simp
qed
 

end
   