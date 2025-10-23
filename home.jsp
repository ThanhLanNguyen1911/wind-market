<%@page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
<style type="text/css">

a#signup,a#signin{
color: white;
text-decoration: none;
}

a#signup:hover,a#signin:hover{
color: gray;
}
</style>
    <div class="container-fluid">
        <div class="row" style="background-color: rgb(76,76,76)">
        <div class="col"></div>
        <div class="col text-center">
        <h1 style="color: rgb(250,80,110);margin-top: 5px"><b>Wind Market </b><i class="bi bi-cloud-fog2-fill"></i></h1>
        </div>
        <div class="col text-end" style="margin-top: 15px">
        <a id="signin" href="/wmarket/sign.html?action=signup">Đăng Ký&nbsp&nbsp</a>
        <a id="signup" href="/wmarket/sign.html?action=signin">Đăng Nhập</a>
        </div>
        </div>
    </div>
</head>
<body>

</body>
</html>
