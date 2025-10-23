import java.util.List;
import java.util.ArrayList;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseAPI{
protected String url = "jdbc:mysql://127.0.0.1:3306/wmarket";
protected String user = "root";
protected String password = "12345678";
private Connection conn = null;
private Statement stmt = null;
protected ResultSet stream = null;
private boolean RetainStream = false;
private List<Statement> retained_statements = new ArrayList<>();
private List<ResultSet> retained_streams = new ArrayList<>();

public void sqlCloseStream(){
    try{
if(stream!=null){
stream.close();
stream=null;
}
if(stmt!=null){
stmt.close();
stmt=null;
}
    }catch(Exception e){}

}

public void sqlCloseConn(){
    try{
if(conn!=null){
conn.close();
conn=null;
}
    }catch(Exception e){}
}

public void sqlCloseAll(){
try{
    for(int i=0;i<retained_statements.size();++i){
    retained_statements.get(i).close();
    retained_streams.get(i).close();
    retained_statements.remove(i);
    retained_streams.remove(i);
    }
}catch(Exception e){}

sqlCloseStream();
sqlCloseConn();
}

public void sqlRetainStream(boolean value){
RetainStream = value;
}

public ResultSet sqlGetStream(String cmd){
       try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           if(!RetainStream){
           //sqlCloseStream();
           }else{
           retained_statements.add(stmt);
           retained_streams.add(stream);
           }
           if(conn==null){
           conn = DriverManager.getConnection(url,user,password);
           }
           stmt = conn.createStatement();
           stream = stmt.executeQuery(cmd);

       }catch(ClassNotFoundException e){//no driver found

       }catch(SQLException e){//can not connect to database

       }
return stream;
}

public boolean sqlPostStream(String cmd){
       try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           if(conn==null){
           conn = DriverManager.getConnection(url,user,password);
           }
           stmt = conn.createStatement();
           stmt.executeUpdate(cmd);
           stmt.close();
           return true;
       }catch(ClassNotFoundException e){//no driver found

       }catch(SQLException e){//can not connect to database

       }
       return false;
}

}
