import java.util.List;
import java.util.ArrayList;

public class UserManager extends DatabaseAPI{
public List<User> login_users = new ArrayList<>();
public List<Integer> logout_users = new ArrayList<>();
public List<Tinhthanh> provinces = new ArrayList<>();
private int error_code;
public Enigma secure = new Enigma();


private void checkDuplication(String email,String number){

this.error_code=0;//reset error state
sqlGetStream("select id from users where email = '"+email+"'");
try{
if(this.stream.next()){
  this.error_code=3;
}
sqlGetStream("select id from users where number = '"+number+"'");
if(this.stream.next()){
  this.error_code=4;
}
}catch(Exception e){}

sqlCloseAll();
}

public int getError(){
return this.error_code;
}

public void loadProvinces(){
try{
sqlGetStream("select * from provinces");
  while(this.stream.next()){
    provinces.add(new Tinhthanh(this.stream.getInt("id"),this.stream.getString("name"),this.stream.getInt("weight")));
  }
}catch(Exception e){}
sqlCloseAll();
}

public User getUserByCookie(int index,String cookie){
String incookie = secure.getEncryption(cookie);
    if(login_users.get(index).GetCookie().equals(incookie)){
        return login_users.get(index);
    }
return null;
}

public void logOut(int index){
if(index==login_users.size()-1){
login_users.set(index,null);
login_users.remove(index);
}else{
login_users.get(index).SetCookie("");
logout_users.add(index);
}
}

public void signUp(String name,String age,String address,String email,String number,String password){

checkDuplication(email,number);

if(this.error_code==0){
    String outpassword = secure.getEncryption(password);
//CREATE USER INFORMATION
    if(sqlPostStream("insert into users (name,age,address,email,number,password) values ('"+name+"',"+age+",'"+address+"','"+email+"','"+number+"','"+outpassword+"')")){
     sqlCloseStream();
     //CREATE USER ASSETS
        if(sqlPostStream("insert into assets (tobuy,tosell,toship,totake) values (NULL,NULL,NULL,NULL)")){
        sqlCloseStream();
        //CREATE USER BALANCE SHEET
            if(sqlPostStream("insert into balances (sold,revenue,profit,debt) values (0,0,0,0)")){
            sqlCloseStream();
            }else{
            this.error_code=1;
            }
        }else{
        this.error_code=1;
        }
    }else{
    this.error_code=1;
    }


}
sqlCloseAll();
}

public int signIn(String email,String password,String session_token){

    this.error_code=0;//reset error state
    String inpassword = secure.getEncryption(password);

    sqlGetStream("select id,password from users where email = '"+email+"'");
    try{
if(this.stream.next()){
  if(this.stream.getString("password").equals(inpassword) || this.stream.getString("password").equals(" ")){//user exists

    if(logout_users.size()>0){

    int free_index = logout_users.get(logout_users.size()-1);
    logout_users.remove(logout_users.size()-1);
    User updated_user = login_users.get(free_index);
    //setup new values for old user memory
    updated_user.SetId(this.stream.getInt("id"));
    updated_user.SetCookie(secure.getEncryption(session_token));
    sqlCloseAll();
    //return login index
    return free_index;
    }else{
    login_users.add(new User(this.stream.getInt("id"),secure.getEncryption(session_token)));
    sqlCloseAll();
    //return login index
    return login_users.size()-1;
    }

  }
}else{
this.error_code=2;//no such username
}
    }catch(Exception e){
    this.error_code=1;
    }
sqlCloseAll();
//no login index
return -1;
}

public String getUserNameById(int uid){
String value="";
sqlGetStream("select name from users where id = "+uid);
try{
if(this.stream.next()){
value = this.stream.getString("name");
}
}catch(Exception e){}
sqlCloseAll();
return value;
}

public String getUserAddressById(int uid){
String value="";
sqlGetStream("select address from users where id = "+uid);
try{
if(this.stream.next()){
value = this.stream.getString("address");
}
}catch(Exception e){}
sqlCloseAll();
return value;
}

public String getUserEmailById(int uid){
String value="";
sqlGetStream("select email from users where id = "+uid);
try{
if(this.stream.next()){
value = this.stream.getString("email");
}
}catch(Exception e){}
sqlCloseAll();
return value;
}

public String getUserNumberById(int uid){
String value="";
sqlGetStream("select number from users where id = "+uid);
try{
if(this.stream.next()){
value = this.stream.getString("number");
}
}catch(Exception e){}
sqlCloseAll();
return value;
}

}
