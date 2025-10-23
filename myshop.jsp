<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
   <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
   <style type="text/css">
   div#img_window:hover{
   border: solid rgb(240,240,240) 1px;
   }

   .btn-wmarket{
   color: white;
   background-color: rgb(250,80,110);
   }

   .btn-wmarket:hover{
   color: white;
   background-color: rgb(240,70,100);
   }
   </style>
    <div class="container-fluid">
        <div class="row" style="background-color: rgb(76,76,76)">
        <div class="col text-start">
        <h1>
        <a href="home" style="color: rgb(200,200,200);text-decoration: none;margin-top: 5px"><b><i class="bi bi-chevron-left" style="font-size: 2rem"></i>&nbsp</b></a>
        </h1>
        </div>
        <div class="col text-center">
        <h1 style="color: rgb(250,80,110);margin-top: 5px"><b>Wind Market </b><i class="bi bi-cloud-fog2-fill"></i></h1>
        </div>
        <div class="col"></div>
        </div>
    </div>
</head>

<c:if test="${myuser.GetProvince() == 0}">
<script>window.location.assign("home?page=myaccount.jsp")</script>
</c:if>

    <body>

    <div class="container-fluid">
      <div class="row" name="title" style="background-color: rgb(200,200,200)">
          <div class="col text-start"><h2 style="color: rgb(240,240,240)"><i class="bi bi-shop"></i>&nbsp&nbspShop của tôi</h2></div>
      </div>
      <div class="row" name="btn_bar" style="border: solid rgb(200,200,200) 1px;">
          <div class="col text-center"><h5 onclick="addForm('Thêm sản phẩm:','addproduct')" style="color:gray;margin-top: 10px"><i class="bi bi-plus-circle-fill"></i>&nbsp&nbspThêm sản phẩm</h5></div>
          <div class="col text-center"><h5 onclick="window.location.assign('home?action=showorder&page=myshop.jsp')" style="color:gray;margin-top: 10px"><i class="bi bi-journal-text"></i>&nbsp&nbspĐơn đặt hàng</h5></div>
          <div class="col text-center"><h5 onclick="window.location.assign('home?action=showmine&page=myshop.jsp')" style="color:gray;margin-top: 10px"><i class="bi bi-box-seam-fill" style="color: rgb(250,210,100)"></i>&nbsp&nbspSản phẩm của tôi</h5></div>
          <div class="col text-center"><h5 onclick="window.location.assign('home?action=getbalance&page=myshop.jsp')" style="color:gray;margin-top: 10px"><i class="bi bi-currency-exchange" style="margin:2px"></i>&nbsp&nbspTài chính</h5></div>
      </div>
      <div class="row">
         <div class="col"></div>
         <div class="col text-center" style="padding: 10px"><h4 style="color:gray" id="title"></h4></div>
         <div class="col"></div>
      </div>
      <div class="row" name="desktop">
          <div class="col-2"></div>
          <div class="col-8">
              <div id="myorder" style="display:none">
              <c:forEach begin="0" end="1000">
              <c:if test="${order.next()}">
              <c:set var="pd" value="${product_manager.getProductDetail(order.getString('pid'))}"/>
              <c:if test="${pd.next()}">
              <b>Sản phẩm:&nbsp${pd.getString('name')}</b>&nbsp<p>Giá:&nbsp${String.format("%,.1f",pd.getFloat('sell_price'))}</p><strong>Tồn kho:&nbsp${pd.getInt('quantity')}</strong>
              ${pd.close()}
              </c:if>
              <br>
              <c:set var="buyer" value="${order.getString('buyer')}"/>
              <b>Người mua:&nbsp${user_manager.getUserNameById(buyer)}</b>
              <p>Email:&nbsp${user_manager.getUserEmailById(buyer)}</p>
              <p>SĐT:&nbsp${user_manager.getUserNumberById(buyer)}</p>
              <p>Địa chỉ:&nbsp${user_manager.getUserAddressById(buyer)}</p>
              <br>
              <c:set var="state" value="${order.getString('state')}"/>
              <strong>Trạng thái đơn hàng:&nbsp
              <c:if test="${state == 0}">Chờ xác nhận</c:if>
              <c:if test="${state == 1}">Chuẩn bị hàng</c:if>
              <c:if test="${state == 2}">Đang vận chuyển</c:if>
              <c:if test="${state == 3}">Giao hàng thành công</c:if>
              </strong>
              <button class="btn btn-wmarket" onclick="Confirm(${order.getInt('id')})">Xác nhận</button>
              </c:if>
              </c:forEach>
              ${order.close()}
              </div>

              <div id="mybalance" style="display:none">
              <b>Doanh số:&nbsp${myuser.GetSold()}&nbspMặt hàng</b><br>
              <b>Doanh thu:</b><p style="color:green">&nbsp${String.format("%,.1f",myuser.GetRevenue())}&nbspVND</p><br>
              <b>Lợi nhuận:</b><p style="color:green">&nbsp${String.format("%,.1f",myuser.GetProfit())}&nbspVND</p><br>
              <b>Nợ:</b><p style="color:red">&nbsp${String.format("%,.1f",myuser.GetDebt())}&nbspVND</p>
              </div>

              <div id="myproduct" style="display: none">

              <c:forEach begin="0" end="1000">
              <c:if test="${product.next()}">
              <div class="row" style="border: solid gray 1px;background-color:rgb(250,250,250);border-radius:10px;height:200px;margin:5px">

              <div class="col-3" id="img_window" style="background-color:white;margin:10px">
              <img style="object-fit: contain" src="${product.getString('image')}" width="98%" height="90%">
              </div>

              <div class="col-6">
              <div class="row">
              <div class="col text-center" style="margin-top: 10%">
              <b style="font-size:21px;color:gray">${product.getString('name')}</b>
              </div>
              </div>

              <div class="row">
              <div class="col text-center" style="margin-top: 5%">
              <b style="font-size:18px">${String.format("%,.1f",product.getFloat('sell_price'))}&nbspVND</b>
              </div>
              </div>

              <div class="row">
              <div class="col text-center" style="color:gray;margin-top: 5%">Đã bán:&nbsp${product.getInt('sold')}</div>
              <div class="col text-center" style="color:gray;margin-top: 5%">Tồn kho:&nbsp${product.getInt('quantity')}</div>
              <div class="col text-center" style="color:gray;margin-top: 5%">Đánh giá:&nbsp${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></div>
              </div>
              </div>

              <div class="col-2">
              <div class="col text-center">
              <div style="margin-top:60px">
              <button style="width:100%;margin:2%" class="btn btn-wmarket" onclick="addForm('Sửa sản phẩm:','addproduct');applyForm('${product.getString('name')}','${product.getString('description')}',${product.getFloat('buy_price')},${product.getFloat('sell_price')},${product.getInt('category')},'${product.getString('brand')}',${product.getInt('cond')},${product.getInt('quantity')},${product.getInt('payment')},${product.getInt('transport')},${product.getInt('id')})"><i class="bi bi-pencil"></i>&nbsp&nbspSửa</button>
              <button style="width:100%;margin:2%" class="btn btn-secondary" onclick="deleteProduct(${product.getInt('id')},'${product.getString('image')}')"><i class="bi bi-trash3"></i>&nbsp&nbspXóa</button>
              </div>
              </div>
              </div>

              </div>
              </c:if>

              </c:forEach>
              ${product_manager.sqlCloseAll()}
              </div>

              <div class="row" id="addproduct" style="display: none">

    <form id="delete" action="home" method="POST">
    <input type="hidden" name="action" value="deleteproduct">
    <input id="PID" type="hidden" name="pid">
    <input id="IMAGE" type="hidden" name="image">
    </form>

              <form action="home" id="socket" method="POST" enctype="multipart/form-data">
              <input id="action" type="hidden" name="action">
              <input id="pid" type="hidden" name="pid">

              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Tên sản phẩm:</b></div>
                 <div class="col-7 text-start"><input id="name" name="name" type="text" class="form-control" placeholder="(Không được trống)"></div>
                 <div class="col-1 text-start" style="color:red" id="alert1"></div>
              </div>
              <div class="row" style="margin: 4px" style="margin: 2px">
                 <div class="col-3 text-end" style="padding: 4px"><b><i class="bi bi-pencil-square"></i>&nbsp&nbspMiêu tả:</b></div>
                 <div class="col-7 text-start"><textarea id="description" name="description" type="text" class="form-control" placeholder="(Không được trống)"></textarea></div>
                 <div class="col-1 text-start" style="color:red" id="alert2"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b><i class="bi bi-card-image"></i>&nbsp&nbspThêm ảnh:</b></div>
                 <div class="col-7 text-start"><input id="image" name="image" type="file" class="form-control"></div>
                 <div class="col-1 text-start" style="color:red" id="alert3"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Giá nhập:</b></div>
                 <div class="col-7 text-start"><input id="buyprice" name="buyprice" value="0" type="number" class="form-control" placeholder="(Không bắt buộc)"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Giá bán:</b></div>
                 <div class="col-7 text-start"><input id="sellprice" name="sellprice" type="number" class="form-control" placeholder="(Không được trống)"></div>
                 <div class="col-1 text-start" style="color:red" id="alert4"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Danh mục:</b></div>
                 <div class="col-7 text-start">
                 <select id="category" name="category" type="text" class="form-select">
                 <option value="0" selected>Chọn danh mục</option>
                 <c:forEach items="${product_categories}" var="i">
                 <option value="${i.GetId()}">${i.GetName()}</option>
                 </c:forEach>
                 </select>
                 </div>
                 <div class="col-1 text-start" style="color:red" id="alert5"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Nhãn hiệu:</b></div>
                 <div class="col-7 text-start"><input id="brand" name="brand" type="text" class="form-control" placeholder="(Không bắt buộc)"><div class="list-group" id="brand_search"></div></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Tình trạng:</b></div>
                 <div class="col-7 text-start">
                 <select id="condition" name="condition" type="text" class="form-select">
                 <option value="1" selected>Mới</option>
                 <option value="2">Đã qua sử dụng</option>
                 <option value="3">Hàng trưng bày</option>
                 </select>
                 </div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Số lượng:</b></div>
                 <div class="col-7 text-start"><input id="quantity" name="quantity" type="number" class="form-control" placeholder="(Không được trống)"></div>
                 <div class="col-1 text-start" style="color:red" id="alert6"></div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Loại hình thanh toán:</b></div>
                 <div class="col-7 text-start">
                 <select id="payment" name="payment" type="text" class="form-select">
                 <option value="1" selected>COD</option>
                 <option value="2">Ví Windpay</option>
                 </select>
                 </div>
              </div>
              <div class="row" style="margin: 4px">
                 <div class="col-3 text-end" style="padding: 4px"><b>Đơn vị vận chuyển:</b></div>
                 <div class="col-7 text-start">
                 <select id="transport" name="transport" type="text" class="form-select">
                 <option value="1" selected>Windpost</option>
                 <option value="2">Thủ công</option>
                 </select>
                 </div>
              </div>
              </form>
              <div class="row">
                 <div class="col text-center"><button class="btn btn-secondary" style="width: 100px" onclick="submitForm()"><b>Lưu</b></button></div>
              </div>
              <br>
              &nbsp
              </div>

              </div>
          </div>
          <div class="col-2"></div>
      </div>
    </div>
    <script>
    let is_open=null;
    let parameter = new URLSearchParams(window.location.search);

    if(parameter.get("action")=="showmine"){
    addForm("Sản phẩm của tôi:","myproduct");
    }else if(parameter.get("action")=="showorder"){
    addForm("Đơn đặt hàng:","myorder");
    }else if(parameter.get("action")=="getbalance"){
    addForm("Tài chính:","mybalance");
    }


    function addForm(title,body){
    if(is_open){
    is_open.style.display = "none";
    }
    is_open=document.getElementById(body);
    document.getElementById("title").innerHTML = title;
    is_open.style.display = "inline";

    document.getElementById("action").value = "addproduct";//set action to add as default
    }

    function applyForm(Name,Description,Buyprice,Sellprice,Category,Brand,Condition,Quantity,Payment,Transport,PID){
    document.getElementById("action").value = "editproduct";//change action to edit
    document.getElementById("name").value = Name;
    document.getElementById("description").value = Description;
    document.getElementById("buyprice").value = Buyprice;
    document.getElementById("sellprice").value = Sellprice;
    document.getElementById("category").value = Category;
    document.getElementById("brand").value = Brand;
    document.getElementById("condition").value = Condition;
    document.getElementById("quantity").value = Quantity;
    document.getElementById("payment").value = Payment;
    document.getElementById("transport").value = Transport;
    document.getElementById("pid").value = PID;
    }

    function submitForm(){
    let value;
    let mark = "<i class='bi bi-exclamation-circle-fill'></i>";

    value = document.getElementById("name").value;
       if(value=="" || value.includes("'")){
       document.getElementById("alert1").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert1").innerHTML = "";
       }
    value = document.getElementById("description").value;
       if(value=="" || value.includes("'")){
       document.getElementById("alert2").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert2").innerHTML = "";
       }

if(document.getElementById("action").value == "addproduct"){
    value = document.getElementById("image").value;
       if(value==""){
       document.getElementById("alert3").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert3").innerHTML = "";
       }
 }

    value = document.getElementById("sellprice").value;
       if(value==""){
       document.getElementById("alert4").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert4").innerHTML = "";
       }
    value = document.getElementById("category").value;
       if(value==""){
       document.getElementById("alert5").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert5").innerHTML = "";
       }
    value = document.getElementById("quantity").value;
       if(value==""){
       document.getElementById("alert6").innerHTML = mark;
       return false;
       }else{
       document.getElementById("alert6").innerHTML = "";
       }

       document.getElementById("socket").submit();
    }

    function deleteProduct(value1,value2){
    document.getElementById("PID").value = value1;
    document.getElementById("IMAGE").value = value2;
    document.getElementById("delete").submit();
    }

    </script>
    </body>
</html>
