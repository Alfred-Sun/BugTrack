<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Welcome to BugTrack/Expert/Comments</title>
<link href="mystyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table align="center" width="700" bgcolor="#FFFFFF">
<tr><td height="60">&nbsp;</td></tr>
<tr><td height="70"><jsp:include page="header.jsp"/></td></tr>
<tr><td><jsp:include page="menu.jsp"/></td></tr>
<tr><td height="300" valign="top">
<p>&nbsp;</p>
<table align="center" cellpadding="2" width="600" cellspacing="4">
<tr bgcolor="#0054A8" class="whitetext" align="center">
<td colspan="4">Your Bug Detail</td></tr>
<%
try{
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
	Statement stmt = con.createStatement();
	String query = "select * from bug where bugid="+(String)request.getParameter("bugid");
	ResultSet rs = stmt.executeQuery(query);
	while(rs.next()){
	out.print("<tr><td bgcolor=#F2F2F2>Bug ID:</td><td>"+rs.getString("bugid")+"</td><td bgcolor=#F2F2F2>Author:</td><td>"+rs.getString("author")+"</td></tr>");
	out.print("<tr><td bgcolor=#F2F2F2>Product Name:</td><td colspan=3>"+rs.getString("prodname")+"</td></tr>");
	out.print("<tr><td bgcolor=#F2F2F2>Environment:</td><td>"+rs.getString("env")+"</td><td bgcolor=#F2F2F2>Type:</td><td>"+rs.getString("type")+"</td></tr>");
	out.print("<tr><td colspan=1 bgcolor=#F2F2F2>Description:</td></tr>");	
	out.print("<tr><td colspan=4 >"+rs.getString("description")+"</td></tr>");
	out.print("<tr><td bgcolor=#F2F2F2>Priority:</td><td colspan=3>"+rs.getString("priority")+"</td></tr>");
	out.print("<tr><td bgcolor=#F2F2F2>Status:</td><td>"+rs.getString("status")+"</td><td bgcolor=#F2F2F2>Responsible:</td><td>"+rs.getString("assign_to")+"</td></tr>");
	}
	rs.close();
	stmt.close();
	con.close();
}catch(Exception e){
	System.out.print(e);
}
%>
<tr><td colspan="4">Expert's Comments/Solutions:</td></tr>
<tr><td colspan="4">
<form name="form" method="post" action="addcomment.jsp">
<textarea cols="60" rows="4" class="inputtext" name="sol"></textarea>
<input type="hidden" name="bugid" value="<%=(String)request.getParameter("bugid")%>" />
<input type="hidden" name="expertid" value="<%=session.getAttribute("loginid")%>" />
<input type="hidden" name="expert" value="<%=session.getAttribute("user")%>" /><br /><br />
<div align="center"><input type="submit" value="Add Your Comment" /></div>
</form>
</td></tr>
</table>
<table align="center" cellpadding="2" width="600" cellspacing="4">
<tr><td colspan="2" bgcolor="#0054A8" class="whitetext">Audit Trail:</td></tr>
<tr bgcolor=#F2F2F2><td class="smalltext" width="150"><em>Expert</em></td><td class="smalltext"><em>Comments</em></td></tr>
<%
try{
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
	Statement stmt = con.createStatement();
	String query = "select * from solutions where bugid="+(String)request.getParameter("bugid");
	ResultSet rs = stmt.executeQuery(query);
	while(rs.next()){
	out.print("<tr>");
	out.print("<td class=smalltext>"+rs.getString("expert")+"</td>");
	out.print("<td class=smalltext>"+rs.getString("soln")+"</td>");
	out.print("</tr>");	
	}
	rs.close();
	stmt.close();
	con.close();
}catch(Exception e){
	System.out.print(e);
}  
%>
</table>
<div align="center"><hr width="100" /><a href="expert.jsp">Back</a><hr width="100" /></div>
</td></tr>
<tr><td ><div align="center" class="greysmall"><hr />
All Rights are reserved by Alfred's Softwares HUST. Ltd.</div></td></tr>
</table>
</body>
</html>
