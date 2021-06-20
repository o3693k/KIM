<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html lang="en">

<%@ include file="../include/head.jsp" %>

<body class="hold-transition sidebar-mini">
<div class="wrapper">

  <!-- Navbar -->
  <%@ include file="../include/main_header.jsp" %>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
 <%@ include file="../include/left_column.jsp" %>


  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <div class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1 class="m-0 text-dark">User Profile Page</h1>
          </div><!-- /.col -->
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Home</a></li>
              <li class="breadcrumb-item active">Starter Page</li>
            </ol>
          </div><!-- /.col -->
        </div><!-- /.row -->
      </div><!-- /.container-fluid -->
    </div>
    <!-- /.content-header -->

    <!-- Main content -->
    <div class="content">
      <div class="container-fluid"> 
		<div class="row"> 
		<div class="col-md-5"> 
		<div class="card card-primary card-outline"> 
		<div class="card-body box-profile"> 
		<div class="text-center"> 
		<img class="profile-user-img img-fluid img-circle" src="${path}/dist/img/profile/${login.userImg}" alt="User profile picture"> 
		</div> 
		<h3 class="profile-username text-center">${login.userName}</h3> 
		<div class="text-center"> 
		<a href="#" class="btn btn-primary imgModBtn" data-toggle="modal" data-target="#userPhotoModal"> <i class="fa fa-photo"> 프로필사진 수정</i> </a> 
		</div> 
		<ul class="list-group list-group-unbordered mb-5"> 
		<li class="list-group-item"><b>아이디</b> 
		<a class="float-right">${login.userId}</a></li> 
		<li class="list-group-item"><b>이메일</b> 
		<a class="float-right">${login.userEmail}</a></li> 
		<li class="list-group-item"><b>가입일자</b> 
		<a class="float-right"> <fmt:formatDate value="${login.userJoinDate}" pattern="yyyy-MM-dd" /> </a></li> 
		<li class="list-group-item"><b>최근 로그인 일자</b> 
		<a class="float-right"> <fmt:formatDate value="${login.userLoginDate}" pattern="yyyy-MM-dd" /> </a></li> 
		</ul> 
		</div> 
		
		<div class="card-footer text-center"> 
		<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#userInfoModal"> <i class="fa fa-info-circle"> 회원정보 수정</i> </a> 
		<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#userPwModal"> <i class="fa fa-question-circle"> 비밀번호 수정</i> </a> 
		<a href="#" class="btn btn-primary btn-xs" data-toggle="modal" data-target="#userOutModal"> <i class="fa fa-user-times"> 회원 탈퇴</i> </a> 
		</div> 
		</div> 
		</div> 
		<div class="col-md-7"> 
		<div class="card"> 
		<div class="nav-tabs-custom"> 
		<div class="card-header p-2"> 
		<ul class="nav nav-pills"> 
		<li class="nav-item"> 
		<a class="nav-link active" href="#myPosts" data-toggle="tab"> <i class="fas fa-pencil-square-o"></i> 나의 게시물 </a> </li> 
		<li class="nav-item"> 
		<a class="nav-link" href="#myReplies" data-toggle="tab"> <i class="fas fa-comment-o"></i> 나의 댓글 </a> </li> 
		</ul> 
		</div> 
		
		<div class="card-body"> 
		<div class="tab-content"> 
		<div class="active tab-pane" id="myPosts"> 
		<table id="myPostsTable" class="table table-bordered table-striped"> 
		<thead> 
		<tr> 
		<th style="width: 10%">번호</th> 
		<th style="width: 70%">제목</th> 
		<th style="width: 20%">작성일자</th> 
		</tr> 
		</thead> 
		<tbody> 
		<c:forEach var="articleVO" varStatus="i" items="${userBoardList}"> 
		<tr> 
		<td>${i.index + 1}</td> 
		<td><a href="${path}/article/paging/search/read?article_no=${articleVO.article_no}"> 
		<c:choose> 
		<c:when test="${fn:length(articleVO.title) > 30}"> 
		<c:out value="${fn:substring(articleVO.title, 0, 29)}" />.... 
		</c:when> 
		<c:otherwise> 
		<c:out value="${articleVO.title}" /> 
		</c:otherwise> 
		</c:choose> 
		</a>
		</td> 
		<td><fmt:formatDate pattern="yyyy-MM-dd" value="${articleVO.regDate}" />
		</td> 
		</tr> 
		</c:forEach> 
		</tbody> 
		</table> 
		</div> 
		<div class="tab-pane" id="myReplies"> 
		<table id="myRepliesTable" class="table table-bordered table-striped"> 
		<thead> 
		<tr> 
		<th style="width: 10px">번호</th> 
		<th style="width: 250px">게시글 제목</th> 
		<th style="width: 250px">내용</th> 
		<th style="width: 150px">작성일자</th> 
		</tr> 
		</thead> 
		<tbody> 
		<c:forEach var="userReply" varStatus="i" items="${userReplies}"> 
		<tr> 
		<td>${i.index + 1}</td> 
		<td><a href="${path}/article/paging/search/read?article_no=${userReply.articleVO.article_no}"> 
		<c:choose> 
		<c:when test="${fn:length(userReply.articleVO.title) > 10}"> 
		<c:out value="${fn:substring(userReply.articleVO.title, 0, 9)}" />.... 
		</c:when> 
		<c:otherwise> 
		<c:out value="${userReply.articleVO.title}" /> 
		</c:otherwise> 
		</c:choose> 
		</a>
		</td> 
		<td>
		<c:choose> 
		<c:when test="${fn:length(userReply.reply_text) > 10}"> 
		<c:out value="${fn:substring(userReply.reply_text, 0, 9)}" />.... 
		</c:when> 
		<c:otherwise> 
		<c:out value="${userReply.reply_text}" /> 
		</c:otherwise> 
		</c:choose>
		</td> 
		<td>
		<fmt:formatDate pattern="yyyy-MM-dd" value="${userReply.reg_date}" />
		</td> 
		</tr> 
		</c:forEach> 
		</tbody> 
		</table> 
		</div> 
		</div> 
		</div> 
		</div> 
		</div> 
		</div> 
		</div> 
		</div>
      
<!-- /.container-fluid -->
    </div>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Control sidebar content goes here -->
    <div class="p-3">
      <h5>Title</h5>
      <p>Sidebar content</p>
    </div>
  </aside>
  <!-- /.control-sidebar -->

  <!-- Main Footer -->
  <%@ include file="../include/main_footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<%@ include file="../include/plugin_js.jsp" %>

<script>
	$(document).ready(function(){
		
		var msg = "${msg}";
		if(msg == "FAILURE"){
			alert("비밀번호가 일치하지 않습니다. 비밀번호를 확인해주세요.");
		}else if(msg =="FAIL"){
			alert("이미지가 존재하지 않습니다.");
		}else if(msg == "SUCCESS"){
			alert("수정되었습니다.");
		}
		
		$(".infoModBtn").on("click", function(){
			$("#userInfoForm").submit();
		});
		
		$(".pwModBtn").on("click", function(){
			$("#userPwForm").submit();
		});
		
		$(".imgModBtn").on("click", function(){
			var file = $("#file").val();
			if(file==""){
				alert("파일을 선택해주세요.");
				return;
			}
			$("#userImageForm").submit();
		});
		var param = {
				"language": { 
					"lengthMenu": "_MENU_ 개씩 보기", 
					"zeroRecords": "내용이 없습니다.", 
					"info": "현재 _PAGE_ 페이지 / 전체 _PAGES_ 페이지", 
					"infoEmpty": "내용이 없습니다.", 
					"infoFiltered": "( _MAX_개의 전체 목록 중에서 검색된 결과)", 
					"search": "검색:", 
					"paging": { 
						"first": "처음", 
						"last": "마지막", 
						"next": "다음", 
						"previous": "이전" 
						} 
				} 
			}; 
			$("#myPostsTable").DataTable(param); 
			$("#myRepliesTable").DataTable(param); 
			$("#myBookmarksTable").DataTable(param);	
	});
</script>
</body>
</html>
