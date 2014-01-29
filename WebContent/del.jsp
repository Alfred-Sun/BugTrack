<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
String bugid=(String)request.getParameter("bugid");
try{
	Class.forName("org.mariadb.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
	Statement stmt = con.createStatement();
	String query = "delete from bug where bugid="+bugid;
	stmt.executeUpdate(query);
	query = "delete from solutions where bugid="+bugid;
	stmt.executeUpdate(query);
		RequestDispatcher rd=request.getRequestDispatcher("bugsadmin.jsp");
		rd.forward(request, response);
	}catch(Exception e){
		RequestDispatcher rd=request.getRequestDispatcher("bugsadmin.jsp");
		rd.forward(request, response);
	}
%>