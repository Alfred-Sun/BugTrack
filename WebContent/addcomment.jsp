<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.util.*" errorPage="" %>
<%
String bugid=(String)request.getParameter("bugid");
String expertid=(String)request.getParameter("expertid");
String expert=(String)request.getParameter("expert");
String sol=(String)request.getParameter("sol");
try{
	Class.forName("org.mariadb.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
    					
	String insertquery = "insert into solutions values(?,?,?,?,?)" ;
	PreparedStatement prestmt = con.prepareStatement(insertquery);
    
	prestmt.setString(1,bugid);
    prestmt.setString(2,expertid);
    prestmt.setString(3,expert);
    prestmt.setString(4,sol);
    /* 
    Calendar cal = new GregorianCalendar();
    int year = cal.get(Calendar.YEAR);
//    System.out.println(year);
    int mm = cal.get(Calendar.MONTH);
    int dd = cal.get(Calendar.DAY_OF_MONTH);
    java.sql.Date date=new java.sql.Date(year, mm, dd); */
    Calendar today = Calendar.getInstance();
    java.util.Date udate = today.getTime();
    java.sql.Date date = new java.sql.Date(udate.getTime());
    System.out.println(date);
    prestmt.setDate(5,date);
   
    prestmt.executeUpdate();
    prestmt.close();
	con.close();
	
	RequestDispatcher rd=request.getRequestDispatcher("bugcomment.jsp?bugid="+bugid);
	rd.forward(request, response);
}catch(Exception e){System.out.println(e);
	RequestDispatcher rd=request.getRequestDispatcher("bugcomment.jsp?bugid="+bugid);
	rd.forward(request, response);
}
%>