<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
		response.setHeader("Content-Type", "application/json;charset=UTF-8");
        String name=request.getParameter("name");
        StringBuffer namestring=new StringBuffer();
        LinkedList<String> result=new LinkedList<String>();
        for(int i=0;i<name.length();i++)
        {
        	namestring.append('%');
        	namestring.append(name.charAt(i));
        }
        namestring.append('%');
        ArrayList<String> tablelist=new ArrayList<String>();
		tablelist.add("art_building");
		tablelist.add("athletic");
		tablelist.add("baminton");
		tablelist.add("basketball");
		tablelist.add("cafe");
		//tablelist.add("cycleway");
		tablelist.add("dormitary");
		//tablelist.add("footway");
		tablelist.add("grassland");
		tablelist.add("hospital");
		tablelist.add("hotel_building");
		tablelist.add("library");
		tablelist.add("living_building");
		//tablelist.add("living_street");
		tablelist.add("market");
		tablelist.add("office_building");
		tablelist.add("other_building");
		//tablelist.add("other_forest");
		//tablelist.add("path");
		//tablelist.add("pedestrian");
		tablelist.add("playground");
		tablelist.add("pool");
		//tablelist.add("primary_");
		tablelist.add("region");
		//tablelist.add("residential");
		tablelist.add("sakura");
		//tablelist.add("secondary");
		//tablelist.add("service");
		tablelist.add("sport_building");
		//tablelist.add("steps");
		tablelist.add("swimming_pool");
		tablelist.add("teach_building");
		tablelist.add("tennis");
		//tablelist.add("tertiary");
		//tablelist.add("trunk");
		tablelist.add("volleyball");
		
		Connection connection = null;
        Statement statement =null;
        try{
            String DBLinkURL = "jdbc:postgresql://localhost:5432/whumap";//换成自己PostgreSQL数据库实例所在的ip地址，并设置自己的端口
            String user = "postgres";
            String password = "wyb3895115";
            Class.forName("org.postgresql.Driver");
            connection= DriverManager.getConnection(DBLinkURL, user, password); //
            //out.println("是否成功连接pg数据库"+connection);
            //select * from region 
            //where st_contains(region.geom,st_setsrid(st_makepoint(114.36356432035156,30.53719883757822),4326));
            for(int i=0;i<tablelist.size();i++)
            {
            	String sql ="select st_asgeojson(geom) from "+tablelist.get(i)+" where name like '"+namestring.toString()+"';";
                statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);
                while(resultSet.next()){//取出列值
                	result.add(resultSet.getString(1));
                }
                resultSet.close();
                statement.close();
            }
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