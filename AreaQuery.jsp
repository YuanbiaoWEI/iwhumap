<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<html>
<body>
<h3>
<%
        String co=request.getParameter("coordinary");
        ArrayList<String> tablelist=new ArrayList<String>();
		tablelist.add("art_building");
		tablelist.add("athletic");
		tablelist.add("baminton");
		tablelist.add("basketball");
		tablelist.add("cafe");
		//tablelist.add("cycleway");
		tablelist.add("dormitary");
		//tablelist.add("footway");
		//tablelist.add("grassland");
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
		//tablelist.add("playground");
		tablelist.add("pool");
		//tablelist.add("primary_");
		//tablelist.add("region");
		//tablelist.add("residential");
		//tablelist.add("sakura");
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
            	String sql ="select st_area(geom) from "+tablelist.get(i)+" where st_contains("+tablelist.get(i)+".geom,st_setsrid(st_makepoint("+co+"),4326));";
                statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery(sql);
                while(resultSet.next()){//取出列值
					Double a=resultSet.getDouble(1);
					a=a*100000000;
					a*=10;
                	out.println(a);
                }
                resultSet.close();
                statement.close();
            }
            connection.close();
        }
        catch (Exception e){
            e.printStackTrace();
        }
%>
</h3>
</body>
</html>