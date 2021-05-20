<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp"%>
</head>
<body>
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->
	<script type="text/javascript">
		function writeArticle() {
			document.getElementById("write-form").action = "${root}/notice/write";
			document.getElementById("write-form").submit();
		}
		function searchArticle() {
			if (document.getElementById("word").value == "") {
				alert("모든 목록 조회!!");
			}
			document.getElementById("searchform").action = "${root}/notice/list";
			document.getElementById("searchform").submit();
		}

		function del(btobj) {
			location.href = '${root}/notice/delete/' + $('#articleNo').text();
			$('#descModal').modal('hide');
		}

		function modifyArticle() {
			//$("#modify-form").action = "${root}/notice/modify";
			$("#modify_articleno").val($("#articleNo").text());
			console.log($("#modify_articleno").val());
			$("#modify-form").submit();
			$('#descModal').modal('hide');
		}
		
		function getModify() {
			$('#modify_title').val($('#articleSubject').text());
			$('#modify_comment').text($('#articleContent').text());
		}
	</script>
	<!--메인 영역 시작-->
	<section class="main container">
		<div class="mt-3 mb-3">
			<form id="searchform" class="form-inline justify-content-end"
				action="">
				<input type="hidden" name="act" value="list"> <select
					class="form-control mr-1" name="key" id="key">
					<option value="articleno">글번호</option>
					<option value="subject">제목</option>
				</select> <input class="form-control mr-sm-2" type="text" name="word"
					id="word" placeholder="Search" />
				<button class="btn" style="background-color: #ac58dd; color: white"
					type="button" onclick="javascript:searchArticle();">Search</button>
			</form>
		</div>
		<!--테이블 시작-->
		<table class="table table-hover">
			<thead>
				<tr>
					<th>글번호</th>
					<th>제목</th>
					<th>작성자</th>
					<th>조회수</th>
					<th>작성일</th>
					<th>분류</th>
				</tr>
			</thead>
			<!-- 글이 있으면 목록 출력 -->
			<c:if test="${articles != null}">
				<script type="text/javascript">
					function getArticle(trobj) {
						//var n = $(this).data(no); // undefined 나옴...
						var articleNo = $(trobj).data('no');
						var param = '?act=get&articleno=' + articleNo;
						$.get("${pageContext.request.contextPath}/notice/get", 
								{articleno : articleNo}, function(data, status) {
								console.log(data.subject);
								$('#articleNo').text(data.articleno);
								$('#articleSubject').text(data.subject);
								$('#articleUserId').text(data.userid);
								$('#articleCount').text(data.count);
								$('#articleDate').text(data.regtime);
								$('#articleContent').text(data.content);
								if ('${userinfo.userid}' != $('#articleUserId').text()) {
									$('#delbt').hide();
									$('#modifybt').hide();
								}
							}//each
						//function
						, "json");//get
					}
				</script>
				<tbody>
					<!-- 글 개수만큼 반복 -->
					<c:forEach var="article" items="${articles}">
						<tr data-toggle="modal" data-target="#descModal"
							data-no="${article.articleno}"
							onclick="javascript:getArticle(this);" style="cursor: pointer">
							<td>${article.articleno}</td>
							<td>${article.subject}</td>
							<td>${article.userid}</td>
							<td>${article.count}</td>
							<td>${article.regtime}</td>
							<td><span class="badge badge-primary">공지</span></td>
						</tr>
					</c:forEach>
				</tbody>
			</c:if>
		</table>
		<!--테이블 끝-->

		<!-- 로그인한 유저가 admin이 아니면 글 쓰기 못함 -->
		<c:if test="${userinfo.userid eq 'admin'}">
			<div class="dropup mt-5">
				<div class="text-right">
					<!-- <button type="button" class="btn" data-toggle="dropdown"><i class="fas fa-plus-circle w3-text-red"></i></button> -->
					<button type="button" class="btn btn-circle btn-xl"
						data-toggle="dropdown"
						style="border-radius: 35px; width: 50px; height: 50px; font-size: 25px; background-color: #ac58dd">
						<i class="fa fa-plus" style="color: white"></i>
					</button>
					<div class="dropdown-menu">
						<a class="dropdown-item" href="#" data-toggle="modal"
							data-target="#myModal">글쓰기</a>
					</div>
				</div>
			</div>
		</c:if>
	</section>
	<!--메인 영역 끝-->

	<!--푸터 영역 시작-->
	<%@ include file="/WEB-INF/views/template/bottom.jsp"%>
	<!--푸터 영역 끝-->

	<!--회원가입 모달 -->
	<%@ include file="/WEB-INF/views/modal/joinModal.jsp"%>
	<!-- 로그인 모달 -->
	<%@ include file="/WEB-INF/views/modal/loginModal.jsp"%>

	<!--글쓰기 모달 시작-->
	<!-- The Modal -->
	<div class="modal fade" id="myModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">새로운 글 쓰기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>

				<!-- Modal body -->
				<div class="modal-body" id="write-modal">
					<form id="write-form" method="post" action="">
						<div class="form-group">
							<label for="title">제목:</label> <input type="text" id="title"
								class="form-control" id="title" name="subject" /> <label
								for="comment">내용:</label>
							<textarea id="content" class="form-control" rows="5" id="comment"
								name="content"></textarea>
						</div>
						<div class="text-right">
							<button type="button" class="btn btn-primary write-submit"
								onclick="javascript:writeArticle();">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!--글쓰기 모달 끝-->

	<!--글 상세 모달 시작-->
	<!-- The Modal -->
	<div class="modal fade" id="descModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title" id="articleSubject"></h4>
					<div class="text-right">
						<!-- 글 작성자와 로그인한 유저가 같으면, 수정/삭제가 보임 -->
						<button id="modifybt" class="btn m-0" data-toggle="modal"
							data-target="#modifyModal" onclick="javascript:getModify();">
							<i class="fa fa-edit"></i>
						</button>
						<button id="delbt" class="btn m-0" data-toggle="modal"
							data-target="#delModal">
							<i class="fa fa-trash-alt"></i>
						</button>
						<button type="button" class="close" onClick="window.location.reload()" data-dismiss="modal">&times;</button>
					</div>
				</div>

				<!-- Modal body -->
				<div class="modal-body">
					<div>
						<table class="table table-hover">
							<tr>
								<th>글 번호</th>
								<td id="articleNo"></td>
							</tr>
							<tr>
								<th>작성자</th>
								<td id="articleUserId"></td>
							</tr>
							<tr>
								<th>조회수</th>
								<td id="articleCount"></td>
							</tr>
							<tr>
								<th>작성일</th>
								<td id="articleDate"></td>
							</tr>
							<tr>
								<th>분류</th>
								<td><span class="badge badge-primary">공지</span></td>
							</tr>
						</table>
					</div>
					<div class="card desc p-3" id="articleContent"></div>
				</div>
			</div>
		</div>
	</div>
	<!--글 상세 모달 끝-->

	<!-- 수정 모달 시작-->
	<div class="modal fade" id="modifyModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">글 수정하기</h4>
					<button type="button" class="close" data-dismiss="modal">&times;</button>
				</div>
				<!-- Modal body -->
				<div class="modal-body" id="write-modal">
					<form id="modify-form" method="post" action="${root}/notice/modify">
						<input type="hidden" id="modify_articleno" name="articleno" value="">
						<div class="form-group">
							<label for="title">제목:</label> <input type="text"
								class="form-control" id="modify_title" name="subject"
								value="수정할 제목" /> <label for="comment">내용:</label>
							<textarea class="form-control" rows="5" id="modify_comment"
								name="content"></textarea>
						</div>
						<div class="text-right">
							<button type="button" class="btn btn-primary write-submit"
								onclick="javascript:modifyArticle();">Submit</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- 수정 모달 끝-->

	<!-- 삭제 모달 시작 -->
	<div class="modal fade" id="delModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">글 삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>삭제 하시겠습니까?</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal"
						onclick="javascript:del(this);">Yes</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">No</button>
				</div>
			</div>
		</div>
	</div>
	<!-- 삭제 모달 끝-->
</body>
</html>
