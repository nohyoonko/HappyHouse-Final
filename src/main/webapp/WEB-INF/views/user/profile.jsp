<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp" %>
<script type="text/javascript">
	$(document).ready(function() {
		$("#modifyBt").click(function() {
			if ($("#re_pwd").val() == "") {
				alert("비밀번호 입력!!!");
				return;
			} else if ($("#re_pwdCon").val() == "") {
				alert("비밀번호 확인!!!");
				return;
			} else if ($("#re_name").val() == "") {
				alert("이름 입력!!!");
				return;
			} else if ($("#re_tel").val() == "") {
				alert("전화번호 입력!!!");
				return;
			} else if ($("#re_adress").val() == "") {
				alert("주소 입력!!!");
				return;
			} else if ($("#re_email").val() == "") {
				alert("이메일 입력!!!");
				return;
			} else {
				$("#modifyform").attr("action", "${root}/member/modify").submit();
			}
		});
		
		$("#delBtn").click(function() {
			$("#delForm").attr("action", "${root}/member/delete/${userinfo.userid}").submit();
		});
	});
</script>
</head>
<body>
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<section>
		<div class="container mt-3">
			<div class="jumbotron">
				<div class="row">
					<div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
						<img
							src="https://www.svgimages.com/svg-image/s5/man-passportsize-silhouette-icon-256x256.png"
							alt="stack photo" class="img" />
					</div>
					<div class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
						<div class="container" style="border-bottom: 1px solid black">
							<h2>${userinfo.username}</h2>
						</div>
						<hr />
						<ul class="container details">
							<li>
								<p>
									<span class="glyphicon glyphicon-earphone one"
										style="width: 50px"></span>${userinfo.phone}
								</p>
							</li>
							<li>
								<p>
									<span class="glyphicon glyphicon-envelope one"
										style="width: 50px"></span>${userinfo.email}
								</p>
							</li>
							<li>
								<p>
									<span class="glyphicon glyphicon-envelope one"
										style="width: 50px"></span>${userinfo.address}
								</p>
							</li>
						</ul>
					</div>
					<div class="d-flex col-11 m-3 justify-content-end">
						<button type="button" class="btn btn-info" data-toggle="modal"
							data-target="#reModal">수정</button>
						<div class="p-2"></div>
						<button type="button" class="btn btn-danger" data-toggle="modal"
							data-target="#delModal">탈퇴</button>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!--메인 영역 끝-->

	<!--푸터 영역 시작-->
	<%@ include file="/WEB-INF/views/template/bottom.jsp"%>
	<!--푸터 영역 끝-->

	<!--회원가입 모달 -->
	<%@ include file="/WEB-INF/views/modal/joinModal.jsp"%>
	<!-- 로그인 모달 -->
	<%@ include file="/WEB-INF/views/modal/loginModal.jsp"%>

	<!-- 수정 모달 -->
	<div class="modal fade" id="reModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<!-- Modal Header -->
				<div class="modal-header">
					<h4 class="modal-title">정보 수정</h4>
				</div>
				<!-- Modal body -->
				<div class="modal-body">
					<form id="modifyform" class="was-validated" method="post" action="">
						<div class="form-group">
							<label>User ID (* 20자 이내)</label> <input type="text"
								class="form-control under20" id="re_usr" name="userid" value="${userinfo.userid}"
								readonly />
						</div>
						<div class="form-group">
							<label>User Password (* 20자 이내)</label> <input type="password"
								class="form-control under20" id="re_pwd" name="userpwd"
								placeholder="Enter Password" value="${userinfo.userpwd}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>

						<div class="form-group">
							<label>User Password Confirm (* 20자 이내)</label> <input
								type="password" class="form-control under20" id="re_pwdCon"
								name="modifyPwdCon" placeholder="Enter Password" value="${userinfo.userpwd}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>

						<div class="form-group">
							<label>User Name (* 10자 이내)</label> <input type="text"
								class="form-control under10" id="re_name" placeholder="Name"
								name="username" value="${userinfo.username}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>

						<div class="form-group">
							<label>User CellPhone (* 20자 이내)</label> <input type="tel"
								class="form-control under20" id="re_tel" name="phone"
								placeholder="010-1234-5678" value="${userinfo.phone}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>
						<div class="form-group">
							<label>User Address (* 50자 이내)</label> <input type="text"
								class="form-control under50" id="re_address" name="address"
								placeholder="OO시 OO동" value="${userinfo.address}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>

						<div class="form-group">
							<label>User E-mail (* 50자 이내)</label> <input type="email"
								class="form-control under50" id="re_email" name="email"
								placeholder="example@example.com" value="${userinfo.email}" required />
							<div class="valid-feedback">Valid.</div>
							<div class="invalid-feedback">Please fill out this field.</div>
						</div>
					</form>
				</div>
				<!-- Modal footer -->
				<div class="modal-footer">
					<button type="button" class="btn btn-success" id="modifyBt">Modify</button>
					<button type="button" class="btn btn-secondary" id="modifyCl"
						data-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 탈퇴 -->
	<div class="modal" id="delModal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">회원 탈퇴</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<p>탈퇴 하시겠습니까?</p>
				</div>
				<div class="modal-footer">
				<form id="delForm" method="post" action="">
					<button type="button" id="delBtn" class="btn btn-primary" data-dismiss="modal">Yes</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">No</button>
				</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>