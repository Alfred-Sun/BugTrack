<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Welcome to BugTrack/Expert</title>
<link href="mystyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table align="center" width="700" bgcolor="#FFFFFF">
<tr><td height="60">&nbsp;</td></tr>
<tr><td height="70"><jsp:include page="header.jsp"/></td></tr>
<tr><td><jsp:include page="menu.jsp"/></td></tr>
<tr><td height="300" valign="top">
<ul>
<li>This is the List of all Reported Bugs assigned to you.</li>
<li>Find out the possible causes, and try to fix it and provide satisfactory comments.</li>
</ul>
<table align="center" cellpadding="2" width="100%">
<tr bgcolor="#0054A8" class="whitetext" align="center" >
<td>Bug ID</td>
<td>Product</td>
<td>Environment</td>
<td>Type</td>
<td>Synopsis</td>
<td>Status</td>
<td>&nbsp;</td>
</tr>
<%
try{
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
	Statement stmt = con.createStatement();
	String query = "select * from bug where assign_to='"+(String)session.getAttribute("loginid")+"'";
	ResultSet rs = stmt.executeQuery(query);
	int i=2;
	while(rs.next()){
	if(i%2==0)
		out.println("<tr bgcolor=#CEE7FF>");
	else
		out.println("<tr bgcolor=#A8F35F >");
	i++;
	out.print("<td class=smalltext>"+rs.getString("bugid")+"</td>");
	out.print("<td class=smalltext>"+rs.getString("prodname")+"</td>");
	out.print("<td class=smalltext>"+rs.getString("env")+"</td>");
	out.print("<td class=smalltext>"+rs.getString("type")+"</td>");
	out.print("<td class=smalltext>");
	String des=rs.getString("description");
	if(des.length()>40)
		des=des.substring(0,40)+"...";
	out.println(des);
	out.print("</td>");
	out.print("<td class=smalltext>"+rs.getString("status")+"</td>");
	out.print("<td class=smalltext><a href='bugcomment.jsp?bugid="+rs.getString("bugid")+"'>Comment</a></td>");	
	out.println("</tr>");		
	}
	out.println("</table>");
	out.print("<div align=left> Total Bugs: "+(i-2)+"</div>");
	
	rs.close();
	stmt.close();
	con.close();
}catch(Exception e){
	System.out.print(e);
}  
%>
</td></tr>
<tr><td ><div align="center" class="greysmall"><hr />
All Rights are reserved by Alfred's Softwares HUST. Ltd.</div></td></tr>
</table>
</body>
</html>
