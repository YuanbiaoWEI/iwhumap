<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
		response.setHeader("Content-Type", "application/json;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        boolean keyflag=true,rpwdflag=true,userflag=true;
        //String result;
        String key=request.getParameter("key");
        String powerkey="20001110";
        if(!key.equals(powerkey))
            keyflag=false;
        String name=request.getParameter("name");
        String rpwd=request.getParameter("rpwd");
        String pwd=request.getParameter("pwd");
        System.out.println(key);
        System.out.println(name);
        System.out.println(rpwd);
        System.out.println(pwd);
        if(!rpwd.equals(pwd))
            rpwdflag=false;
        if(keyflag==false||rpwdflag==false)
        {
        	if(keyflag==false) 
        		out.println("授权码错误！");
        	else
        		out.println("确认密码错误！");
        }
        else {
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
            		userflag=false;
                    System.out.println("userflag=false;");
            		break;
            	}
            }
            
            if(userflag==true)
            {
                String sql3="select max(gid) from userfootprint;";
                resultSet = statement.executeQuery(sql3);
                int maxgid=0;
                if(resultSet.next())
                {
                    maxgid=resultSet.getInt(1);
                    maxgid=maxgid+1;
                }
                sql3="insert into userfootprint(gid,uname,password) values("+maxgid+",\'"+name+"\',\'"+pwd+"\');";
                statement.executeUpdate(sql3);
                out.println("注册成功");
            }
            else
            {
            	out.println("用户名已存在！");
            }
            resultSet.close();
            statement.close();
            connection.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }//catch
        }//if
%>