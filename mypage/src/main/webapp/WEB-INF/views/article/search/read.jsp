<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="../../include/head.jsp" %>

<body class="hold-transition sidebar-mini">
<script type="text/javascript" src="${path}/resources/dist/js/upload.js"></script>
<div class="wrapper">

  <!-- Navbar -->
  <%@ include file="../../include/main_header.jsp" %>
  <!-- /.navbar -->

  <!-- Main Sidebar Container -->
 <%@ include file="../../include/left_column.jsp" %>


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
    <div class="content">
      <div class="container-fluid">
        <div class="col-lg-12"> 
			<div class="card"> 
				<div class="card-header"> 
					<h3 class="card-title">글제목 : ${article.title}</h3> 
				</div> 
				<div class="card-body" style="height: 700px"> 
					${article.content} 
				</div> 
				<div class="card-footer"> 
					<div class="user-block"> 
						<img class="img-circle img-bordered-sm" src="${path}/dist/img/user1-128x128.jpg" alt="user image"> 
						<span class="username"> 
							<a href="#">${article.writer}</a> 
						</span> 
						<span class="description"><fmt:formatDate pattern="yyyy-MM-dd" value="${article.regDate}"/></span> 
					</div> 
					<%--이미지--%> 
						<script id="templatePhotoAttach" type="text/x-handlebars-template"> 
							<li> 
								<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span> 
								<div class="mailbox-attachment-info"> 
									<a href="{{getLink}}" class="mailbox-attachment-name" data-lightbox="uploadImages"><i class="fas fa-camera"></i> {{fileName}}</a> 
								</div> 
							</li> 
						</script> 
						<%--일반 파일--%> 
						<script id="templateFileAttach" type="text/x-handlebars-template"> 
							<li> 
								<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span> 
								<div class="mailbox-attachment-info"> 
									 <a href="{{getLink}}" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> {{fileName}}</a>
								</div> 
							</li> 
						</script>
					</div> 
					<div class="box-footer"> 
						<ul class="mailbox-attachments clearfix uploadedList"></ul> 
					</div>
				</div> 
				<div class="card-footer"> 
					<form role="form" method="post"> 
						<input type="hidden" name="article_no" value="${article.article_no}"> 
						<input type="hidden" name="page" value="${searchCriteria.page}"> 
						<input type="hidden" name="perPageNum" value="${searchCriteria.perPageNum}"> 
						<input type="hidden" name="searchType" value="${searchCriteria.searchType}">
						<input type="hidden" name="keyword" value="${searchCriteria.keyword}">  
					</form> 
					<button type="submit" class="btn btn-primary listBtn"><i class="fa fa-list"></i> 목록</button> 
					<c:if test="${login.userId == article.writer}"> 
						<div class="float-right"> 
							<button type="submit" class="btn btn-warning modBtn"><i class="fa fa-edit"></i> 수정</button> 
							<button type="submit" class="btn btn-danger delBtn"><i class="fa fa-trash"></i> 삭제</button> 
						</div> 
					</c:if>
				</div>
				
				<div class="card"> 
					<div class="card-body"> 
						<c:if test="${not empty login}"> 
							<form class="form-horizontal"> 
								<div class="row"> 
									<div class="form-group col-sm-8"> 
										<input class="form-control input-sm" id="newReplyText" type="text" placeholder="댓글 입력..."> 
									</div> 
									<div class="form-group col-sm-2" hidden> 
										<input class="form-control input-sm" id="newReplyWriter" type="text" value="${login.userId}" readonly> 
									</div> 
									<div class="form-group col-sm-2"> 
										<button type="button" class="btn btn-primary btn-sm btn-block replyAddBtn"> <i class="fa fa-save"></i> 저장 </button> 
									</div> 
								</div> 
							</form> 
						</c:if> 
						<c:if test="${empty login}"> 
							<a href="${path}/user/login" class="btn btn-default btn-block" role="button"> <i class="fa fa-edit">
								</i> 로그인 한 사용자만 댓글 등록이 가능합니다. </a> 
						</c:if> 
						
					
				</div>
				
			<div class="card card-primary card-outline"> 
				<%--댓글 유무 / 댓글 갯수 / 댓글 펼치기, 접기--%> 
				<div class="card-header"> 
				<a href="" class="link-black text-lg"><i class="fas fa-comments margin-r-5 replyCount"></i></a> 
					<div class="card-tools"> 
						<button type="button" class="btn primary" data-widget="collapse"> 
							<i class="fa fa-plus"></i> 
						</button> 
					</div> 
			</div> 
			<%--댓글 목록--%> 
			<div class="card-body repliesDiv" id="repliesDiv"> 
				<script id="replyTemplate" type="text/x-handlebars-template"> 
					{{#each.}} 
						<div class="post replyDiv">
							<div class="data-reply_no">{{reply_no}}</div> 
							<div class="user-block"> 
								<img class="img-circle img-bordered-sm" src="${path}/dist/img/user1-128x128.jpg" alt="user image"> 
								<span class="username"> 
									<a href="#" class="oldwriter">{{reply_writer}}</a> {{#eqReplyWriter reply_writer}} 
									<a href="#" class="float-right btn-box-tool replyDelBtn" data-toggle="modal" data-target="#deleteModal"> 
										<i class="fa fa-times"> 삭제</i> 
									</a> 
									<a href="#" class="float-right btn-box-tool replyModBtn" data-toggle="modal" data-target="#modifyModal"> 
										<i class="fa fa-edit"> 수정</i> 
									</a> 
											{{/eqReplyWriter}}
								</span> 
								<span class="description"></span> 
							</div> 
							<div class="oldReplyText">{{reply_text}}</div> 
							<br/> 
						</div> 
					{{/each}} 
				</script>
			</div> 
			<%--댓글 페이징--%> 
			<div class="card-footer"> 
				<nav aria-label="Contacts Page Navigation"> 
					<ul class="pagination pagination-sm no-margin justify-content-center m-0"> 
			
					</ul> 
				</nav> 
			</div> 
			</div>
				</div> 
			</div>
        
      </div><!-- /.container-fluid -->

		<!-- ModiModal -->
      	<div class="modal fade" id="modifyModal" role="dialog"> 
			<div class="modal-dialog"> 
			<!-- Modal content -->
				<div class="modal-content"> 
					<div class="modal-header"> 
						<button type="button" class="close" data-dismiss="modal">&times;
						</button> 
					<h4 class="modal-title">댓글 수정창</h4> 
				</div> 
				<div class="modal-body"> 
			<div class="form-group"> 
			<label for="modal_modi_reply_no">댓글 번호</label> 
				<input class="form-control" id="modal_modi_reply_no" name="reply_no" readonly> 
					</div> 
					<div class="form-group"> 
						<label for="modal_modi_reply_text">댓글 내용</label> 
						<input class="form-control" id="modal_modi_reply_text" name="reply_text" placeholder="댓글 내용을 입력해주세요"> 
					</div> 
					<div class="form-group"> 
						<label for="modal_modi_reply_writer">댓글 작성자</label> 
						<input class="form-control" id="modal_modi_reply_writer" name="reply_writer" readonly> 
					</div> 
					</div> 
					<div class="modal-footer"> 
						<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button> 
						<button type="button" class="btn btn-success modalModBtn">수정</button> 
					</div> 
				</div> 
			</div> 
		</div>
		
		<!-- DelModal -->
		<div class="modal fade" id="deleteModal" role="dialog"> 
			<div class="modal-dialog"> 
			<!-- Modal content -->
				<div class="modal-content"> 
					<div class="modal-header"> 
						<button type="button" class="close" data-dismiss="modal">&times;
						</button> 
					<h4 class="modal-title">댓글 삭제창</h4> 
				</div> 
				<div class="modal-body"> 
			<div class="form-group"> 
			<label for="modal_del_reply_no">댓글 번호</label> 
				<input class="form-control" id="modal_del_reply_no" name="reply_no" readonly> 
					</div> 
					<div class="form-group"> 
						<label for="modal_del_reply_text">댓글 내용</label> 
						<input class="form-control" id="modal_del_reply_text" name="reply_text" readonly> 
					</div> 
					<div class="form-group"> 
						<label for="modal_del_reply_writer">댓글 작성자</label> 
						<input class="form-control" id="modal_del_reply_writer" name="reply_writer" readonly> 
					</div> 
					</div> 
					<div class="modal-footer"> 
						<button type="button" class="btn btn-default pull-left" data-dismiss="modal">닫기</button> 
						<button type="button" class="btn btn-danger modalDelBtn">삭제</button> 
					</div> 
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
  <%@ include file="../../include/main_footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<%@ include file="../../include/plugin_js.jsp" %>


<script>
$(document).ready(function () {
	 var formObj = $("form[role='form']"); 
	 var templatePhotoAttach = Handlebars.compile($("#templatePhotoAttach").html());
	 var templateFileAttach = Handlebars.compile($("#templateFileAttach").html());
	console.log(formObj); 

	$(".modBtn").on("click", function () {
		formObj.attr("action", "${path}/article/paging/search/modify"); 
		formObj.attr("method", "get"); 
		formObj.submit();
	 }); 

	$(".delBtn").on("click", function () { 
		formObj.attr("action", "mypage/file/delete/all"); 
		formObj.attr("action", "${path}/article/paging/search/remove"); 
		formObj.submit(); 
	}); 

	$(".listBtn").on("click", function () { 
		formObj.attr("method", "get"); 
		formObj.attr("action", "${path}/article/paging/search/list"); 
		formObj.submit();
	}); 
	
	var article_no = "${article.article_no}";  //현재 게시글 번호
	var replyPageNum = 1;
	
	$.getJSON("/mypage/file/list/" + article_no, function (list) { 
		$(list).each(function () { 
			var fileInfo = getFileInfo(this); 
			if (fileInfo.fullName.substr(12, 2) == "s_") { 
				var html = templatePhotoAttach(fileInfo); 
			}else { 
				html = templateFileAttach(fileInfo); 
			} 
			$(".uploadedList").append(html); 
		}) 
	});
	
	Handlebars.registerHelper("eqReplyWriter", function (reply_writer, block) { 
		var accum = ""; 
		if (reply_writer === "${login.userId}") { 
			accum += block.fn(); 
			} 
		return accum; 
	});


	
	//댓글 내용 : 줄바꿈/공백처리
	Handlebars.registerHelper("escape", function(reply_text){
		var text = Handlebars.Utils.escapeExpression(reply_text);
		text = text.replace(/(\r\n|\n|\r)/gm, "<br/>"); 
		text = text.replace(/( )/gm, "&nbsp;");
		return new Handlebars.SafeString(text);
	});
	
	//댓글 등록일자 : 날짜/시간 2자리로 맞추기
	Handlebars.registerHelper("prettifyDate", function(timeValue){
		var dateObj = new Date(timeValue); 
		var year = dateObj.getFullYear(); 
		var month = dateObj.getMonth() + 1; 
		var date = dateObj.getDate(); 
		var hours = dateObj.getHours(); 
		var minutes = dateObj.getMinutes();
		 // 2자리 숫자로 변환 
		month < 10 ? month = '0' + month : month; 
		date < 10 ? date = '0' + date : date; 
		hours < 10 ? hours = '0' + hours : hours; 
		minutes < 10 ? minutes = '0' + minutes : minutes; 

		return year + "-" + month + "-" + date ;
		
	});
	
	getReplies("${path}/replies/"+article_no+"/"+replyPageNum);
	
	//댓글 목록 함수
	function getReplies(repliesUri) { 
		$.getJSON(repliesUri, function (data) { 
			printReplyCount(data.pageMaker.totalCount); 
			printReplies(data.replies, $(".repliesDiv"), $("#replyTemplate")); 
			printReplyPaging(data.pageMaker, $(".pagination")); 
		}); 
	}
	
	// 댓글 갯수 출력 함수 
	function printReplyCount(totalCount) { 
		var replyCount = $(".replyCount"); 
		var collapsedBox = $(".collapsed-box"); 
	
		// 댓글이 없으면 
		if (totalCount == 0) { 
			replyCount.html(" 댓글이 없습니다. 의견을 남겨주세요"); 
			collapsedBox.find(".btn-box-tool").remove(); 
			return; 
		} 
	
		// 댓글이 존재하면 
		replyCount.html(" 댓글목록 (" + totalCount + ")"); 
		collapsedBox.find(".box-tools").html( 
				"<button type='button' class='btn btn-box-tool' data-widget='collapse'>" 
				+ "<i class='fa fa-plus'></i>" 
				+ "</button>"
		 ); 
	}
	
	// 댓글 목록 출력 함수 
	function printReplies(replyArr, targetArea, templateObj) { 
		var replyTemplate = Handlebars.compile(templateObj.html()); 
		var html = replyTemplate(replyArr); 
		$(".replyDiv").remove(); 
		targetArea.html(html); 
	}
	
	// 댓글 페이징 출력 함수 
	function printReplyPaging(pageMaker, targetArea) { 
		var str = ""; 
	
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
		 targetArea.html(str); 
	}
	
	// 댓글 페이지 번호 클릭 이벤트 
	$(".pagination").on("click", "li a", function (event) { 
		event.preventDefault(); 
		replyPageNum = $(this).attr("href"); 
		getReplies("${path}/replies/" + article_no + "/" + replyPageNum); 
	});
	
	// 댓글 저장 버튼 클릭 이벤트 
	$(".replyAddBtn").on("click", function () { 

	// 입력 form 선택자 
	var reply_writerObj = $("#newReplyWriter"); 
	var reply_textObj = $("#newReplyText"); 
	var reply_writer = reply_writerObj.val(); 
	var reply_text = reply_textObj.val(); 

	// 댓글 입력처리 수행 
	$.ajax({ 
		type : "post", 
		url : "${path}/replies/", 
		headers : {
				 "Content-Type" : "application/json", 
				"X-HTTP-Method-Override" : "POST" 
		}, 
		dataType : "text", 
		data : JSON.stringify({ 
				article_no : article_no, 
				reply_writer : reply_writer, 
				reply_text : reply_text 
		}), 
	success: function (result) { 
		console.log("result : " + result); 
		if (result === "regSuccess") { 
			alert("댓글이 등록되었습니다."); 
			replyPageNum = 1; // 페이지 1로 초기화 
			getReplies("${path}/replies/" + article_no + "/" + replyPageNum); // 댓글 목록 호출 
			reply_textObj.val(""); // 댓글 입력창 공백처리 
			reply_writerObj.val(""); // 댓글 입력창 공백처리 
			} 
		} 
		});
	});
	// 댓글 수정을 위해 modal창에 선택한 댓글의 값들을 세팅 
	$(".repliesDiv").on("click", ".replyDiv", function (event) { 
		var reply = $(this); 
		$("#modal_modi_reply_no").val(reply.find(".data-reply_no").text()); 
		$("#modal_modi_reply_text").val(reply.find(".oldReplyText").text());
		$("#modal_modi_reply_writer").val(reply.find(".oldwriter").text());
		
		$("#modal_del_reply_no").val(reply.find(".data-reply_no").text()); 
		$("#modal_del_reply_text").val(reply.find(".oldReplyText").text());
		$("#modal_del_reply_writer").val(reply.find(".oldwriter").text());
	});
	
	// modal 창의 댓글 수정버튼 클릭 이벤트 
	$(".modalModBtn").on("click", function () { 
		var reply_no = $("#modal_modi_reply_no").val(); 
		var reply_text = $("#modal_modi_reply_text").val();
		console.log(reply_no);
		console.log(reply_text);
		
			$.ajax({ 
				type : "put", 
				url : "${path}/replies/" + reply_no, 
				headers : { 
						"Content-Type" : "application/json", 
						"X-HTTP-Method-Override" : "PUT" 
				},
				dataType : "text", 
				data: JSON.stringify({ 
					reply_text : reply_text 
				}),
			success: function (result) { 
				console.log("result : " + result); 
				if (result === "modSuccess") { 
					alert("댓글이 수정되었습니다."); 
					getReplies("${path}/replies/" + article_no + "/" + replyPageNum); // 댓글 목록 호출 
					$("#modifyModal").modal("hide"); // modal 창 닫기 
				} 
			} 
		}) 
	});
	
	// modal 창의 댓글 삭제버튼 클릭 이벤트 
	$(".modalDelBtn").on("click", function () { 
		var reply_no = $("#modal_del_reply_no").val(); 
		$.ajax({ 
			type: "delete",
			url: "${path}/replies/" + reply_no, 
			headers: { 
				"Content-Type" : "application/json", 
				"X-HTTP-Method-Override" : "DELETE" 
			}, 
			dataType: "text", 
			success: function (result) { 
				console.log("result : " + result); 
				if (result === "delSuccess") { 
					alert("댓글이 삭제되었습니다."); 
					getReplies("${path}/replies/" + article_no + "/" + replyPageNum); // 댓글 목록 호출 
					$("#deleteModal").modal("hide"); // modal 창 닫기 
					} 
				} 
			}); 
		}); 
	});
</script>
</body>
</html>
