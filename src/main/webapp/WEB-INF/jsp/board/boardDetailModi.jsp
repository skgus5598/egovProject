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

    <title>SB Admin 2 - Tables</title>

    <!-- Custom fonts for this template -->
    <link href="${contextPath }/vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="${contextPath }/css/sb-admin-2.min.css" rel="stylesheet">

    <!-- Custom styles for this page -->
    <link href="${contextPath }/vendor/datatables/dataTables.bootstrap4.min.css" rel="stylesheet">

<script>
	function readURL(input){
		const file = input.files[0]
		if(file !=''){
			const reader = new FileReader();
			reader.readAsDataURL(file);
			reader.onload = function(e){
				$('#preview').attr('src', e.target.result);  
			}
		}
	}
	
	function fileDelete(){
		imgPath = $("input[name=imgPath]").val();
		boardSeq=$("input[name=boardSeq]").val();
		if(imgPath == null || imgPath ==''){
			alert("선택된 파일이 없습니다!")
		}else if(!confirm("파일을 삭제하시겠습니까?")){
			return false;
		}else{
			var arr ={
				"boardSeq" : boardSeq,
				"imgPath" : imgPath
			};
			console.log(arr);
			$.ajax({
				type: "post",
				url: "${contextPath}/board/deleteFile.do",
				data:  arr,
				success: function(data){
					console.log("here, path : " + data); // '' ㅇㅇ 
					$('#originImgDiv').remove();
					$('#searchId').remove();
					$('#preview').remove();


					let html = "";
					html += "<input type='hidden' name='imgPath' value=' "+data+ " ' >"	;
					html += "<input type='hidden' name='boardSeq' value='${dto.boardSeq}' >" 	;
					html += "<img id='preview' >"
					$("#deleteImg").html(html);

				},error : function(){
					alert("server error!!");
				}
			});
			
		} 
	}
	
	function fileSearch(){
		let html = "";
		html += "<input type='file' onchange='readURL(this)' name='imgPath' id='searchId' ><br>"	;
		html += "<img id='preview' >"
		$("#imgReply").html(html);


	}

	function fileSave(){
		alert("ccc!");
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
                        <a class="collapse-item" href="#">QnA</a>
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
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <form class="form-inline">
                        <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                            <i class="fa fa-bars"></i>
                        </button>
                    </form>

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

                        <!-- Nav Item - Alerts -->
                       

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
                                    src="${contextPath }/img/undraw_profile.svg">
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
                                <a class="dropdown-item" href="${contextPath }/admin/logout.do" >
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                                </c:if>
                    			<c:if test="${userName == null }">
                    			  <a class="dropdown-item" href="${contextPath }/loginForm.do" >
                                  <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                  Login
                                </a>
                                </c:if>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">

                    <!-- Page Heading -->
                    <h1 class="h3 mb-2 text-gray-800">General Forum</h1>

						
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-body">
                            <div class="table-responsive">
                           	<c:if test="${userName == null }">
                           		로그인 후 이용 가능합니다!
                           	</c:if>
                            <c:if test="${userName != null }">
                            <form action="${contextPath }/board/updateContent.do" method="post" enctype="multipart/form-data">
                            
                                <table class="table table-bordered" width="100%" cellspacing="0">
                              		<tr>
                              			<td>게시판 타입</td>
                              			<td>자유게시판</td>
                              		</tr>
                              			<tr>
                              			<td>작셩자</td>
                              			<td>
	                              			<input type="hidden" name="boardSeq" value="${dto.boardSeq }">
                              				<input type="text" style="width:200px"  value="${userName }" name="boardWriter" disabled />
                              			</td>
                              		</tr>
                              			<tr>
                              			<td>제목</td>
                              			<td>
                              				<input type="text" style="width:500px;"  name="boardTitle"  value="${dto.boardTitle }">             				
                              			</td>
                              		</tr>
                              			<tr>
                              			<td>내용</td>
                              			<td>
                              				<textarea rows="5" cols="70" name="boardText" >${dto.boardText }</textarea>                              				
                              			</td>
                              		</tr>
                              			<tr>
                              			<td>파일</td>
                              			<td style="display:flex">
                              				<div style="width:50%; ">
                              					<c:if test="${dto.imgPath == null || dto.imgPath =='' }">
                              						<div >
                              								<div id="imgReply"></div>
                              								<img id="preview">
                              						</div>
                              					</c:if>
                              					<c:if test="${dto.imgPath != null && dto.imgPath != '' }">
                              						<div id="originImgDiv">
	                              						<img src="${contextPath }/download.do?file=${dto.imgPath}" width="100px" height="100px" ><br>
	                              						${dto.imgPath }
	                              						<input type="hidden" name="imgPath" value="${dto.imgPath }" >
                              						</div>
                              						<div id="deleteImg" ></div>
                              						<div id="imgReply"></div>
                              						<img id="preview">
                              					</c:if>
                              				</div>
                              				<div style="width:50%;  text-align: center;  ">
                              					<a href="#" onclick="fileDelete()"/>파일삭제 |
	                              			    <a href="#"  onclick="fileSearch()"/>파일 찾기 |
	                              			    <a href="#"  onclick="fileSave()"/>파일저장 |
                              				</div>
                              			</td>
                              		
                              		</tr>
                              
                                </table>                                
                                <button type="button" onclick='location.href="${contextPath}/boardList.do" '   > 목록으로 </button>
                                <button type="submit"> SAVE</button>
                                
                                </form>
                            
                            
                           	</c:if>
                            
                            </div>
                        </div>
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

            <!-- Footer -->
            <footer class="sticky-footer bg-white">
                <div class="container my-auto">
                    <div class="copyright text-center my-auto">
                        <span>Copyright &copy; Your Website 2020</span>
                    </div>
                </div>
            </footer>
            <!-- End of Footer -->

        </div>
        <!-- End of Content Wrapper -->

    </div>
    <!-- End of Page Wrapper -->



    <!-- Bootstrap core JavaScript-->
    <script src="${contextPath }/vendor/jquery/jquery.min.js"></script>
    <script src="${contextPath }/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="${contextPath }/vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="${contextPath }/js/sb-admin-2.min.js"></script>

    <!-- Page level plugins -->
    <script src="${contextPath }/vendor/datatables/jquery.dataTables.min.js"></script>
    <script src="${contextPath }/vendor/datatables/dataTables.bootstrap4.min.js"></script>

    <!-- Page level custom scripts -->
    <script src="${contextPath }/js/demo/datatables-demo.js"></script>

</body>

</html>