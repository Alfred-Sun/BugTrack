<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*, java.text.* " errorPage="" %>

<div align="left">
<%	//show current date by US format
	DateFormat df=new SimpleDateFormat("EEEE, dd MMM, yyyy",new Locale("US"));
	String date=df.format(new java.util.Date());
	out.print("[ "+date+" ] ");
	String login = (String)session.getAttribute("login");
	if("yes".equals(login))
	out.print((String)session.getAttribute("user")+" | <a href=logout.jsp>Logout</a> |");
%></div>
<table bgcolor="#E9E9E9" align="center" width="100%">
<tr><td height="70">
<div align="center" class="head">BugTrack &nbsp; System</div></td></tr></table>
