import java.io.IOException;
import javax.servlet.RequestDispatcher;
import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;

public class Login extends HttpServlet {
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		String loginid=request.getParameter("loginid");
		String password=request.getParameter("password");
		String type=request.getParameter("type");
		boolean flag=false;
		try{
			//load JDBC's driver
			Class.forName("org.mariadb.jdbc.Driver");
			//create connection to MariaDB
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3307/bugtrack?user=root&password=123456&userUnicode=true&characterEncoding=8859_1");
		   	//create statement object and SQL to execute
		    Statement stmt = con.createStatement();
		   	String query = "select * from login where loginid ='" + loginid + "' and type='"+type+"'";
		   	ResultSet rs = stmt.executeQuery(query);
			while(rs.next())
			{
				String pass= rs.getString("password");
			 	if( pass.equals(password)) {
					flag=true;
					break;
				}		
			}	
			if (flag){
			
				HttpSession session=request.getSession();
				session.setAttribute("login", "yes");
				session.setAttribute("type", rs.getString("type"));
				session.setAttribute("user", rs.getString("name"));
				session.setAttribute("loginid", rs.getString("loginid"));
				RequestDispatcher rd=null;
				if("Admin".equals(type))
					rd=request.getRequestDispatcher("admin.jsp");
				else if("Expert".equals(type))
					rd=request.getRequestDispatcher("expert.jsp");
				else if("User".equals(type))
					rd=request.getRequestDispatcher("user.jsp");
				//pack the object of request and response, and forward to other page
				rd.forward(request, response);
			}
			else{
				RequestDispatcher rd=request.getRequestDispatcher("login.jsp?msg=loginerror");
				rd.forward(request, response);
			}
			rs.close();
			stmt.close();
			con.close();
		}catch(Exception e){
			
		}
	}
}
