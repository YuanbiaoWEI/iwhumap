<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
        response.setHeader("Content-Type", "application/json;charset=UTF-8");
        String sql=request.getParameter("name");
		Connection connection = null;
        Statement statement =null;
        LinkedList<String> result=new LinkedList<String>();
        try{
            String DBLinkURL = "jdbc:postgresql://localhost:5432/whumap";//换成自己PostgreSQL数据库实例所在的ip地址，并设置自己的端口
            String user = "postgres";
            String password = "wyb3895115";
            Class.forName("org.postgresql.Driver");
            connection= DriverManager.getConnection(DBLinkURL, user, password); //
            //out.println("是否成功连接pg数据库"+connection);
            //select * from region 
            //where st_contains(region.geom,st_setsrid(st_makepoint(114.36356432035156,30.53719883757822),4326));
                statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);
                while(resultSet.next()){//取出列值
                	result.add(resultSet.getString(1));
                }
                resultSet.close();
                statement.close();
            connection.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
         StringBuffer finalresult=new StringBuffer();
        finalresult.append("{\"type\":\"FeatureCollection\",\n"
        		+ "\"features\":[\n");
        finalresult.append("{\n\"type\":\"Feature\",\n"
    			+ "\"geometry\":\n");
    	finalresult.append(result.get(0));
    	finalresult.append("\n},");
        for(int i=1;i<result.size()-1;i++)
        {
        	finalresult.append("\n{\n\"type\":\"Feature\",\n"
        			+ "\"geometry\":\n");
        	finalresult.append(result.get(i));
        	finalresult.append("\n},");
        }
        finalresult.append("\n{\n\"type\":\"Feature\",\n"
    			+ "\"geometry\":\n");
    	finalresult.append(result.getLast());
    	finalresult.append("\n}");
        finalresult.append("\n]}");
        out.println(finalresult.toString());
%>
