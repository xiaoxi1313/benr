<%@page import="com.mysql.jdbc.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%

Class.forName("com.mysql.jdbc.Driver");   
Connection conn = DriverManager.getConnection("jdbc:mysql://rdsnnnbfm2eqvzz.mysql.rds.aliyuncs.com:3306/benran78fgsa391cf?user=benrandatabase&password=b4w2fd_4dsgee3dv3242fsth");   

Statement stmt = conn.createStatement();

String sql = "select id from tb_tag";
ResultSet rs = stmt.executeQuery(sql);
while(rs.next()) {
	long tagId = rs.getLong(1);
	
	String s2 = "select count(id) from tb_article_tag where tagId = " + tagId;
	ResultSet rs2 = stmt.executeQuery(s2);
	if(rs2.next()) {
		int t = rs2.getInt(1);
		
		stmt.execute("update tb_tag set articleNum = " + t + " where id = " + tagId);
	}
}

//tb_user;tb_role;

/*
String tables = "tb_admin_role;tb_annotate;tb_article;tb_article_favorite;tb_article_image;tb_article_tag;tb_category;tb_comment;tb_favorite;tb_menu;tb_query;tb_query_chart;tb_query_condition;tb_role_menu;tb_tag;tb_tag_category;tb_user_favorite;tb_user_log";

String[] t = tables.split(";");
for(String s : t) {
	stmt.execute("delete from " + s +" ;");
}
*/

//stmt.execute("INSERT INTO `tb_admin_role` VALUES ('1', '1', '2'), ('2', '3', '1'), ('3', '2', '3'), ('4', '2', '4'), ('5', '1', '5'), ('6', '4', '6'), ('8', '3', '7'), ('15', '4', '8');");

//stmt.execute("alter table tb_category modify alias varchar(256);");

//stmt.execute("CREATE TABLE `tb_article_praise` (`id` int(19) NOT NULL AUTO_INCREMENT,`articleId` int(19) NOT NULL,`userId` int(19) NOT NULL, `type` int(10) NOT NULL,`creaeTime` datetime NOT NULL,PRIMARY KEY (`id`) ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;");

//out.print("success");

%>