<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Welcome to BugTrack/Authentication Error</title>
<link href="mystyle.css" rel="stylesheet" type="text/css" />
</head>
<body>
<table align="center" width="700" bgcolor="#FFFFFF">
<tr><td height="60">&nbsp;</td></tr>
<tr><td height="70"><jsp:include page="header.jsp"/></td></tr>
<tr><td><jsp:include page="menu.jsp"/></td></tr>
<tr><td height="300" align="center" valign="top"><p>&nbsp;</p>
<div align="center">
<div class="errortext">You are not authorized to view this page.</div><br/> 
Your have been logged as some other type of User Accounts. <br/> Re-Login after current user <a href="logout.jsp">Logout</a></div>
<br/><br/><p><img src="images/red-bug.png" alt="bug" width="200" height="113" /></p></td></tr>
<tr><td ><div align="center" class="greysmall"><hr />
All Rights are reserved by Alfred's Softwares HUST. Ltd.</div></td></tr>
</table>
</body>
</html>
