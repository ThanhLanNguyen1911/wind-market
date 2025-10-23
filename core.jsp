<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">

<style type="text/css">

   a{
   text-decoration: none;
   }

   table,th,td{
   border: 1px solid gray;
   background-color: black;
   opacity: 0.96;
   }

   .buttons{
   border-radius: 5px;
   }

   #rm_btn{
   color: white;
   background-color: rgb(220,5,49);
   border: 1px solid rgb(220,5,49);
   margin-left: 5%;
   padding: 5px;
   }

   #rm_btn:hover{
   color: rgb(220,5,49);
   background-color: white;
   }

   #btnE{
   color: white;
   background-color: rgb(80,200,0);
   border: 1px solid rgb(80,200,0);
   margin-left: 2.5%;
   padding: 5px;
   }

   #btnE:hover{
   color: rgb(80,200,0);
   background-color: white;
   }

   #search_group{
   margin-left: 2.5%;
   margin-top: 2.5%;
   margin-bottom: 2%;
   width: 70%;
   }

   #search_bar{
   border-top-left-radius: 80px;
   border-bottom-left-radius: 80px;
   }

   #search_button{
   border-top-right-radius: 80px;
   border-bottom-right-radius: 80px;
   }

   #popup{
   position: absolute;
   transform: translate(-300px,10px);
   width: 500px;
   height: 100px;
   background-color: rgba(0,0,0,0);
   color: rgb(255,220,50);
   font-size: 25px;
   }

   div#toolbar,div#opbar{
   background-color: rgb(76,76,76);
   }

   img.product_image:hover{
   border: solid rgb(250,250,250) 2px;
   }

   div.side_btn{
   z-index: 2;background-color: white;opacity: 95%;border: solid rgb(200,200,200) 1px;width: 2.5%;display: flex;align-items: center;
   }

   div.side_bar{
   background-color: white;width: 2.5%;
   }

   div.slide_brd{
   text-align: center;width: 20%;padding: 12px;flex-shrink: 0;border: solid rgb(210,210,210) 1px;border-radius: 5px;
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
</head>
<body id="BODY">
<form id="socket" action="home" method="POST">
<input id="action" type="hidden" name="action"/>
<input id="pid" type="hidden" name="pid"/>
<input id="uid" type="hidden" name="uid"/>
<input id="index" type="hidden" name="index"/>
<input id="token" type="hidden" name="token"/>
</form>



<div class="container-fluid">

<div class="row" id="toolbar">
<div class="col-5">
        <form action="home" method="GET">
        <input type="hidden" name="action" value="search"/>
        <div id="search_group" class="input-group">
        <input id="search_bar" type="search" name="name" class="form-control" placeholder="Tìm sản phẩm"/>
        <input id="category_param" type="hidden" name="category">
        <input id="maxprice_param" type="hidden" name="maxprice">
        <input id="minprice_param" type="hidden" name="minprice">
        <input id="brand_param" type="hidden" name="brand">
        <input id="condition_param" type="hidden" name="condition">
        <input id="rating_param" type="hidden" name="rating">
        <input id="payment_param" type="hidden" name="payment">
        <input id="transport_param" type="hidden" name="transport">
        <input id="province_param" type="hidden" name="province">

        <button id="search_button" class="btn btn-secondary" type="submit">
        <i class="bi bi-search"></i>
        </button>
        </div>
        </form>
</div>

<div class="col-5">
<h1 style="color: rgb(250,80,110);margin-top: 5px" onclick="window.location.assign('home')"><b>Wind Market </b><i class="bi bi-cloud-fog2-fill"></i></h1>
</div>

        <div class="col-2" style="margin-top: 2px">
        <button id="my_cart" class="btn bg-transparent text-white rounded-circle p-2" style="font-size: 2rem;margin: 2%" onclick="dropList('mycart','inline')"><i class="bi bi-cart4"></i></button>
        <button id="my_message" class="btn bg-transparent text-white rounded-circle p-2" style="font-size: 2rem;margin: 2%" onclick=""><i class="bi bi-chat-dots"></i></button>

        <c:set var="profile_picture" value="${myuser.GetImage()}"/>
        <c:if test="${profile_picture == null}">
        <button id="my_account" onclick="dropList('accessories','inline')" class="btn bg-transparent text-white rounded-circle p-2" style="font-size: 2rem;margin: 2%" onclick=""><i class="bi bi-person-circle"></i></button>
        </c:if>
        <c:if test="${profile_picture != null}">
        <img id="my_account" onclick="dropList('accessories','inline')" src="${profile_picture}" width="60px" height="60px" class="btn rounded-circle p-2" style="object-fit: fill"/>
        </c:if>


        </div>
</div>
<div class="row" id="opbar">
        <div class="col text-center">
<p onclick="dropList('category_drop','inline')" style="color: white;">Danh mục <i class="bi bi-caret-down-fill"></i></p>
        </div>
        <div class="col text-center">
<p onclick="dropList('price_drop','inline')" style="color: white;">Khoảng giá <i class="bi bi-chevron-expand"></i></p>
        </div>
        <div class="col text-center">
<p onclick="dropList('province_drop','inline')" style="color: white;">Nơi bán <i class="bi bi-geo-alt-fill"></i></p>
        </div>
        <div class="col text-center">
<p onclick="dropList('brand_drop','flex')" style="color: white;">Thương hiệu</p>
        </div>
        <div class="col text-center">
<p onclick="dropList('condition_drop','inline')" style="color: white;">Tình trạng<i class="bi bi-stars" style="color:rgb(200,100,250)"></i></p>
        </div>
        <div class="col text-center">
<p onclick="dropList('rating_drop','inline')" style="color: white;">Đánh giá <i class="bi bi-star-fill" style="color:yellow"></i></p>
        </div>
        <div class="col text-center">
<p onclick="dropList('payment_drop','inline')" style="color: white;">Thanh toán <i class="bi bi-wallet2"></i></p>
        </div>
        <div class="col">
<p onclick="dropList('transport_drop','inline')" style="color: white;white-space: nowrap">Vận chuyển <i class="bi bi-truck"></i></p>
        </div>
        <div class="col text-center">
<a href="home?action=sale" style="color: white;">Khuyến mãi</a>
        </div>
        <div class="col text-center">
<a href="tel:1900571443" style="color: white;">Hotline <i class="bi bi-telephone-fill"></i></a>
        </div>
</div>

<div class="row" id="dropdown">

       <div id="section1" class="col-4" style="z-index: 3">

       <div id="category_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;width: 32%;height: 74%;overflow-y: auto;position: absolute">
       <c:forEach items="${product_categories}" var="i">
       <b onclick="set_category(${i.GetId()})" class="list-group-item list-group-item-action list-group-item-light">${i.GetName()}</b>
       </c:forEach>
       </div>

       <div id="price_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" style="display: none;background-color: rgb(250,250,250);border: solid rgb(200,200,200) 1px;border-radius: 5px;width: 32%;height: 30%;overflow-y: auto;position: absolute">

   <div class="container-fluid">
    <div class="row mb-4">
       <div class="col text-center">
       <button class="btn btn-secondary text-nowrap" onclick="setPriceRange()" style="color: white;margin-top: 5px">Áp dụng</button>
       </div>
    </div>
    <div class="row mb-3">
       <div class="col text-center">
       <input id="minprice_form" class="form-control" type="number" placeholder="Giá thấp nhất:">
       </div>
    </div>
    <div class="row mb-3">
       <div class="col text-center">
       <input id="maxprice_form" class="form-control" type="number" placeholder="Giá cao nhất:">
       </div>
    </div>
   </div>

       </div>
       <div id="province_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;width: 32%;height: 74%;overflow-y: auto;position: absolute">
       <c:forEach items="${user_locations}" var="i">
       <b onclick="set_province(${i.GetId()})" class="list-group-item list-group-item-action list-group-item-light">${i.GetName()}</b>
       </c:forEach>
       </div>

       </div>

       <div id="section2" class="col-4" style="z-index: 3">

       <div id="brand_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" style="display: none;background-color: rgb(250,250,250);border: solid rgb(200,200,200) 1px;border-radius: 5px;width: 32%;height: 15%;overflow-y: auto;position: absolute">

       <input id="brand_form" style="width: 70%;margin: 5%" class="form-control" type="text" placeholder="Tên thương hiệu">
       <button style="width: 30%;margin: 5%" class="btn btn-secondary" onclick="setBrand()">Áp dụng</button>
       </div>

       <div id="condition_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;background-color: rgb(250,250,250);width: 32%;height: 21%;overflow-y: auto;position: absolute">
       <b onclick="setCondition(1)" class="list-group-item list-group-item-action list-group-item-light">Mới</b>
       <b onclick="setCondition(2)" class="list-group-item list-group-item-action list-group-item-light">Cũ</b>
       <b onclick="setCondition(3)" class="list-group-item list-group-item-action list-group-item-light">Trưng bày</b>
       </div>

       <div id="rating_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;width: 32%;height: 35%;overflow-y: auto;position: absolute">
       <b onclick="setStar(1)" class="list-group-item list-group-item-action list-group-item-light">1 <i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></b>
       <b onclick="setStar(2)" class="list-group-item list-group-item-action list-group-item-light">2 <i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></b>
       <b onclick="setStar(3)" class="list-group-item list-group-item-action list-group-item-light">3 <i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></b>
       <b onclick="setStar(4)" class="list-group-item list-group-item-action list-group-item-light">4 <i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></b>
       <b onclick="setStar(5)" class="list-group-item list-group-item-action list-group-item-light">5 <i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></b>
       </div>


       </div>
<%--SECTION 3--%>
       <div id="section3" class="col-4" style="z-index: 3">
         <div class="list-group" id="accessories" style="display: none;width: 32%;position: absolute;transform: translate(0px,-50px)">
         <a href="home?page=myaccount.jsp" class="list-group-item list-group-item-action list-group-item-light"><p style="color:gray">Tài khoản:</p><b>${myuser.GetName()}</b></a>
         <a href="home?page=setting.jsp" class="list-group-item list-group-item-action list-group-item-light"><i class="bi bi-gear" style="margin:2px"></i>&nbsp&nbspCài đặt</a>
         <a href="home?page=myshop.jsp" class="list-group-item list-group-item-action list-group-item-light"><i class="bi bi-shop" style="margin:2px"></i>&nbsp&nbspShop của tôi</a>
         <a href="" class="list-group-item list-group-item-action list-group-item-light"><i class="bi bi-map"></i>&nbsp&nbspTheo dõi đơn hàng đến</a>
         <a onclick="logout()" class="list-group-item list-group-item-action list-group-item-light"><i class="bi bi-box-arrow-in-left" style="margin:2px"></i>&nbsp&nbspĐăng xuất</a>
         </div>
         <div class="list-group" id="messages" style="display: none;width: 32%;position: absolute;transform: translate(0px,-50px)">


         </div>
         <div class="list-group" id="mycart" onmouseover="is_mousein=1" onmouseout="is_mousein=0" style="display: none;width: 32%;position: absolute;transform: translate(0px,-50px)">

         <c:set var="mycart" value="${product_manager.getCartFrom(myuser)}"/>
         <li class="list-group-item list-group-item-light" style="text-align: center"><b>Giỏ hàng</b></li>
         <c:forEach begin="0" end="100">

         <c:if test="${mycart.next()}">
         <li class="list-group-item" style="display:flex">
         <img onclick="window.location.assign('home?action=detail&pid=${mycart.getInt('id')}')" src="${mycart.getString('image')}" width="50px" height="50px" style="object-fit: contain;width:20%"/><p style="overflow: hidden;white-space: nowrap;text-overflow: ellipsis;max-width: 15ch;width:30%">${mycart.getString('name')}</p><button onclick="buynow(${mycart.getInt('id')},${mycart.getInt('shopid')})" class="btn btn-wmarket" style="width:25%;border: solid white 2px">Mua</button><button onclick="removecart(${mycart.getInt('id')})" class="btn btn-secondary" style="width:25%;border: solid white 2px"><i class="bi bi-trash3"></i>&nbspXóa</button>
         </li>
         </c:if>
         </c:forEach>
         ${mycart.close()}
         </div>

       <div id="payment_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;background-color: rgb(250,250,250);width: 32%;height: 14%;overflow-y: auto;position: absolute">
       <b onclick="setPayment(1)" class="list-group-item list-group-item-action list-group-item-light">COD</b>
       <b onclick="setPayment(2)" class="list-group-item list-group-item-action list-group-item-light">Ví Windpay</b>
       </div>

       <div id="transport_drop" onmouseover="is_mousein=1" onmouseout="is_mousein=0" class="list-group" style="display: none;background-color: rgb(250,250,250);width: 32%;height: 14%;overflow-y: auto;position: absolute">
       <b onclick="setTransport(1)" class="list-group-item list-group-item-action list-group-item-light">Windpost</b>
       <b onclick="setTransport(2)" class="list-group-item list-group-item-action list-group-item-light">Thủ công</b>
       </div>

       </div>
</div>
</div>


<div id="body">
    <div id="bill_board" style="height: 20%;display: flex"></div>

    <c:if test="${productinfo.next()}">
    <c:if test="${productinfo.getString('cond') == 1}">
    <c:set var="condition" value="Mới"/>
    </c:if>
    <c:if test="${productinfo.getString('cond') == 2}">
    <c:set var="condition" value="Cũ"/>
    </c:if>
    <c:if test="${productinfo.getString('cond') == 3}">
    <c:set var="condition" value="Hàng trưng bày"/>
    </c:if>

    <div id="show_board" style="height: 1000px;display: flex;flex-direction: column;border: solid gray 1px;background-color:rgb(240,240,240)">
    <div style="width: 10%;background-color:white"></div>

    <div id="product_info" style="text-align: center;display: flex;height: 70%;background-color:rgb(250,250,250);border: solid rgb(250,250,250) 1px">
    <div style="width: 60%">
       <img src="${productinfo.getString('image')}" width="98%" height="83%" style="object-fit: contain;margin:2%"/>
       <h1 style="margin:0.5%"><i>${productinfo.getString('name')}</i></h1>
     </div>
     <div style="width: 40%">
       <h5 style="color:gray;margin:2%"><i>Mô tả:</i></h5>
       <h5 style="margin:1%;width:90%;background-color: white;border-radius: 5px">${productinfo.getString('description')}</h5>
     </div>
    </div>
    <div style="text-align: center;height: 30%;display: flex">
    <div style="width: 33%;color: gray;text-align: center"><b style="font-size: 30px"><br>Đã bán:&nbsp${productinfo.getInt('sold')}<br>Xếp hạng:&nbsp${productinfo.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i><br>Tình trạng:&nbsp${condition}</b></div>
    <div style="width: 33%;text-align: center">
     <h1><p style="color:gray">Giá bán:</p>&nbsp${String.format("%,.1f",productinfo.getFloat('sell_price'))}&nbspđ<br><br><br>
     <c:if test="${productinfo.getInt('shopid') != myuser.GetId()}">
     <button onclick="buynow(${productinfo.getInt('id')},${productinfo.getInt('shopid')})" class="btn btn-wmarket" style="font-size: 20px;margin: 2.5%">Mua ngay</button>
     <button onclick="addcart(${productinfo.getInt('id')})" class="btn btn-secondary" style="font-size: 20px;margin: 2.5%"><i class="bi bi-cart-plus"></i>&nbspThêm vào giỏ hàng</button></h1>
     </c:if>
    </div>
    <div style="width: 33%;text-align: center"><p style="font-size: 20px;margin: 5%">Đăng bởi:&nbsp${user_manager.getUserNameById(productinfo.getInt('shopid'))}<br></p></div>
    </div>

    <div style="width: 10%;background-color:white"></div>

    </div>


    ${product_manager.sqlCloseAll()}

    </c:if>


    <div id="show_bar" style="background-color:rgb(250,250,250);height: 5%">&nbspMột số sản phẩm</div>

    <div id="idle_container" style="height: 60%;display: flex;overflow-x: hidden">
<div class="side_btn" onclick="moveSlide(1,limit)"><i class="bi bi-chevron-left" style="font-size: 2rem"></i></div>
<div id="product_slide" style="display: flex;z-index: 1;width: 95%">

   <div id="display_mode" style="display: none">${display_mode}</div>

<c:if test="${display_mode == 'idle'}">
<c:forEach begin="0" end="1000">
<c:if test="${product.next()}">
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"/></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
<c:set var="rowcount" value="${rowcount+1}"/>
</c:if>
</c:forEach>
</c:if>

  <div style="display: none" id="slide_count">${rowcount / 5}</div>

</div>
<div class="side_btn" onclick="moveSlide(-1,limit)"><i class="bi bi-chevron-right" style="font-size: 2rem"></i></div>
     </div>

<c:if test="${display_mode == 'search'}">
<c:forEach begin="0" end="1000">

     <c:if test="${product.next()}">

     <div name="search_container" style="display: none;height: 55%">
<div class="side_bar"></div>

<div style="display: flex;width: 95%">
     <c:set var="rowcount" value="${rowcount+1}"/>
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
     <c:if test="${product.next()}">
     <c:set var="rowcount" value="${rowcount+1}"/>
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
     </c:if>
     <c:if test="${product.next()}">
     <c:set var="rowcount" value="${rowcount+1}"/>
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
     </c:if>
     <c:if test="${product.next()}">
     <c:set var="rowcount" value="${rowcount+1}"/>
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
     </c:if>
     <c:if test="${product.next()}">
     <c:set var="rowcount" value="${rowcount+1}"/>
<div class="slide_brd"><a href="home?action=detail&pid=${product.getInt('id')}"><img style="object-fit: contain" class="product_image" src="${product.getString('image')}" width="95%" height="80%"></a><p style="line-height: 20px;display: inline-block;max-width: 26ch;overflow: hidden;white-space: nowrap;text-overflow: ellipsis">${product.getString('name')}</p><b style="font-size: 20px;line-height: 12px">${String.format("%,.1f",product.getFloat('sell_price'))}đ</b><p style="color: gray">${product.getInt('rating')}&nbsp<i class="bi bi-star-fill" style="color:rgb(250,200,0)"></i></p></div>
     </c:if>
</div>

<div class="side_bar"></div>
     </div>
     </c:if>

</c:forEach>
<div style="display: none" id="result_count">${rowcount}</div>
</c:if>

<c:if test="${!product.next()}">
${product_manager.sqlCloseAll()}
</c:if>

    <div style="background-color:rgb(250,250,250);text-align: center;height: 5%"></div>

    <div style="background-color:rgb(76,76,76);height: 20%">
    <div text-start" style="padding: 40px">
    <img src="http://online.gov.vn/Content/EndUser/LogoCCDVSaleNoti/logoCCDV.png" width="100px" height="38px" style="border-radius: 5px">
    </div>
    </div>
</div>


    <script>
//GLOBAL VARIABLES
   let is_dropdown=0;
   let is_mousein=0;
   let slide_strip=document.documentElement.clientWidth * 0.95;
   let translation=0;
   let thread_run=false;
   let slide = document.getElementById("product_slide");
   let parameter = new URLSearchParams(window.location.search);
   let limit;

function sleep(value) {
    return new Promise(resolve => setTimeout(resolve,value));
}


//LOGOUT
function logout(){
  let cookie_array = document.cookie.split(";");
  let index = cookie_array[0].split("=");
  let token = cookie_array[1].split("=");

  document.cookie = "index=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/";
  document.cookie = "token=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/";

  document.getElementById("action").value = "logout";
  document.getElementById("index").value = index[1];
  document.getElementById("token").value = token[1];
  document.getElementById("socket").submit();
}
//MY CART

//ACCESSORIES


//SHARED DROP DOWN FUNCTIONS

function close_dropdown(id){
   document.getElementById(id).style.display = "none";
   document.getElementById("BODY").onmouseup = null;
   is_dropdown=0;
}

function dropList(id,param){
   if(!is_dropdown){
   document.getElementById(id).style.display = param;
   document.getElementById("BODY").onmouseup = function(){ if(!is_mousein){ close_dropdown(id); } };
   is_dropdown=1;
   document.getElementById(id).value = "0";
   }
}

//CATEGORY SET VALUE

function set_category(id){
   document.getElementById("category_param").value = id;
   close_dropdown("category_drop");
}

//PROVINCE SET VALUE

 function set_province(id){
   document.getElementById("province_param").value = id;
   close_dropdown("province_drop");
 }

//PRICE RANGE SET VALUE

  function setPriceRange(){
  let mav = document.getElementById("maxprice_form").value;
  let miv = document.getElementById("minprice_form").value;

   if(mav==""||miv==""){
   alert("Vui lòng nhập đủ");
   return 0;
   }
   if(Number(mav) < Number(miv)){
   alert("Giá cao đang thấp hơn giá thấp");
   return 0;
   }
   if(mav<0||miv<0){
   alert("Giá tiền không được thấp hơn 0 đồng");
   return 0;
   }
   document.getElementById("maxprice_param").value = mav;
   document.getElementById("minprice_param").value = miv;
   close_dropdown("price_drop");
  }
//BRAND SET VALUE

  function setBrand(){
  name = document.getElementById("brand_form").value;
  if(name!=""){
     if(name.includes("'")){
     alert("Kí tự không hợp lệ");
     }else{
     document.getElementById("brand_param").value = name;
     close_dropdown("brand_drop");
     }
  }else{
     alert("Vui lòng nhập thương hiệu");
  }
  }


//CONDITION SET VALUE

   function setCondition(value){
   document.getElementById("condition_param").value = value;
   close_dropdown("condition_drop");
   }

//RATING DROPDOWM

   function setStar(value){
   document.getElementById("rating_param").value = value;
   close_dropdown("rating_drop");
   }

//PAYMENT SET VALUE

   function setPayment(value){
   document.getElementById("payment_param").value = value;
   close_dropdown("payment_drop");
   }

//TRANSPORT SET VALUE

   function setTransport(value){
   document.getElementById("transport_param").value = value;
   close_dropdown("transport_drop");
   }

//SEARCH RESULT MODE

 async function auto_slide(value){
    if(value>1){
    let direction = -1;
    while(!parameter.has("action")){
    for(let i=1;i<value;++i){
      await sleep(10000);
      moveSlide(direction,limit);
    }
    //reset
    direction=-direction;
    }
    }
 }

      if(parameter.get("action")=="search"){
         document.getElementById("idle_container").style.display = "none";
         let row = document.getElementsByName("search_container");
         let results = 0;
         results += Number(document.getElementById("result_count").innerHTML);
         for(let i=0;i<row.length;++i){
             row[i].style.display = "flex";
         }
         //display results count
         document.getElementById("show_bar").innerHTML = "&nbsp&nbsp"+results+"&nbspkết quả&nbsp&nbsp-&nbsp&nbsp<a href='home'>Trở về</a>";

      }else if(document.getElementById("display_mode").innerHTML == "idle"){
      let value = document.getElementById("slide_count").innerHTML;
      limit = slide_strip * Math.trunc(value);
      auto_slide(value);
      }

//IDLE SLIDE MODE

   async function moveSlide(direction,limit){

   if(!thread_run){
      let next_pos = translation + slide_strip * direction;
      let speed = 20;
      if((translation==0 && direction==1) || (-next_pos > limit)){
       return 0;
      }

      thread_run=true;//assign thread

      for(let i=0;i <= slide_strip;i+=speed){

         translation += direction * speed;
         slide.style.transform = "translate("+translation+"px,0px)";
         await sleep(1);
      }
   translation=next_pos;
   slide.style.transform = "translate("+translation+"px,0px)";
   thread_run=false;
   }
   }

     function addcart(pid){
     document.getElementById('action').value='tobuy';
     document.getElementById('pid').value=pid;
     document.getElementById("socket").submit();
     }

     function removecart(pid){
     document.getElementById('action').value='rmbuy';
     document.getElementById('pid').value=pid;
     document.getElementById("socket").submit();
     }

     function buynow(pid,uid){
     document.getElementById('action').value='buynow';
     document.getElementById('pid').value=pid;
     document.getElementById('uid').value=uid;
     document.getElementById("socket").submit();
     }

    </script>

</body>
</html>
