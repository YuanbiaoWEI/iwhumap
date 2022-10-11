<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
		response.setHeader("Content-Type", "application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        boolean pwdflag=true,userflag=false;
        String name=request.getParameter("name");
        String pwd=request.getParameter("pwd");
        Connection connection = null;
        Statement statement =null;
        try{
            String DBLinkURL = "jdbc:postgresql://localhost:5432/whumap";//换成自己PostgreSQL数据库实例所在的ip地址，并设置自己的端口
            String user = "postgres";
            String password = "wyb3895115";
            Class.forName("org.postgresql.Driver");
            connection= DriverManager.getConnection(DBLinkURL, user, password); 
            String sql="select uname from userfootprint;";
            statement = connection.createStatement();
            ResultSet resultSet = statement.executeQuery(sql);
            while(resultSet.next())
            {
            	String tmp=resultSet.getString(1);
            	if(tmp.equals(name))
            	{
            		userflag=true;
            		break;
            	}
            }
            
            if(userflag==true)
            {
                String sql3="select password from userfootprint where uname= '"+name+"';";
                resultSet = statement.executeQuery(sql3);
                String tmpwd="";
                if(resultSet.next())
                {
                    tmpwd=resultSet.getString(1);
                }
                if(!tmpwd.equals(pwd))
                    out.println("2");
                else
                {
                    String sql4 ="select st_asgeojson(geom) from userfootprint where uname = '"+name+"';";
                    resultSet = statement.executeQuery(sql4);
                    StringBuffer finalresult=new StringBuffer();
                    if(resultSet.next()){
                    finalresult.append("{\"type\":\"FeatureCollection\",\n"
        		        + "\"features\":[\n");
                    finalresult.append("{\n\"type\":\"Feature\",\n"
    			        + "\"geometry\":\n");
    	            finalresult.append(resultSet.getString(1));
    	            finalresult.append("\n}]\n}");
    	            out.println(finalresult.toString());
                    }
                }
            }
            else
            {
            	out.println("1");
            }
            resultSet.close();
            statement.close();
            connection.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }//catch
%>