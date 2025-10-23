import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.Part;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.annotation.MultipartConfig;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import java.time.LocalDateTime;
import java.sql.ResultSet;


@WebServlet("/home")
@MultipartConfig

public class server extends HttpServlet{

//ProductManager system = new ProductManager();
//CategoryManager catalist = new CategoryManager();
UserManager user_manager = new UserManager();
ProductManager product_manager = new ProductManager();

int TOKEN_TIMEOUT = 60;
int MAX_PRODUCT_DISPLAYED = 32;
String WEB_DOMAIN = "127.0.0.1";
String WEB_ABS_PATH;

private int current_time=0;
private boolean wait_sync = true;

private void memory_free(){
   int dt;
   for(int i=0;i<user_manager.login_users.size();++i){
dt = current_time - user_manager.login_users.get(i).GetLastTime();
if(dt < 0){//midnight cycle reset to find delta time using arithmetic offset
dt+=719;
}
      if(dt > TOKEN_TIMEOUT){//compare delta time with expire minute
         user_manager.logOut(i);
      }
   }
}

private void updateTime(){
LocalDateTime now = LocalDateTime.now();
current_time = now.getHour()*60+now.getMinute();//total unit time
}

private void delete_file(String path){
File file = new File(path);
file.delete();
}

private void save_file(Part file,String filename){
    try(FileOutputStream outfile = new FileOutputStream(filename)){
    InputStream data = file.getInputStream();
    byte[] image = data.readAllBytes();
    data.close();
        outfile.write(image);
        outfile.close();
    }catch(IOException e){}
}

@Override
public void init(){
WEB_ABS_PATH = getServletContext().getRealPath("/");
//cap nhat danh muc
product_manager.loadCategories();
product_manager.safe_to_render=product_manager.getProductCount();
//cap nhat tinh thanh
user_manager.loadProvinces();
}

@Override
protected void doGet(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{
RequestDispatcher dispatcher;

Cookie[] cookie_list = request.getCookies();
User my_user = null;

    if(cookie_list!=null){                    //KIEM TRA COOKIE
int index=0;
String token="";
    for(Cookie cookie : cookie_list){
            if(cookie.getName().equals("index")){
     index = Integer.parseInt(cookie.getValue());//index
            }else if(cookie.getName().equals("token")){
     token = cookie.getValue();
     break;
            }
    }

            if(index<user_manager.login_users.size()){
            my_user = user_manager.getUserByCookie(index,token);
            }

    }

if(my_user!=null){                       //TRUY CAP THANH CONG

   request.setAttribute("product_manager",product_manager);
   request.setAttribute("user_manager",user_manager);
   request.setAttribute("product_categories",product_manager.categories);
   request.setAttribute("user_locations",user_manager.provinces);
   request.setAttribute("myuser",my_user);

if(request.getParameterMap().isEmpty()){
   if(product_manager.safe_to_render>0){
   request.setAttribute("product",product_manager.getRandomProduct(MAX_PRODUCT_DISPLAYED));
   request.setAttribute("display_mode","idle");
   }
   dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/core.jsp");
   dispatcher.forward(request, response);

}else{

   String action = request.getParameter("action");
   String page = request.getParameter("page");

    if(action!=null){
    if(action.equals("search")){//tim kiem san pham

    String name = request.getParameter("name");
    String category = request.getParameter("category");
    String brand = request.getParameter("brand");
    String location = request.getParameter("province");
    String min_price = request.getParameter("minprice");
    String max_price = request.getParameter("maxprice");
    String condition = request.getParameter("condition");
    String rating = request.getParameter("rating");
    String payment = request.getParameter("payment");
    String transport = request.getParameter("transport");

    request.setAttribute("product",product_manager.searchProduct(name,category,brand,location,min_price,max_price,condition,rating,payment,transport));
    request.setAttribute("display_mode","search");

    }else if(action.equals("showmine")){//hien thi san pham cua toi
    request.setAttribute("product",product_manager.getProductFrom(my_user));
    }else if(action.equals("showorder")){//hien thi san pham cua toi
    request.setAttribute("order",product_manager.getOrderFrom(my_user));
    }else if(action.equals("detail")){//hien thi chi tiet san pham
    request.setAttribute("productinfo",product_manager.getProductDetail(request.getParameter("pid")));
    }
    }

    if(page!=null){
    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/"+page);
    dispatcher.forward(request, response);
    }else{
    dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/core.jsp");
    dispatcher.forward(request, response);
    }
}

}else{//log out
   dispatcher = request.getRequestDispatcher("/WEB-INF/jsp/home.jsp");
   dispatcher.forward(request, response);
}

}

@Override
protected void doPost(HttpServletRequest request,HttpServletResponse response) throws ServletException,IOException{

String action = request.getParameter("action");

RequestDispatcher dispatcher;

Cookie[] cookie_list = request.getCookies();
User my_user = null;

    if(cookie_list!=null){                    //KIEM TRA COOKIE
    int index=0;
    String token="";
    for(Cookie cookie : cookie_list){
            if(cookie.getName().equals("index")){
     index = Integer.parseInt(cookie.getValue());//index
            }else if(cookie.getName().equals("token")){
     token = cookie.getValue();
     break;
            }
    }
      if(index<user_manager.login_users.size()){
      my_user = user_manager.getUserByCookie(index,token);
      }
    }

if(my_user==null){        //KHONG CON DANG NHAP
if(wait_sync){
wait_sync=false;
//SIGN SECTION
if(action.equals("signup")){      //DANG KY TAI KHOAN
String name = request.getParameter("name");
String age = request.getParameter("age");
String address = request.getParameter("address");
String email = request.getParameter("email");
String number = request.getParameter("number");
String password = request.getParameter("password");

//sign up
user_manager.signUp(name,age,address,email,number,password);
//display any error
response.sendRedirect("/wmarket/sign.html?action=signup&state=signup"+user_manager.getError());

}else if(action.equals("signin")){               //DANG NHAP TAI KHOAN
String email = request.getParameter("email");
String password = request.getParameter("password");
//update current time
updateTime();
//free unused memory
memory_free();
//generate random token
String session_token=user_manager.secure.genToken(8);
//sign in and retrieve free index
int login_index = user_manager.signIn(email,password,session_token);

if(user_manager.getError()>0){//sign in fail
  response.sendRedirect("/wmarket/sign.html?action=signin&state=signin"+user_manager.getError()+"&email="+email);
}else if(login_index != -1){//sign in success
//arrange cookies
Cookie username_cookie = new Cookie("index",String.valueOf(login_index));
username_cookie.setMaxAge(TOKEN_TIMEOUT*60);//n seconds timeout
username_cookie.setPath("/");
username_cookie.setDomain(WEB_DOMAIN);

Cookie sessionid_cookie = new Cookie("token",session_token);
sessionid_cookie.setMaxAge(TOKEN_TIMEOUT*60);//n seconds timeout
sessionid_cookie.setPath("/");
sessionid_cookie.setDomain(WEB_DOMAIN);
//set timeout on server
user_manager.login_users.get(login_index).SetLastTime(current_time);
//finally save cookie on client
response.addCookie(username_cookie);
response.addCookie(sessionid_cookie);
//redirect back to home
response.sendRedirect("/wmarket/home");
}else{
   response.sendRedirect("/wmarket/sign.html?action=signin&state=signin3&email="+email);
}

}else if(action.equals("logout")){              //DANG XUAT TAI KHOAN
 int index = Integer.parseInt(request.getParameter("index"));
      if(index<user_manager.login_users.size() && user_manager.getUserByCookie(index,request.getParameter("token"))!=null){
          user_manager.logOut(index);
          response.sendRedirect("/wmarket/home");
      }
}
wait_sync=true;
}
}else{    //VAN DANG DANG NHAP

//CROD SETION
if(action.equals("addproduct")||action.equals("editproduct")){          //THEM SAN PHAM

    String name = request.getParameter("name");
    String description = request.getParameter("description");
    Part file = request.getPart("image");
    String buyprice = request.getParameter("buyprice");
    String sellprice = request.getParameter("sellprice");
    String category = request.getParameter("category");
    String brand = request.getParameter("brand");
    String condition = request.getParameter("condition");
    String payment = request.getParameter("payment");
    String transport = request.getParameter("transport");
    String quantity = request.getParameter("quantity");
    String filename="";

    if(file!=null){
    filename="img/"+file.getSubmittedFileName();
    }
if(action.charAt(0)=='a'){
    if(product_manager.addProduct(name,description,filename,buyprice,sellprice,category,brand,condition,payment,transport,quantity,my_user)){
    //LUU ANH SAN PHAM
    save_file(file,WEB_ABS_PATH+filename);
    response.sendRedirect("/wmarket/home?page=myshop.jsp");
    }else{//CHUA XAC NHAN TINH THANH
    response.sendRedirect("/wmarket/home?page=myaccount.jsp");
    }
}else{
    //XOA ANH
    String old_picture = product_manager.getProductSpecific(request.getParameter("pid"),"image");
if(old_picture != null){
    delete_file(WEB_ABS_PATH+old_picture);
}
    //SUA SAN PHAM
    product_manager.editProduct(name,description,filename,buyprice,sellprice,category,brand,condition,payment,transport,quantity,request.getParameter("pid"));
    //LUU ANH SAN PHAM
    save_file(file,WEB_ABS_PATH+filename);
    response.sendRedirect("/wmarket/home?page=myshop.jsp");
}


}else if(action.equals("deleteproduct")){       //XOA SAN PHAM

     product_manager.deleteProduct(request.getParameter("pid"),my_user);
     delete_file(WEB_ABS_PATH+request.getParameter("image"));//delete old picture
     response.sendRedirect("/wmarket/home?page=myshop.jsp");

}else if(action.equals("edituser")){
String content_type = request.getContentType();

if(content_type != null && content_type.startsWith("multipart/form-data")){

 String option = request.getParameter("option");
 Part file = request.getPart("image");
//UPDATE ANH DAI DIEN PROFILE PICTURE
if(option.equals("updatephoto") && file!=null){
    if(my_user.GetImage() != null){
    delete_file(WEB_ABS_PATH+my_user.GetImage());//delete old picture
    }
    String filename="img/";
    filename+=file.getSubmittedFileName();
    save_file(file,WEB_ABS_PATH+filename);//save new picture
    my_user.SetImage(filename);
}else if(option.equals("defaultphoto")){
    delete_file(WEB_ABS_PATH+my_user.GetImage());//delete old picture
    my_user.SetImage("");
}

}else{
my_user.SetName(request.getParameter("name"));
my_user.SetEmail(request.getParameter("email"));
my_user.SetAge(request.getParameter("age"));
my_user.SetAddress(request.getParameter("address"));
my_user.SetNumber(request.getParameter("number"));
my_user.SetProvince(request.getParameter("province"));

if(request.getParameter("password")!=""){
   my_user.SetPassword(user_manager.secure.getEncryption(request.getParameter("password")));
}
}

response.sendRedirect("/wmarket/home?page=myaccount.jsp");
}else if(action.equals("buynow")){
product_manager.buyNow(request.getParameter("pid"),my_user,request.getParameter("uid"));
response.sendRedirect("/wmarket/home");
}else if(action.equals("tobuy")){
my_user.AddBuy(request.getParameter("pid"));
response.sendRedirect("/wmarket/home");
}else if(action.equals("rmbuy")){
my_user.RemoveBuy(request.getParameter("pid"));
response.sendRedirect("/wmarket/home");
}else{
response.sendRedirect("/wmarket/home");
}
}

}

}
