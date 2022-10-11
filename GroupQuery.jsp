<%@ page language="java" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.util.*"%>
<%
response.setHeader("Content-Type", "application/json;charset=UTF-8");
        String name=request.getParameter("name");
		String region=name.split("：")[0];
		String type=name.split("：")[1];
		String sql = null,tmp;
        LinkedList<String> result=new LinkedList<String>();
		switch(type)
        {
        case "宿舍":
        	tmp="dormitary";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "食堂":
        	tmp="cafe";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "篮球场":
        	tmp="basketball";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "网球场":
        	tmp="tennis";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "排球场":
        	tmp="volleyball";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "羽毛球场":
        	tmp="baminton";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "田径场":
        	tmp="athletic";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "图书馆":
        	tmp="library";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "医院":
        	tmp="hospital";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break;
        case "樱花林":
        	tmp="sakura";
        	switch(region)
        	{
        	case "全校":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+";";
        		break;
        	case "文理学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='文理学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "工学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='工学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "信息学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='信息学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	case "医学部":
        		sql="select st_asgeojson("+tmp+".geom) from "+tmp+",region where region.name='医学部' and st_contains(region.geom,"+tmp+".geom);";
        		break;
        	}
        	break; 
		default:
		        sql="select st_asgeojson(dormitary.geom) from dormitary;";                 
        }

		
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