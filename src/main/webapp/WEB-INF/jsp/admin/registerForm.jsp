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

    <title>SB Admin 2 - Register</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>   <!-- jquery -->
    
    <style type="text/css">
    .id_ok{color: #6A82FB; display: none;}
    .id_exist{color:red; display: none;}
    .id_symbols{color:red; display: none;}
    .id_length{color:red; display: none;}
    
    .email_ok{color: #6A82FB; display: none;}
    .email_exist{color:red; display: none;}
    .email_type{color:red; display: none;}
    
    
    .phoneCheck_fail{color:red; display: none;}
    .pwdCheck_fail{color:red; display: none;}
    .pwdRepeat_fail{color:red; display: none;}
    </style>
    
<script type="text/javascript">
/*  $(function() {	// 즉시 실행 함수 
 }); */
 
function phoneCheck(){
	var userPhone = $('input[name=userPhone]').val();
    var regPhone = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
	if(regPhone.test(userPhone) === true){
		$('.phoneCheck_fail').css("display", "none");
	}else{
		$('.phoneCheck_fail').css("display", "inline-block");
		$('#userPhone').val("");
		$('#userPhone').focus();
	}
 } 
 
  function emailCheck(){  //  이메일 형식 , 중복 체크 
	 var userEmail = $('input[name=userEmail]').val();
 	 console.log("userEmail : " + userEmail);
 	 $.ajax({
 		url : "${contextPath}/userEmailCheck.do?userEmail=" + userEmail,
		type : 'get',
		success : function(data){
			if(data.result == 1){
				//성공 
					$('.email_ok').css("display", "inline-block");
					$('.email_exist').css("display", "none");
					$('.email_type').css("display", "none");
			}else if(data.result ==2){
				// 이메일 형식 안맞
					$('.email_ok').css("display", "none");
					$('.email_exist').css("display", "none");
					$('.email_type').css("display", "inline-block");
					$('#userEmail').val("");
					$('#userEmail').focus();
			}else{
				// 이메일 중복 
				$('.email_ok').css("display", "none");
				$('.email_exist').css("display", "inline-block");
				$('.email_type').css("display", "none");
				$('#userEmail').val("");
				$('#userEmail').focus();
			}			
		},error : function(){
			alert("서버문제 발생");
		}
 	 });
 } 
 
function nickCheck(){  // 닉네임 형식, 중복 체크 
	 var userNick = $('input[name=userNick]').val();
	 console.log("usernick : : " + userNick);		 
		$.ajax({
			url : "${contextPath}/userNickCheck.do?userNick=" + userNick,
			type : 'get',
			success : function(data){
				console.log(data.result) 
				if(data.result == 1){
					$('.id_ok').css("display", "inline-block");
					$('.id_exist').css("display", "none");
					$('.id_length').css("display", "none");
					$('.id_symbols').css("display", "none");
				}else if(data.result == 0 ){
					$('.id_exist').css("display", "inline-block");
					$('.id_ok').css("display", "none");
					$('.id_length').css("display", "none");
					$('.id_symbols').css("display", "none");
					$('#userNick').val("");
					$('#userNick').focus();
				}else if(data.result == 2){
					$('.id_length').css("display", "inline-block");
					$('.id_ok').css("display", "none");
					$('.id_exist').css("display", "none");
					$('.id_symbols').css("display", "none");
					$('#userNick').focus();
					$('#userNick').val("");
				}else if(data.result == 3){
					$('.id_symbols').css("display", "inline-block");
					$('.id_ok').css("display", "none");
					$('.id_exist').css("display", "none");
					$('.id_length').css("display", "none");
					$('#userNick').val("");
					$('#userNick').focus();
				}else{	}
			},error : function(){
				alert("서버문제 발생");
			}
		});
} 
 

function pwdCheck(){
	var userPwd = $('input[name=userPwd]').val(); 
	console.log("pwd: " + userPwd);
	var regPwd = /^.*(?=^.{8,20}$)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;  //문자 & 특수문자 조합 8-20자리 
	if(regPwd.test(userPwd) ===true){
		$('.pwdCheck_fail').css("display", "none");
	}else{
		$('.pwdCheck_fail').css("display", "inline-block");
		$('#userPwd').val( "");
		//$('#userPwd').focus();
	}
}
function pwdRepeatCheck(){
	var pwdRepeat = $('input[name=userPwdCheck]').val();
	var userPwd = $('input[name=userPwd]').val();
	if(pwdRepeat == userPwd){
		$('.pwdRepeat_fail').css("display", "none");
	}else{
		$('.pwdRepeat_fail').css("display", "inline-block");
		$('#userPwdCheck').val("");
	//	$('#userPwdCheck').focus();
	}
}

function registerAcc(){	// 생년월일 , 주소  --> 필수 ㄴ 

	var userName = $('input[name=userName]').val(); 
	var userNick = $('input[name=userNick]').val(); 
	var userEmail = $('input[name=userEmail]').val(); 

	var userPhone = $('input[name=userPhone]').val(); 
	var userPwd = $('input[name=userPwd]').val(); 
	var userPwdCheck = $('input[name=userPwdCheck]').val(); 
	console.log("userPhone : " + userPhone);
	
	if (userName ==""){
		alert("이름은 필수사항 입니다!");
		$('#userName').focus();
	}else if(userNick ==""){
		alert("닉네임은 필수사항 입니다!");
		$('#userNick').focus();
	}else if(userEmail ==""){
		alert("이메일은 필!수!사항 입니다.")
		$('#userEmail').focus();
	}else if(userPhone==""){
		alert("번호는 필수사항 입니다!");
		$('#userPhone').focus();
	}else if(userPwd ==""){
		alert("비밀번호를 입력해 주세요!");
		$('#userPwd').focus();
	}else if(userPwdCheck ==""){
		alert("비밀번호를 한번 더 확인해 주세요!")
		$('#userPwdCheck').focus();
	} else{
		fo.submit();	
	}

}

	 

	

</script>

</head>

<body class="bg-gradient-primary">

    <div class="container">

        <div class="card o-hidden border-0 shadow-lg my-5">
            <div class="card-body p-0">
                <!-- Nested Row within Card Body -->
                <div class="row">
                    <div class="col-lg-5 d-none d-lg-block bg-register-image"></div>
                    <div class="col-lg-7">
                        <div class="p-5">
                            <div class="text-center">
                                <h1 class="h4 text-gray-900 mb-4">Create an Account!</h1>
                            </div>
                            
                            
                            
                            <form id="fo" class="user"  action="admin/registerAcc.do" method="post">
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="text" class="form-control form-control-user" id="exampleFirstName" name="userName"
                                            placeholder="Name">
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="text" class="form-control form-control-user" id="exampleLastName" name="userBirth"
                                            placeholder="Birth ex)20000101">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user"  onblur="nickCheck()"  id="userNick"  name="userNick"
                                        placeholder="NickName">
                                        <span class="id_ok"> 사용 가능한 닉네임 입니다.</span>
                                        <span class="id_exist">이미 존재하는 닉네임 입니다.</span>
                                        <span class="id_symbols">특수문자를 사용할 수 없습니다.</span>
                                       	<span class="id_length"> 30자 이하로 입력해주세요 </span>

                                        
                                </div>
                                <div class="form-group">
                                    <input type="email" class="form-control form-control-user"  id="userEmail" name="userEmail"
                                        placeholder="Email Address" onblur="emailCheck()">
                                        <span class="email_ok"> 사용 가능한 이메일 입니다.</span>
                                        <span class="email_exist">이미 존재하는 이메일 입니다.</span>
                                        <span class="email_type">이메일 형식이 올바르지 않습니다.</span>
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user" id="exampleInputEmail" name="userAddr"
                                        placeholder="Address">
                                </div>
                                <div class="form-group">
                                    <input type="text" class="form-control form-control-user"  id="userPhoneCheck" name="userPhone"
                                        placeholder="Phone ex)010-1234-1234" onblur="phoneCheck()">
                                        <span class="phoneCheck_fail"> 형식에 맞게 입력해 주세요 ex) 010-1111-1111</span>
                                        
                                        
                                </div>
                                <div class="form-group row">
                                    <div class="col-sm-6 mb-3 mb-sm-0">
                                        <input type="password" class="form-control form-control-user" name="userPwd"
                                            id="userPwd" placeholder="Password" onblur="pwdCheck()">
                                            	<span class="pwdCheck_fail">문자와 특수문자 조합 8-20자리</span>
                                    </div>
                                    <div class="col-sm-6">
                                        <input type="password" class="form-control form-control-user" name="userPwdCheck"
                                            id="userPwdCheck" placeholder="Repeat Password" onblur="pwdRepeatCheck()">
                                          <span class="pwdRepeat_fail">비밀번호가 다릅니다 </span>
                                            
                                    </div>
                                </div>
                                <button type="button" class="btn btn-primary btn-user btn-block" onclick="registerAcc()">
                                    Register Account
                                </button>
                                
                             </form>    
                                
                                
                                
                                
                                <hr>
                                <a href="index.html" class="btn btn-google btn-user btn-block">
                                    <i class="fab fa-google fa-fw"></i> Register with Google
                                </a>
                                <a href="index.html" class="btn btn-facebook btn-user btn-block">
                                    <i class="fab fa-facebook-f fa-fw"></i> Register with Facebook
                                </a>
                           
                            <hr>
                            <div class="text-center">
                                <a class="small" href="forgot-password.html">Forgot Password?</a>
                            </div>
                            <div class="text-center">
                                <a class="small" href="login.html">Already have an account? Login!</a>
                            </div>
                        </div>
                    </div>
                </div>
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