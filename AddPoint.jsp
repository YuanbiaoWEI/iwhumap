<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
		response.setHeader("Content-Type", "application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String gid=request.getParameter("gid");
        String point=request.getParameter("point");
        Connection connection = null;
        Statement statement =null;
        try{
            String DBLinkURL = "jdbc:postgresql://localhost:5432/whumap";//换成自己PostgreSQL数据库实例所在的ip地址，并设置自己的端口
            String user = "postgres";
            String password = "wyb3895115";
            Class.forName("org.postgresql.Driver");
            connection= DriverManager.getConnection(DBLinkURL, user, password); 
            String sql=
            "update userfootprint set geom=("+
	        "SELECT ST_points("+
		    "ST_ADDPoint("+
			"ST_LineFromMultiPoint("+
				"(select geom from userfootprint where gid="+gid+")"+
			"), ST_MakePoint("+point+"))))"+
			"where gid="+gid+";";

            statement = connection.createStatement();
            statement.executeUpdate(sql);
        }
        catch (Exception e){
            e.printStackTrace();
        }//catch
%>