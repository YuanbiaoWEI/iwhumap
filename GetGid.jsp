<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
		response.setHeader("Content-Type", "application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        String geojsontext=request.getParameter("geojson");
        Connection connection = null;
        Statement statement =null;
        try{
            String DBLinkURL = "jdbc:postgresql://localhost:5432/whumap";//换成自己PostgreSQL数据库实例所在的ip地址，并设置自己的端口
            String user = "postgres";
            String password = "wyb3895115";
            Class.forName("org.postgresql.Driver");
            connection= DriverManager.getConnection(DBLinkURL, user, password); 
            String sql="select gid from userfootprint where st_asgeojson(geom) like \'%"+geojsontext+"%\';";
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            if(resultSet.next())
            {
            	out.println(resultSet.getInt(1));
            }
        }
        catch (Exception e){
            e.printStackTrace();
        }//catch
%>