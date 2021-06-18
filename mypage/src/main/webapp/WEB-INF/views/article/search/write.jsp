<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<%@ include file="../../include/head.jsp" %>
<head>
<script type="text/javascript" src="${path}/resources/dist/js/upload.js"></script>
</head>
<body class="hold-transition sidebar-mini">
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
        		<form role="form" id="writeForm" method="post" action="${path}/article/write"> 
	        		<div class="card"> 
	        			<div class="card-header with-border"> 
	        				<h3 class="card-title">게시글 작성</h3> 
		        		</div> 
		        		<div class="card-body"> 
		        			<div class="form-group"> 
		        				<label for="title">제목</label> 
		        				<input class="form-control" id="title" name="title" placeholder="제목을 입력해주세요"> 
		        			</div> 
			        		<div class="form-group"> 
			        			<label for="content">내용</label> 
			        			<textarea class="form-control" id="content" name="content" rows="30" placeholder="내용을 입력해주세요" style="resize: none;"></textarea> 
			        		</div> 
			        		<div class="form-group"> 
			        			<label for="writer">작성자</label> 
			        			<input class="form-control" id="writer" name="writer" value="${login.userId}" readonly>
			        		</div> 
			        		<%--첨부파일 영역 추가--%> 
							<div class="form-group"> 
								<div class="fileDrop"> 
									<br/> 
									<br/> 
									<br/> 
									<br/> 
									<p class="text-center"><i class="fa fa-paperclip"></i> 첨부파일을 드래그해주세요.</p> 
								</div> 
							</div> 
							<%--첨부파일 영역 추가--%>
							<div class="card-footer"> 
								<ul class="mailbox-attachments clearfix uploadedList"></ul> 
							</div>
			     		<%--첨부파일 하나의 영역--%> 
						<%--이미지--%> 
						<script id="templatePhotoAttach" type="text/x-handlebars-template"> 
							<li> 
								<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span> 
								<div class="mailbox-attachment-info"> 
									<a href="{{getLink}}" class="mailbox-attachment-name" data-lightbox="uploadImages"><i class="fas fa-camera"></i> {{fileName}}</a> 
									<a href="{{fullName}}" class="btn btn-default btn-xs float-right filedelBtn"><i class="far fa-trash-alt"></i></a> 
								</div> 
							</li> 
						</script> 
						<%--일반 파일--%> 
						<script id="templateFileAttach" type="text/x-handlebars-template"> 
							<li> 
								<span class="mailbox-attachment-icon has-img"><img src="{{imgsrc}}" alt="Attachment"></span> 
								<div class="mailbox-attachment-info"> 
									<a href="{{getLink}}" class="mailbox-attachment-name"><i class="fas fa-paperclip"></i> {{fileName}}</a> 
									<a href="{{fullName}}" class="btn btn-default btn-xs float-right filedelBtn"><i class="far fa-trash-alt"></i></a> 
								</div> 
							</li> 
						</script>
		        		</div> 
		        		<div class="card-footer"> 
		        			<button type="button" class="btn btn-primary" id="listBtn"><i class="fa fa-list"></i> 목록</button> 
		        			<div class="float-right"> 
		        				<button type="reset" class="btn btn-warning"><i class="fa fa-reply"></i> 초기화</button> 
		        				<button type="submit" class="btn btn-success" id="saveBtn"><i class="fa fa-save"></i> 저장</button> 
		        			</div> 
		        		</div> 
	        		</div> 
        		</form> 
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
  <%@ include file="../../include/main_footer.jsp" %>
  
</div>
<!-- ./wrapper -->

<!-- REQUIRED SCRIPTS -->
<%@ include file="../../include/plugin_js.jsp" %>


<script> 
	$(document).ready(function () { 
		var fileDropDiv = $(".fileDrop"); 
		var templatePhotoAttach = Handlebars.compile($("#templatePhotoAttach").html()); 
		var templateFileAttach = Handlebars.compile($("#templateFileAttach").html()); 

		 $(".content-wrapper").on("dragenter dragover drop", function (event) { 
			event.preventDefault(); 
		});
	
		fileDropDiv.on("dragenter dragover", function (event) { 
			event.preventDefault(); 
		}); 
	
		fileDropDiv.on("drop", function (event) { 
			event.preventDefault(); 
			var files = event.originalEvent.dataTransfer.files; 
			var file = files[0]; 
			var formData = new FormData(); 
			formData.append("file", file); 
			$.ajax({ 
				url: "/mypage/file/upload", 
				data: formData, 
				dataType: "text", 
				processData: false, 
				contentType: false, 
				type: "POST", 
				success: function (data) { 
					 var fileInfo = getFileInfo(data); 
					 if (data.substr(12, 2) == "s_") { 
					console.log("This is Image"); 
					var html = templatePhotoAttach(fileInfo); 
				} else { 
					html = templateFileAttach(fileInfo); 
				} 
				$(".uploadedList").append(html);
	 		} 
		}); 
	}); 
	
		$("#listBtn").on("click", function(){
			self.location="${path}}/article/paging/search/list";
		});

	$("#writeForm").submit(function (event) { 
		event.preventDefault(); 
		var that = $(this); 
		var str = ""; 
		$(".uploadedList .delBtn").each(function (index) { 
			str += "<input type='hidden' name='files["+index+"]' value='"+$(this).attr("href")+"'>" 
		}); 
		that.append(str); 
		that.get(0).submit(); 
	}); 
	
	$(document).on("click", ".filedelBtn", function (event) { 
		event.preventDefault(); 
		var that = $(this); 
		$.ajax({ 
			url: "/mypage/file/delete", 
			type: "post", 
			data: {fileName:$(this).attr("href")}, 
			dataType: "text", 
			success: function (result) { 
				if (result == "DELETED") { 
					alert("삭제되었습니다.");
	 				that.parents("li").remove();
				 }
	 			}
	 		});
	 }); 
}); 
</script>

</body>
</html>
