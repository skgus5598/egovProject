<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="contextPath" value="${pageContext.request.contextPath }" />

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>SB Admin 2 - Dashboard</title>

    <!-- Custom fonts for this template-->
    <link href="${contextPath }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${contextPath }/css/sb-admin-2.min.css" rel="stylesheet">

 <script src="https://code.jquery.com/jquery-3.5.0.js"></script>
 
<style type="text/css">

#tempTable {
	background-color:white;
	text-align:center;
	border: orange;
	margin-left: 100px;
	margin-top: 100px;
	border-spacing: 50px;
	border-collapse: seperate;
}

#tempTable td{
	width:70px;
	height:70px;
}

#tempTable input{
	border:0;
	width:50px;
	height:50px;
	font-size: xx-large;
	text-align: center;
	color : transparent;
	text-shadow: 0 0 0 black;
}




#buttonTd{
		border: 0px;
}

#btn2, #btn3, #btn4, #btn5, #btn6  {
	display: none;
}




</style>

<script>
/*  얘는 제이쿼리 script 추가해야 쓸 수 있음. document.ready랑 같은 역할 
	$(function (){
		$("input").focus(function(){
		})
	
	});
*/




	function wordCheck(num){
	
		var originWord = $('input[name=originWord]').val();
		
		var a =  $('input[name='+num+'a]').val().toUpperCase();
		var b = $('input[name='+num+'b]').val().toUpperCase();
		var c = $('input[name='+num+'c]').val().toUpperCase();
		var d = $('input[name='+num+'d]').val().toUpperCase();
		var e = $('input[name='+num+'e]').val().toUpperCase();
		
		// 빈칸 체크  
		if((a+b+c+d+e).length != 5){ 
			alert("빠짐없이 입력해 주세요! ");			
			if(a == ''){
				return keyUp(num, 'a')				
			}else if(b == ''){
				return keyUp(num, 'b')				
			}else if(c == ''){
				return keyUp(num, 'c')				
			}else if(d == ''){
				return keyUp(num, 'd')				
			}else if(e == ''){
				return keyUp(num, 'e')				
			}
		}		
				
		if((a+b+c+d+e).toUpperCase() == originWord){
			alert("정답입니다!!");
			if(!confirm('한번 더!?')){
				return false;
			}else{
				location.href="${contextPath}/wordle.do";
			}
		}
		
		if(originWord.includes(a)){ // 문자 포함여부 
			if(originWord.charAt(0) == a){ // 문자열 인덱스 위치 동일 여부 
				$('input[name='+num+'a]').css('background-color', 'skyblue');
			}else{
				$('input[name='+num+'a]').css('background-color', 'yellow');
			}		
		}
		
		if(originWord.includes(b)){
			if(originWord.charAt(1) == b){  
				$('input[name='+num+'b]').css('background-color', 'skyblue');
			}else{
				$('input[name='+num+'b]').css('background-color', 'yellow');
			}
		}
		
		if(originWord.includes(c)){
			if(originWord.charAt(2) == c){ 
				$('input[name='+num+'c]').css('background-color', 'skyblue');
			}else{
				$('input[name='+num+'c]').css('background-color', 'yellow');
			}
		}
		
		if(originWord.includes(d)){
			if(originWord.charAt(3) == d){ 
				$('input[name='+num+'d]').css('background-color', 'skyblue');
			}else{
				$('input[name='+num+'d]').css('background-color', 'yellow');
			}
		}
		
		if(originWord.includes(e)){
			if(originWord.charAt(4) == e){ 
				$('input[name='+num+'e]').css('background-color', 'skyblue');
			}else{
				$('input[name='+num+'e]').css('background-color', 'yellow');
			}
		}
		
		if(num!= 6){
			//이전  제출 버튼 숨기기
			$('#btn'+num ).css('display', 'none');
			//다음 줄  제출 버튼 보이기  + 텍스트상자 포커스 
			$('#btn'+(num+1)).css('display', 'inline');
			keyUp((num+1),'');
			
		} else{   // 6번 시도 후 실패 시 
			$('#btn'+num ).css('display', 'none');
			alert("실패!!!!!!!!!!!!!");
			location.href="${contextPath}/wordle.do";
		}
	}
	

//한글 입력 방지
function fn_press_han(){
	$("input").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[^a-z]/gi,''));		
		}
	});	
}




//  옆칸으로 이동 
	function keyUp(num, obj){		
		if(num != 7){
			if(obj == ''){
				$('input[name='+num+'a]').focus();
			}else if(obj =='a'){
				if($('input[name='+num+'a]').val() == ''){
					$('input[name='+num+'a]').focus();
				}else{
					$('input[name='+num+'b]').focus();
				}			
			}else if(obj =='b'){
				if($('input[name='+num+'b]').val() == ''){
					$('input[name='+num+'b]').focus();
				}else if($('input[name='+num+'a]').val() == ''){
					$('input[name='+num+'b]').val('');
					$('input[name='+num+'a]').focus();
				}else{
					$('input[name='+num+'c]').focus();
				}
			}else if(obj =='c'){
				if($('input[name='+num+'c]').val() == ''){
					$('input[name='+num+'c]').focus();
				}else if($('input[name='+num+'b]').val() == ''){
					$('input[name='+num+'c]').val('');
					$('input[name='+num+'b]').focus();
				}else{
					$('input[name='+num+'d]').focus();
				}	
			}else if(obj =='d'){
				if($('input[name='+num+'d]').val() == ''){
					$('input[name='+num+'d]').focus();
				}else if($('input[name='+num+'c]').val() == ''){
					$('input[name='+num+'d]').val('');
					$('input[name='+num+'c]').focus();
				}else{
					$('input[name='+num+'e]').focus();
				}
			}else if(obj =='e'){
				if($('input[name='+num+'e]').val() == ''){
					$('input[name='+num+'e]').focus();
				}else if($('input[name='+num+'d]').val() == ''){
					$('input[name='+num+'e]').val('');
					$('input[name='+num+'d]').focus();
				}
			}
		}
		

}
	
</script>

</head>



<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="${contextPath }/main.do">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">CUSTOM*_* <sup>2</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                PAGES
            </div>

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

   
        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                   

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small">
                               <c:if test="${userName != null }">  <!--  ${userName}은 세션으로 줌  -->
                               ${userName }
                               </c:if>
                               <c:if test="${userName == null }">
                               Guest 
                               </c:if>
                                </span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <div class="dropdown-divider"></div>
                                <c:if test="${userName != null }">                                            
                                <a class="dropdown-item" href="admin/logout.do" >
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                                </c:if>
                    			<c:if test="${userName == null }">
                    			  <a class="dropdown-item" href="loginForm.do" >
                                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                  Login
                                </a>
                    			</c:if>                              
                            </div>
                        </li>
                    </ul>
                </nav>
		
		<h1> Wordle !</h1>
		<h2>check : ${originWord }</h2>
		<input type="hidden" name="originWord" value="${originWord }" >
		
	
			<table id="tempTable"  border="1">
				<c:forEach var="num" begin="1" end="6" >
					<tr id="${num }">
						<td><input type="text"  name="${num}a"    onkeyup="keyUp('${num}', 'a')"  onkeydown="fn_press_han()" maxlength="1" style="ime-mode:disabled;"></td>
						<td><input type="text"  name="${num}b"    onkeyup="keyUp('${num}' , 'b')"  onkeydown="fn_press_han()" maxlength="1" style="ime-mode:disabled;"></td>
						<td><input type="text"  name="${num}c"  onkeyup="keyUp('${num}', 'c')"  onkeydown="fn_press_han()" maxlength="1" style="ime-mode:disabled;"></td>
						<td><input type="text"  name="${num}d"   onkeyup="keyUp('${ num}', 'd')" onkeydown="fn_press_han()" maxlength="1" style="ime-mode:disabled;"></td>
						<td><input type="text"  name="${num}e"  onkeyup="keyUp('${num}', 'e')" onkeydown="fn_press_han()"  maxlength="1" style="ime-mode:disabled;"></td>
						<td id="buttonTd"><button id="btn${num}"  type="button" onclick="wordCheck(${num})" >제출</button></td>
					</tr>			
				</c:forEach>
			</table>

			</div>
        </div>
    </div>



    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>


</body>

</html>