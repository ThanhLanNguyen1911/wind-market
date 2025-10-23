public class User extends DatabaseAPI{

 private int id;
 private String cookie;
 private int last_time;

    public User(int ID,String COOKIE){
    id=ID;
    cookie=COOKIE;
    }
    //getters
    public int GetId(){
    return this.id;
    }

    public String GetName(){
    String value="";
    sqlGetStream("select name from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getString("name");
    sqlCloseAll();
    }
    }catch(Exception e){}
    return value;
    }

    public String GetImage(){
    String value="";
    sqlGetStream("select image from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getString("image");
    sqlCloseAll();
    }
    }catch(Exception e){}
    return value;
    }

    public String GetCookie(){
    return this.cookie;
    }

    public int GetProvince(){
    int value=-1;
    sqlGetStream("select province from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getInt("province");
    }
    sqlCloseAll();
    }catch(Exception e){}
    return value;
    }

    public int GetAge(){
    int value=-1;
    sqlGetStream("select age from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getInt("age");
    }
    sqlCloseAll();
    }catch(Exception e){}
    return value;
    }

    public String GetAddress(){
    String value="";
    sqlGetStream("select address from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getString("address");
    }
    sqlCloseAll();
    }catch(Exception e){}
    return value;
    }

    public String GetEmail(){
    String value="";
    sqlGetStream("select email from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getString("email");
    }
    sqlCloseAll();
    }catch(Exception e){}
    return value;
    }

    public String GetNumber(){
    String value="";
    sqlGetStream("select number from users where id = "+this.id);
    try{
    if(this.stream.next()){
        value = stream.getString("number");
    }
    sqlCloseAll();
    }catch(Exception e){}
    return value;
    }


    public int GetLastTime(){
    return this.last_time;
    }

    public String GetSellList(){
    sqlGetStream("select tosell from assets where id = "+this.id);
    try{
    if(this.stream.next()){
       String raw_list = this.stream.getString("tosell");
       String result_list = "";
       for(int i=0;i<raw_list.length()-1;++i){
       result_list+=raw_list.charAt(i);
       }
       sqlCloseAll();
       return result_list;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return null;
    }

    public String GetBuyList(){
    sqlGetStream("select tobuy from assets where id = "+this.id);
    try{
    if(this.stream.next()){
       String raw_list = this.stream.getString("tobuy");
       String result_list = "";
       for(int i=0;i<raw_list.length()-1;++i){
       result_list+=raw_list.charAt(i);
       }
       sqlCloseAll();
       return result_list;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return null;
    }

    public String GetShipList(){
    sqlGetStream("select toship from assets where id = "+this.id);
    try{
    if(this.stream.next()){
       String raw_list = this.stream.getString("toship");
       String result_list = "";
       for(int i=0;i<raw_list.length()-1;++i){
       result_list+=raw_list.charAt(i);
       }
       sqlCloseAll();
       return result_list;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return null;
    }

    public String GetTakeList(){
    sqlGetStream("select totake from assets where id = "+this.id);
    try{
    if(this.stream.next()){
       String raw_list = this.stream.getString("totake");
       String result_list = "";
       for(int i=0;i<raw_list.length()-1;++i){
       result_list+=raw_list.charAt(i);
       }
       sqlCloseAll();
       return result_list;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return null;
    }

    public int GetSold(){
    int value=-1;
    sqlGetStream("select sold from balances where id = "+this.id);
    try{
    if(this.stream.next()){
       value = this.stream.getInt("sold");
    }
    sqlCloseAll();
    }catch(Exception e){}
       return value;
    }

    public float GetProfit(){
    float value=-1;
    sqlGetStream("select profit from balances where id = "+this.id);
    try{
    if(this.stream.next()){
       value = this.stream.getFloat("profit");
    }
    sqlCloseAll();
    }catch(Exception e){}
       return value;
    }

    public float GetRevenue(){
    float value=-1;
    sqlGetStream("select revenue from balances where id = "+this.id);
    try{
    if(this.stream.next()){
       value = this.stream.getFloat("revenue");
    }
    sqlCloseAll();
    }catch(Exception e){}
       return value;
    }

    public float GetDebt(){
    float value=-1;
    sqlGetStream("select debt from balances where id = "+this.id);
    try{
    if(this.stream.next()){
       value = this.stream.getFloat("debt");
    }
    sqlCloseAll();
    }catch(Exception e){}
       return value;
    }

    //setters
    public void SetId(int value){
    this.id=value;
    }

    public void SetName(String value){
        if(value!=""){
    sqlPostStream("update users set name = '"+value+"' where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetProvince(String value){
        if(value!=""){
    sqlPostStream("update users set province = "+value+" where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetAge(String value){
        if(value!=""){
    sqlPostStream("update users set age = "+value+" where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetAddress(String value){
        if(value!=""){
    sqlPostStream("update users set address = '"+value+"' where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetEmail(String value){
        if(value!=""){
    sqlPostStream("update users set email = '"+value+"' where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetNumber(String value){
        if(value!=""){
    sqlPostStream("update users set number = '"+value+"' where id = "+this.id);
    sqlCloseAll();
        }
    }

    public void SetPassword(String value){
    sqlPostStream("update users set password = '"+value+"' where id = "+this.id);
    sqlCloseAll();
    }

    public void SetImage(String value){
    sqlPostStream("update users set image = '"+value+"' where id = "+this.id);
    sqlCloseAll();
    }

    public void SetCookie(String value){
    this.cookie=value;
    }

    public void SetLastTime(int value){
    this.last_time=value;
    }
    //ADD PRODUCTS
    public boolean AddSell(int pid){
    sqlGetStream("select tosell from assets where id = "+this.id);
    try{
    if(this.stream.next() && this.stream.getString("tosell") != null){
    sqlCloseStream();
    sqlPostStream("update assets set tosell = concat(tosell,'"+pid+",') where id = "+this.id);
    }else{
    sqlCloseStream();
    sqlPostStream("update assets set tosell = '"+pid+",' where id = "+this.id);
    }
    }catch(Exception e){}
    sqlCloseAll();
    return false;
    }

    public boolean AddBuy(String pid){
    sqlGetStream("select tobuy from assets where id = "+this.id);
    try{
    if(this.stream.next() && this.stream.getString("tobuy") != null){
    String tobuy = this.stream.getString("tobuy");
    sqlCloseStream();
    if(tobuy.contains(","+pid+",")){
        return false;
    }if(tobuy.contains(pid+",")){
        return false;
    }if(tobuy.contains(","+pid)){
        return false;
    }
    sqlPostStream("update assets set tobuy = concat(tobuy,'"+pid+",') where id = "+this.id);
    }else{
    sqlCloseStream();
    sqlPostStream("update assets set tobuy = '"+pid+",' where id = "+this.id);
    }
    }catch(Exception e){}
    sqlCloseAll();
    return false;
    }
    //DELETE PRODUCTS
    public boolean RemoveSell(String pid){
    sqlGetStream("select tosell from assets where id = "+this.id);
    try{
    pid=","+pid+",";
    if(this.stream.next() && this.stream.getString("tosell") != null){

    String list = this.stream.getString("tosell");
    String list_begin = "";
    int index = list.indexOf(pid);
        if(index == -1){
        index = 0;
        }else{
        list_begin = list.substring(0,index);
        }
    String list_end = list.substring(index+pid.length()-1);
    list = list_begin + list_end;

    sqlCloseStream();
    sqlPostStream("update assets set tosell = '"+list+"' where id = "+this.id);
    return true;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return false;
    }

    public boolean RemoveBuy(String pid){
    sqlGetStream("select tobuy from assets where id = "+this.id);
    try{
    pid=","+pid+",";
    if(this.stream.next() && this.stream.getString("tobuy") != null){

    String list = this.stream.getString("tobuy");
    String list_begin = "";
    int index = list.indexOf(pid);
        if(index == -1){
        index = 0;
        }else{
        list_begin = list.substring(0,index);
        }
    String list_end = list.substring(index+pid.length()-1);
    list = list_begin + list_end;

    sqlCloseStream();
    sqlPostStream("update assets set tobuy = '"+list+"' where id = "+this.id);
    return true;
    }
    }catch(Exception e){}
    sqlCloseAll();
    return false;
    }

    public void AddTake(int order){
    sqlGetStream("select totake from assets where id = "+this.id);
    try{
    if(this.stream.next() && this.stream.getString("totake") != null){
    sqlCloseStream();
    sqlPostStream("update assets set totake = concat(totake,'"+order+",') where id = "+this.id);
    }else{
    sqlCloseStream();
    sqlPostStream("update assets set totake = '"+order+",' where id = "+this.id);
    }
    }catch(Exception e){}
    sqlCloseAll();
    }
    //MONET
    public void AddSold(int value){
    sqlPostStream("update balances set sold = "+value+" where id = "+this.id);
    sqlCloseAll();
    }

    public void AddProfit(float value){
    sqlPostStream("update balances set profit = "+value+" where id = "+this.id);
    sqlCloseAll();
    }

    public void AddRevenue(float value){
    sqlPostStream("update balances set revenue = "+value+" where id = "+this.id);
    sqlCloseAll();
    }

    public void AddDebt(float value){
    sqlPostStream("update balances set debt = "+value+" where id = "+this.id);
    sqlCloseAll();
    }


}
