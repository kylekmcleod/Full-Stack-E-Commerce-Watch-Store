<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>
<%
	String authenticatedUser = null;
	session = request.getSession(true);

	try
	{
		authenticatedUser = validateLogin(out,request,session);
	}
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser != null)
		response.sendRedirect("index.jsp");		// Successful login
	else
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
		session.setAttribute("loginMessage", "Invalid username/password."); // Set error message for incorrect login
%>


<%!
	String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;

		try 
		{
			getConnection();
			
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
			retStr = "";
			String sql = "SELECT userid, password FROM customer WHERE userid = ? AND password = ?;";
			PreparedStatement stmt = con.prepareStatement(sql);
			stmt.setString(1, username);
			stmt.setString(2, password);
			ResultSet rs = stmt.executeQuery();
			
			if (rs.next()) {
            retStr = rs.getString("userid");
        	}
		} 
		catch (SQLException ex) {
			out.println(ex);
		}
		finally {
			closeConnection();
		}	
		
		if(retStr != null && !retStr.isEmpty()) {	
			session.removeAttribute("loginMessage");
			session.setAttribute("authenticatedUser",username);
		} else {
			session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
		}
		return retStr;
	}
%>

