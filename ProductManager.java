import java.util.List;
import java.util.ArrayList;
import java.sql.ResultSet;
import java.nio.ByteBuffer;

public class ProductManager extends DatabaseAPI{
public List<Danhmuc> categories = new ArrayList<>();
private int error_code;
public int safe_to_render=0;

public int getError(){
return this.error_code;
}

public int getProductCount(){
sqlGetStream("select count(*) from products");
int value=-1;
try{
   if(this.stream.next()){
    value = this.stream.getInt("count(*)");
   }
}catch(Exception e){}
sqlCloseAll();
return value;
}

private int getMaxId(String table){
sqlGetStream("select max(id) as max_id from "+table);
int value=-1;
try{
   if(this.stream.next()){
    value = this.stream.getInt("max_id");
   }
}catch(Exception e){}
sqlCloseAll();
return value;
}

public void loadCategories(){
sqlGetStream("select * from categories");
try{
  while(this.stream.next()){
    categories.add(new Danhmuc(this.stream.getInt("id"),this.stream.getString("name")));
  }
}catch(Exception e){}
sqlCloseAll();
}

public ResultSet getRandomProduct(int limit){
return sqlGetStream("select id,name,image,sell_price,rating from products order by rand() limit "+limit);
}

public ResultSet getProductFrom(User uid){
String list = uid.GetSellList();
return sqlGetStream("select * from products where id in ("+list+")");
}

public ResultSet getCartFrom(User uid){
String list = uid.GetBuyList();
if(list!=""){
return sqlGetStream("select * from products where id in ("+list+")");
}else{
return null;
}
}

public ResultSet getOrderFrom(User uid){
String list = uid.GetShipList();
if(list!=""){
return sqlGetStream("select * from orders where id in ("+list+")");
}else{
return null;
}
}

public ResultSet getProductDetail(String pid){
return sqlGetStream("select * from products where id = "+pid);
}

public String getProductSpecific(String pid,String column){
sqlGetStream("select "+column+" from products where id = "+pid);
try{
if(this.stream.next()){
    String value = this.stream.getString(column);
    sqlCloseAll();
    return value;
}
}catch(Exception e){}
sqlCloseAll();
return null;
}

public boolean addProduct(String name,String description,String image,String buy_price,String sell_price,String category,String brand,String condition,String payment,String transport,String quantity,User myuser){
int province = myuser.GetProvince();
if(province > 0){
int pid = 0;

if(true){
  if(!sqlPostStream("insert into products (name,description,image,buy_price,sell_price,category,brand,cond,payment,transport,quantity,shopid,province) values ('"+name+"','"+description+"','"+image+"',"+buy_price+","+sell_price+","+category+",'"+brand+"',"+condition+","+payment+","+transport+","+quantity+","+myuser.GetId()+","+province+")")){
  this.error_code=1;
  return false;
  }
  pid = getMaxId("products");
if(pid>0){
  //add new products into sell list
  myuser.AddSell(pid);
  safe_to_render=pid;
  return true;
}
}
}
sqlCloseAll();
return false;//CHUA XAC NHAN TINH THANH
}


public void editProduct(String name,String description,String image,String buy_price,String sell_price,String category,String brand,String condition,String payment,String transport,String quantity,String pid){//edit based on id
//prepare string query

boolean ccount=false;

  if(name!=""){
  name="name = '"+name+"'";
  ccount=true;
  }if(description!=""){
  description="description = '"+description+"'";
     if(ccount){
  description=","+description;
     }
  ccount=true;
  }if(image!="" && !image.equals("img/")){
  image="image = '"+image+"'";
     if(ccount){
  image=","+image;
     }
  ccount=true;
  }else{
  image="";
  }
  if(buy_price!=""){
  buy_price="buy_price = "+buy_price;
     if(ccount){
  buy_price=","+buy_price;
     }
  ccount=true;
  }if(sell_price!=""){
  sell_price="sell_price = "+sell_price;
     if(ccount){
  sell_price=","+sell_price;
     }
  ccount=true;
  }if(category!=""){
  category="category = "+category;
     if(ccount){
  category=","+category;
     }
  ccount=true;
  }if(brand!=""){
  brand="brand = '"+brand+"'";
    if(ccount){
  brand=","+brand;
    }
  ccount=true;
  }if(condition!=""){
  condition="cond = "+condition;
     if(ccount){
  condition=","+condition;
     }
  ccount=true;
  }if(payment!=""){
  payment="payment = "+payment;
     if(ccount){
  payment=","+payment;
     }
  ccount=true;
  }if(transport!=""){
  transport="transport = "+transport;
     if(ccount){
  transport=","+transport;
     }
  }if(quantity!=""){
  quantity="quantity = "+quantity;
     if(ccount){
  quantity=","+quantity;
     }
  }
sqlPostStream("update products set "+name+description+image+buy_price+sell_price+category+brand+condition+payment+transport+quantity+" where id = "+pid);
sqlCloseAll();
}

public ResultSet searchProduct(String name,String category,String brand,String location,String min_price,String max_price,String condition,String rating,String payment,String transport){
//prepare string query

boolean ccount=false;

  if(name!=""){
  name="name like '%"+name+"%'";
  ccount=true;
  }if(category!=""){
  category="category = "+category;
     if(ccount){
  category=" && "+category;
     }
  ccount=true;
  }if(brand!=""){
  brand="brand = '"+brand+"'";
    if(ccount){
  brand=" && "+brand;
    }
  ccount=true;
  }if(location!=""){
  location="province = "+location;
     if(ccount){
  location=" && "+location;
     }
  ccount=true;
  }if(min_price!=""){
  min_price="sell_price >= "+min_price;
     if(ccount){
  min_price=" && "+min_price;
     }
  ccount=true;
  }if(max_price!=""){
  max_price="sell_price <= "+max_price;
     if(ccount){
  max_price=" && "+max_price;
     }
  ccount=true;
  }if(condition!=""){
  condition="cond = "+condition;
     if(ccount){
  condition=" && "+condition;
     }
  ccount=true;
  }if(rating!=""){
  rating="rating = "+rating;
     if(ccount){
  rating=" && "+rating;
     }
  ccount=true;
  }if(payment!=""){
  payment="payment = "+payment;
     if(ccount){
  payment=" && "+payment;
     }
  ccount=true;
  }if(transport!=""){
  transport="transport = "+transport;
     if(ccount){
  transport=" && "+transport;
     }
  }
return sqlGetStream("select id,name,image,sell_price,rating from products where "+name+category+brand+location+min_price+max_price+condition+rating+payment+transport);
}

public void deleteProduct(String pid,User myuser){
sqlPostStream("delete from products where id = "+pid);
sqlCloseAll();
myuser.RemoveSell(pid);
}

public void deleteCart(String pid,User myuser){
myuser.RemoveBuy(pid);
}

    public void addShip(int order,String shopid){
    sqlGetStream("select toship from assets where id = "+shopid);
    try{
    if(this.stream.next() && this.stream.getString("toship") != null){
    sqlCloseStream();
    sqlPostStream("update assets set toship = concat(toship,'"+order+",') where id = "+shopid);
    }else{
    sqlCloseStream();
    sqlPostStream("update assets set toship = '"+order+",' where id = "+shopid);
    }
    }catch(Exception e){}
    sqlCloseAll();
    }

public void buyNow(String pid,User myuser,String shopid){
 sqlPostStream("insert into orders (pid,buyer,state) values ("+pid+","+myuser.GetId()+",0)");
 sqlCloseAll();
 int new_order = getMaxId("orders");
myuser.AddTake(new_order);
addShip(new_order,shopid);
}


}
