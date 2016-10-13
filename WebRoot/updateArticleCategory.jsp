<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%

Class.forName("com.mysql.jdbc.Driver");   
Connection conn = DriverManager.getConnection("jdbc:mysql://rdsnnnbfm2eqvzz.mysql.rds.aliyuncs.com:3306/benran78fgsa391cf?user=benrandatabase&password=b4w2fd_4dsgee3dv3242fsth");  
//Connection conn = DriverManager.getConnection("jdbc:mysql://180.168.135.54:3306/benr?user=root&password=youren123");  

Statement stmt = conn.createStatement();

String sql = "select id,parentCategoryId,childCategoryId from tb_article where parentCategoryName is null and  (parentCategoryId > 0 or childCategoryId>0)";
out.println(sql);
ResultSet rs = stmt.executeQuery(sql);
int i = 1;
while(rs.next()) {
	long articleId = rs.getLong(1);
	String parentCategoryId = rs.getString(2);
	String childCategoryId = rs.getString(3);
	
	ResultSet rs2 = conn.createStatement().executeQuery("select name from tb_category where id = " + parentCategoryId);
	String parentCategoryName = "";
	if(rs2.next()) {
		parentCategoryName = rs2.getString(1);
	}
	rs2.last();
	
	ResultSet rs3 = conn.createStatement().executeQuery("select name from tb_category where id = " + childCategoryId);
	String childCategoryName = "";
	if(rs3.next()) {
		childCategoryName = rs3.getString(1);
	}
	
	conn.createStatement().execute("update tb_article set parentCategoryName = '" + parentCategoryName + "',childCategoryName='"+childCategoryName+"' where id = " + articleId);
	i++;
	//out.println("update tb_article set parentCategoryName = '" + parentCategoryName + "',childCategoryName='"+childCategoryName+"' where id = " + articleId);
}

out.print(i);
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