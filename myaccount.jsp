<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style>
    body{
    background-color: gray;
    }
    h5{
    color:rgb(240,240,240);
    }

</style>
</head>
<body>

   <form id="msocket" action="home" method="POST" enctype="multipart/form-data">
   <input type="hidden" name="action" value="edituser">
   <input id="image_param" name="image" type="file" class="form-control" style="display:none">
   <input type="hidden" id="option_param" name="option">
   </form>

   <form id="socket" action="home" method="POST">
   <input type="hidden" name="action" value="edituser">
   <input type="hidden" id="name_param" name="name">
   <input type="hidden" id="email_param" name="email">
   <input type="hidden" id="age_param" name="age">
   <input type="hidden" id="address_param" name="address">
   <input type="hidden" id="number_param" name="number">
   <input type="hidden" id="province_param" name="province">
   <input type="hidden" id="password_param" name="password">
   </form>

   <div class="container-fluid">
        <div class="row" style="background-color: rgb(76,76,76)">
        <div class="col text-start">
        <h1>
        <a style="color: rgb(200,200,200);text-decoration: none;margin-top: 5px"><b><i onclick="exit()" class="bi bi-chevron-left" style="font-size: 2rem"></i>&nbsp</b></a>
        </h1>
        </div>
        <div class="col text-center">
        <h1 style="color: rgb(250,80,110);margin-top: 5px"><b>Wind Market </b><i class="bi bi-cloud-fog2-fill"></i></h1>
        </div>
        <div class="col"></div>
        </div>

        <div class="row">
        <div class="col-2"></div>
        <div class="col-8 text-center">

        <c:set var="profile_picture" value="${myuser.GetImage()}"/>
        <c:if test="${profile_picture == null}">
        <button class="btn bg-transparent text-white rounded-circle p-2" style="font-size: 8rem;margin: 2%" onclick="document.getElementById('picture_option').style.display='inline'"><i class="bi bi-person-circle"></i></button>
        </c:if>
        <c:if test="${profile_picture != null}">
        <img src="${profile_picture}" width="20%" height="22%" class="btn rounded-circle" style="object-fit: fill;margin: 2%" onclick="document.getElementById('picture_option').style.display='inline'"/>
        </c:if>

        <div class="row"><div style="margin-top: -6%"><b style="color:white;background-color:rgb(76,76,76);border-radius:10px">&nbsp<i class="bi bi-camera"></i>&nbsp</b></div></div>

        <div class="row justify-content-center">
        <div id="picture_option" style="display: none;border: solid gray 1px;border-radius: 10px;width: 28%;position: absolute">
        <b onclick="load_image(1)" style="border:solid gray 1px" class="list-group-item list-group-item-action list-group-item-dark">Cập nhật ảnh đại diện</b>
        <b onclick="load_image(0)" style="border:solid gray 1px" class="list-group-item list-group-item-action list-group-item-dark">Xóa ảnh đại diện</b>
        <b onclick="this.parentNode.style.display='none'" style="border:solid gray 1px" class="list-group-item list-group-item-action list-group-item-dark"><i class="bi bi-x-circle"></i>&nbspĐóng</b>
        </div>
        </div>

        <div class="row"><h3 style="color:white"><div id="p1" style="display: inline-block">${myuser.GetName()}</div>&nbsp<i class="bi bi-pencil-square" onclick="prompt_input('name_param','p1','Nhập tên mới','${myuser.GetName()}')"></i></h3></div>

        <div class="row"><h6 style="color:rgb(250,250,200)"><div id="p2" style="display: inline-block">${myuser.GetEmail()}</div>&nbsp<i class="bi bi-pencil-square" onclick="prompt_input('email_param','p2','Nhập email mới','${myuser.GetEmail()}')"></i></h6></div>

        <div class="row"><h5><div id="p3" style="display: inline-block">${myuser.GetAge()}</div>&nbspTuổi&nbsp<i class="bi bi-pencil-square" onclick="prompt_input('age_param','p3','Nhập tuổi mới','${myuser.GetAge()}')"></i></h5></div>
        <br>

        <div class="row"><div class="col-4 text-end"><b style="color:rgb(76,76,76)">Địa chỉ:</b></div><div class="col-8 text-start"><h5><div id="p4" style="display: inline-block">${myuser.GetAddress()}</div>&nbsp<i class="bi bi-pencil-square" onclick="prompt_input('address_param','p4','Nhập địa chỉ mới','${myuser.GetAddress()}')"></i></h5></div></div>
        <br>
        <div class="row"><div class="col-4 text-end"><b style="color:rgb(76,76,76)">SĐT:</b></div><div class="col-8 text-start"><h5><div id="p5" style="display: inline-block">${myuser.GetNumber()}</div>&nbsp<i class="bi bi-pencil-square" onclick="prompt_input('number_param','p5','Nhập số điện thoại mới','${myuser.GetNumber()}')"></i></h5></div></div>
        <br>
        <div class="row">
        <div class="col-4 text-end" style="margin-top: 4px"><b style="color:rgb(76,76,76)">Xác nhận tỉnh:</b></div>
        <div class="col-8 text-start" style="width:40%">

        <c:set var="myprovince" value="${myuser.GetProvince()}"/>

            <select id="province_form" class="form-select" onclick="if(this.value>0&&this.value!=${myprovince}){++data_changes}">
            <c:if test="${myprovince == 0}">
            <script>alert("Vui lòng xác thực tỉnh thành cư trú để bán hàng");document.getElementById("province_form").focus();</script>
            <option selected>Chọn tỉnh</option>
            </c:if>
            <c:if test="${myprovince > 0}">
            <option selected>Đã xác thực</option>
            </c:if>
            <c:forEach items="${user_locations}" var="i">
            <option value="${i.GetId()}" style="<c:if test='${myprovince == i.GetId()}'>color:white;background-color:rgb(100,100,100)</c:if>">${i.GetName()}</option>
            </c:forEach>
            </select>
        </div>
        </div>
        <br>
        <div class="row">
        <div class="col-4 text-end" style="margin-top: 4px">
        <b style="color:rgb(76,76,76)">Mật khẩu:</b>
        </div>
        <div class="col-8 text-start">
        <input id="password_form" name="password" style="width:58%" class="form-control" type="password" placeholder="Đổi mật khẩu">
        </div>
        </div>
        <br>
        <button class="btn btn-secondary" style="width: 200px" onclick="save_info()">Lưu</button >
        <br>
        &nbsp
        </div>
        <div class="col-2"></div>
        </div>

    </div>

   <script>
      let data_changes=0;

     function prompt_input(param,field,title,fill){
     let prompt_value = prompt(title,fill);
     if(prompt_value != "" && prompt_value !== null && prompt_value != fill){
     document.getElementById(param).value = prompt_value;
     document.getElementById(field).innerHTML = prompt_value;
     ++data_changes;
     }
     }

     function save_info(){
     let newpassword = document.getElementById("password_form").value;
     let newprovince = document.getElementById("province_form").value;

     if(newpassword != ""){
     document.getElementById("password_param").value = newpassword;
     }
     if(newprovince != ""){
     document.getElementById("province_param").value = newprovince;
     }
     document.getElementById("socket").submit();
     }

     function exit(){
     if(data_changes>0){
        if(confirm('Thay đổi chưa lưu sẽ bị hủy khi rời khỏi trang?')){
          window.location.assign("home");
        }
     }else{
         window.location.assign("home");
     }
     }

     function load_image(open){
     if(open){
     document.getElementById("option_param").value="updatephoto";
     let filebox = document.getElementById("image_param");
     filebox.click();

     filebox.addEventListener('change',function(){if(this.files.length > 0){document.getElementById("msocket").submit();}});

     }else{
     document.getElementById("option_param").value="defaultphoto";
     document.getElementById("msocket").submit();
     }
     }

   </script>
</body>
</html>
