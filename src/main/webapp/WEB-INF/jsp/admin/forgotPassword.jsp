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

    <title>SB Admin 2 - Forgot Password</title>

    <!-- Custom fonts for this template-->
    <link href="${contextPath }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="${contextPath }/css/sb-admin-2.min.css" rel="stylesheet">

</head>

<script>

	function forgotPwd(){
		userEmail = $('input[name=userEmail]').val();
		userPhone = $('input[name=userPhone]').val();
		var arr ={
				"userEmail" : userEmail,
				"userPhone" : userPhone
			};
		
		$.ajax({
			type : "post",
			url : "${contextPath}/forgotPwCheck.do",
			data : arr,
			success: function(data){
				if(data.result == 1){
					temp_pw_issue();		// 임시비밀번호 생성 					
				}else if(data.result == 0){
					alert("핸드폰 번호가 일치하지 않습니다!");
				}else{
					alert("존재하지 않는 이메일 입니다!");
				}
			},error : function(){
				alert("server error!!");
			}			
		});		
	}
	
	function temp_pw_issue(){
		let ranValue1 = ['1','2','3','4','5','6','7','8','9','0'];
		let ranValue2 = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z'];
		let ranValue3 = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
		let ranValue4 = ['!','@','#','$','%','^','&','*','(',')'];
		
		var temp_pw = "";
		
		for(i=0 ; i<2; i++) {
			let ranPick1 = Math.floor(Math.random() * ranValue1.length);
			let ranPick2 = Math.floor(Math.random() * ranValue2.length);
			let ranPick3 = Math.floor(Math.random() * ranValue3.length);
			let ranPick4 = Math.floor(Math.random() * ranValue4.length);
			temp_pw = temp_pw + ranValue1[ranPick1] + ranValue2[ranPick2] + ranValue3[ranPick3] + ranValue4[ranPick4];
		}
		
		alert("임시 비밀번호는 " + temp_pw + " 입니다.");
	//	$(".btn_noimg random_pw").hide();
		$("#random_pw").text("임시비밀번호 : "+temp_pw);		
	}

</script>

<body class="bg-gradient-primary">

    <div class="container">

        <!-- Outer Row -->
        <div class="row justify-content-center">

            <div class="col-xl-10 col-lg-12 col-md-9">

                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-none d-lg-block bg-password-image"></div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-2">Forgot Your Password?</h1>
                                        <p class="mb-4">We get it, stuff happens. Just enter your email address below
                                            and we'll send you a link to reset your password!</p>
                                    </div>
                                    
                                    <form class="user" >
                                        <div class="form-group">
                                            <input type="email" class="form-control form-control-user"
                                                name="userEmail"
                                                placeholder="Enter Email Address">
                                                <input type="text" class="form-control form-control-user"
                                                name="userPhone" placeholder="Enter Phone Number" >
                                        </div>
                                        <button class="btn btn-primary btn-user btn-block" type="button" onclick='forgotPwd()'>
                                            Issuing a temporary password
                                        </button>
                                    </form>
                                    
                                    <div id="random_pw">
                                    	
                                    </div>
                                    
                                    <hr>
                                    <div class="text-center">
                                        <a class="small" href="${contextPath }/registerForm.do">Create an Account!</a>
                                    </div>
                                    <div class="text-center">
                                        <a class="small" href="${contextPath }/loginForm.do">Already have an account? Login!</a>
                                    </div>
                                </div>
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