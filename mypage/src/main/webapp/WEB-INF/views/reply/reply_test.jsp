<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

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
            <h1 class="m-0 text-dark">Starter Page</h1>
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
    <section class="content container-fluid">
    	<div class="col-lg-12"> 
			<div class="card"> 
				<div class="card-header with-border"> 
					<h3 class="card-title">댓글 작성</h3> 
				</div> 
				<div class="card-body"> 
					<div class="row"> 
					<div class="form-group col-sm-8"> 
					<input class="form-control input-sm" id="newReplyText" type="text" placeholder="댓글 입력..."> 
					</div> 
					<div class="form-group col-sm-2"> 
					<input class="form-control input-sm" id="newReplyWriter" type="text" placeholder="작성자"> 
					</div> 
					<div class="form-group col-sm-2"> 
						<button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn"> <i class="fa fa-save"></i> 저장 </button> 
					</div> 
					</div> 
				</div> 
		<div class="card-footer"> 
			<ul id="replies"> 
			
			</ul> 
		</div> 
		<div class="card-footer"> 
			<nav aria-label="Contacts Page Navigation"> 
				<ul class="pagination pagination-sm no-margin justify-content-center m-0"> 
				</ul> 
			</nav> 
		</div> 
		</div> 
		</div> 
		<div class="modal fade" id="modifyModal" role="dialog"> 
		<div class="modal-dialog"> 
		<div class="modal-content"> 
		<div class="modal-header"> 
		<button type="button" class="close" data-dismiss="modal">&times;
		</button> 
		<h4 class="modal-title">댓글 수정창</h4> 
		</div> 
		<div class="modal-body"> 
		<div class="form-group"> 
		<label for="reply_no">댓글 번호</label> 
		<input class="form-control" id="reply_no" name="reply_no" readonly> 
		</div> 
		<div class="form-group"> 
		<label for="reply_text">댓글 내용</label> 
		<input class="form-control" id="reply_text" name="reply_text" placeholder="댓글 내용을 입력해주세요"> 
		</div> 
		<div class="form-group"> 
		<label for="reply_writer">댓글 작성자</label> 
		<input class="form-control" id="reply_writer" name="reply_writer" readonly> 
		</div> 
		</div> 
		<div class="modal-footer"> 
			<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button> 
			<button type="button" class="btn btn-success modalModBtn">수정</button> 
			<button type="button" class="btn btn-danger modalDelBtn">삭제</button> 
		</div> 
		</div> 
		</div> 
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
	// 88번째 게시글 
	var article_no = 88;
	 
	// 댓글 목록 호출 
	var replyPageNum = 1;
	
	getRepliesPaging(replyPageNum);
	
	// 댓글 목록 출력 함수 
	function getReplies() { 
		$.getJSON("${path}/replies/all/" + article_no, function (data) {
			 console.log(data); 
			 var str = ""; 

			$(data).each(function () { 
				str += "<li data-reply_no='" + this.reply_no + "' class='replyLi'>" 
				+ "<p class='reply_text'>" + this.reply_text + "</p>" 
				+ "<p class='reply_writer'>" + this.reply_writer + "</p>" 
				+ "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>" 
				+ "</li>" 
				+ "<hr/>"; 
			}); 

			$("#replies").html(str); 
		}); 
	}
	
	$(".replyAddBtn").on("click",function() { 

		// 화면으로부터 입력 받은 변수값의 처리 
		var reply_text = $("#newReplyText"); 
		var reply_writer = $("#newReplyWriter"); 

		var reply_textVal = reply_text.val(); 
		var reply_writerrVal = reply_writer.val(); 
		
		console.log("1212121212");
		// AJAX 통신 : POST 
		$.ajax({ 
			type : "post", 
			url : "${path}/replies", 
			headers : { 
				"Content-type" : "application/json", 
				"X-HTTP-Method-Override" : "POST" 
			}, 
			dataType : "text", 
			data : JSON.stringify({ 
				article_no : article_no, 
				reply_text : reply_textVal, 
				reply_writer : reply_writerrVal 
			}), 
			success : function (result) { 
				// 성공적인 댓글 등록 처리 알림 
				if (result == "regSuccess") { 
					alert("댓글 등록 완료!");
				 } 
				getRepliesPaging(replyPageNum); // 댓글 목록 출력 함수 호출 
				reply_text.val(""); // 댓글 내용 초기화 
				reply_writer.val(""); // 댓글 작성자 초기화 
				} 
			}); 
		});
	
	$("#replies").on("click", ".replyLi button", function(){
		var reply = $(this).parent();
		
		var reply_no = reply.attr("data-reply_no");
		var reply_text = reply.find(".reply_text").text();
		var reply_writer = reply.find(".reply_writer").text();
		
		$("#reply_no").val(reply_no);
		$("#reply_text").val(reply_text);
		$("#reply_writer").val(reply_writer);
	});
	
	
	$(".modalDelBtn").on("click", function(){
		//댓글번호
		var reply_no = $(this).parent().parent().find("#reply_no").val();
		
		//AJAX통신 : DELETE
		$.ajax({
			type : "delete",
			url : "${path}/replies/"+reply_no,
			headers :{
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "DELETE"
			},
			dateType : "text",
			success : function(result){
				console.log("result : "+result);
				if(result == "delSuccess"){
					alert("댓글 삭제 완료!");
					$("#modifyModal").modal("hide"); //모달 닫기
					getRepliesPaging(replyPageNum);	//댓글 목록 갱신
				}
			}
		});
	});
	
	$(".modalModBtn").on("click", function(){
		//댓글선택자
		var reply = $(this).parent().parent();
		//댓글번호
		var reply_no = reply.find("#reply_no").val();
		//수정한 댓글 내용
		var reply_text = reply.find("#reply_text").val();
		
		//AJAX통신 : PUT
		$.ajax({
			type : "put",
			url : "${path}/replies/"+reply_no,
			headers :{
				"Content-type" : "application/json",
				"X-HTTP-Method-Override" : "PUT"
			},
			data : JSON.stringify(
					{reply_text : reply_text}
			),
			dateType : "text",
			success : function(result){
				console.log("result : "+result);
				if(result == "modSuccess"){
					alert("댓글 수정 완료!");
					$("#modifyModal").modal("hide"); //모달 닫기
					getRepliesPaging(replyPageNum);	//댓글 목록 갱신
				}
			}
		});
	});
	
	function getRepliesPaging(page){
		
		$.getJSON("${path}/replies/"+article_no+"/"+page, function(data){
			console.log(data);
			
			var str="";
			
			$(data.replies).each(function(){
				str += "<li data-reply_no='" + this.reply_no + "' class='replyLi'>" 
				+ "<p class='reply_text'>" + this.reply_text + "</p>" 
				+ "<p class='reply_writer'>" + this.reply_writer + "</p>" 
				+ "<button type='button' class='btn btn-xs btn-success' data-toggle='modal' data-target='#modifyModal'>댓글 수정</button>" 
				+ "</li>" 
				+ "<hr/>";
			});
			
			$("#replies").html(str);
			
			//페이지 번호 출력 호출
			printPageNumbers(data.pageMaker);
		});
	}
	
	function printPageNumbers(pageMaker){
		var str="";
		
		// 이전 버튼 활성화 
		if (pageMaker.prev) { 
			str += "<li class=\"page-item\"><a class=\"page-link\" href='"+(pageMaker.startPage-1)+"'>이전</a></li>"; 
		} 

		// 페이지 번호 
		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) { 
			var strCalss = pageMaker.criteria.page == i ? 'class=active' : ''; 
			str += "<li class=\"page-item\" "+strCalss+"><a class=\"page-link\" href='"+i+"'>"+i+"</a></li>"; 
		} 

		// 다음 버튼 활성화 
		if (pageMaker.next) { 
			str += "<li class=\"page-item\"><a class=\"page-link\" href='"+(pageMaker.endPage + 1)+"'>다음</a></li>"; 
		}
		$(".pagination-sm").html(str);
	}
	
	//목록페이지 번호 클릭 이벤트
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		replyPageNum = $(this).attr("href"); //목록 페이지 번호 추출
		getRepliesPaging(replyPageNum);
	});
});

</script>
</body>
</html>
