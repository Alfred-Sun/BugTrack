<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="mail.SendMail" import="java.sql.*" errorPage="" %>
<%
String bugid=(String)request.getParameter("bugid");
String priority=(String)request.getParameter("priority");
String status=(String)request.getParameter("status");
String assign_to=(String)request.getParameter("assign_to");
System.out.print(bugid+" "+priority+" "+status+" "+assign_to);

try{
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
	Statement stmt = con.createStatement();
	String query = "Update bug set priority='"+priority+"', status='"+status+"', assign_to='"+assign_to+"' where bugid="+bugid;
	stmt.executeUpdate(query);
	//execute email operation to the responsible experts
	ResultSet rs = stmt.executeQuery("select * from login where loginid='"+assign_to+"' and type='Expert'");
	String email = null;
	while(rs.next()){
		email = rs.getString("email");
	}%>
<%-- <jsp:useBean id="mybean" scope="session" class="SendMail" />
<jsp:setProperty name = "mybean" property = "*" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
</head>
<body>
<form name="form" method="post" action="SendMail">
<input type="hidden" name="assign_to" value="<%=assign_to%>"/>
<input type="hidden" name="emailname" value="<%=email%>"/>
<input type="hidden" name="bugid" value="<%=bugid%>"/>
</form>--%>
<%  //send e-mail to expert
	if(status.equals("Assigned")) {
		SendMail mail0 = new SendMail(assign_to, email, bugid);
	}
	RequestDispatcher rd=request.getRequestDispatcher("updatebug.jsp?bugid="+bugid);
	rd.forward(request, response);
	rs.close();
	stmt.close();
	con.close();
	}catch(Exception e){
		RequestDispatcher rd=request.getRequestDispatcher("updatebug.jsp?bugid="+bugid);
		rd.forward(request, response);
	}
%>

