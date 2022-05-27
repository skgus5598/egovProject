<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <title>SB Admin 2 - Tables</title>
    
    <link rel="stylesheet"  type="text/css" media="screen" href="${contextPath }/vendor/jquery/jquery-ui.css">
    <link rel="stylesheet"  type="text/css" media="screen" href="${contextPath }/jqgrid/css/ui.jqgrid.css">
    
    <link href="${contextPath }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${contextPath }/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="${contextPath }/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">
      <link href="${contextPath}/vendor/jquery/jquery-ui.css" rel="stylesheet">
    <link href="${contextPath }/jqgrid/css/ui.jqgrid.css" rel="stylesheet">
    
</head>
<!-- 
<script src="//code.jquery.com/jquery-1.11.0.min.js" > </script>
 -->
 <script src="${contextPath }/vendor/jquery/jquery.min.js"></script>
 <script src="${contextPath }/jqgrid/js/i18n/grid.locale-kr.js" > </script>
<script src="${contextPath }/jqgrid/js/minified/jquery.jqGrid.min.js" > </script>


<script>
	var resultColName=['이름', '닉네임', '메일' , '핸드폰번호', '주소', '유저권한', '탈퇴여부'];
 	var resultColModel = [
		{name : "userName", index : "userName" },
		{name : "userNick", index : "userNick"},
		{name : "userEmail", index : "userEmail"},
		{name : "userPhone", index : "userPhone"},
		{name : "userAddr", index : "userAddr"},
		{name : "userAuth", index : "userAuth"},
		{name : "delYn", index : "delYn"}
	]; 
 	/*
  	var resultColModel2=[
		{name : 'custom_user_name', index : 'custom_user_name' },
		{name : 'custom_user_nick', index : 'usercustom_user_nickNick'},
		{name : 'custom_user_email', index : 'custom_user_email'},
		{name : 'custom_user_phone', index : 'custom_user_phone'},
		{name : 'custom_user_address', index : 'custom_user_address'},
		{name : 'custom_user_auth', index : 'custom_user_auth'},
		{name : 'custom_user_del_yn', index : 'custom_user_del_yn'}
 	]; 
 */
// name : 서버로부터 넘어오는 데이터명 명시 /꼭 컬럼(VO)과 매칭을 시켜줘야하며 colName 개수와 일치
// index : 서버로 전송 시 넘어가는 데이터명


	$(function(){
		$("#mainGrid").jqGrid({
			url:"${contextPath}/memberList.do",
			dataType : "json",	
			mtype:"get",
//			data: "memList",
			colNames: resultColName,
			colModel: resultColModel,
			caption:"회원목록",
			rowNum : 10,
			rowList:[10,20,30],
			viewrecords : true,
			pager: "#pager",
			loadError : function(xhr, status, error){
				alert(xhr.responseText);
			}, loadComplete : function(data){
				alert("success");
			}
			
		});
		console.log("ooooo");
	});



</script>

<body id="page-top">

  <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${contextPath }/main.do">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">



            <!-- Nav Item - Pages Collapse Menu -->
                 <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>게시판</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="${contextPath }/loginForm.do">Login</a>
                        <a class="collapse-item" href="${contextPath }/registerForm.do">Register</a>                        
                        <a class="collapse-item" href="${contextPath }/forgotPw.do">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="${contextPath }/boardList.do">Board</a>
                        <a class="collapse-item" href="${contextPath }/wordle.do">Wordle</a>
                         <div class="collapse-divider"></div>
                        <h6 class="collapse-header">ADMIN PAGES:</h6>
                        <a class="collapse-item" href="${contextPath }/memberListPage.do">Member management</a>
                    </div>
                </div>
            </li>
               <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
            
	
	<div class="tableWrap">
		<table id="mainGrid"></table>
		<div id="pager"></div>
	</div>



    <script src="${contextPath }/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="${contextPath }/vendor/jquery-easing/jquery.easing.min.js"></script>
    <script src="${contextPath }/js/sb-admin-2.min.js"></script>
    <script src="${contextPath }/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${contextPath }/vendor/datatables/dataTables.bootstrap4.min.js"></script>
    <script src="${contextPath }/js/demo/datatables-demo.js"></script>

</body>

</html>