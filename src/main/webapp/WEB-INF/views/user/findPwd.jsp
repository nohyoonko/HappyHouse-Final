<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp" %>
<script type="text/javascript">
	function findPwd() {
		document.getElementById("findform").action = "${root}/member/findPwd";
		document.getElementById("findform").submit();
	}
</script>
</head>
<body class="main-body" style="overflow: scroll">
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<section class="container mt-5 mb-3">
		<div class="card">
			<div class="card-header">
				<h2>비밀번호 찾기</h2>
			</div>
			<form id="findform" class="was-validated" method="post" action="">
			<div class="card-body">
				<div class="form-group">
					<label>이름</label> <input type="text" class="form-control under20"
						id="name" name="username" placeholder="Enter Name" required />
					<div class="valid-feedback">Valid.</div>						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
				<div class="form-group">
					<label>ID</label> <input type="text" class="form-control under20"
						id="userid" name="userid" placeholder="Enter ID" required />
					<div class="valid-feedback">Valid.</div>
					<div class="invalid-feedback">Please fill out this field.</div>
				</div>
				<div class="form-group">
					<label>E-mail</label> <input type="tel"
						class="form-control under20" id="useremail" name="email"
						placeholder="Enter E-mail" required />
					<div class="valid-feedback">Valid.</div>
					<div class="invalid-feedback">Please fill out this field.</div>
				</div>
			</div>
			<div class="card-footer text-right">
				<button class="btn btn-success" type="button"
					onclick="javascript:findPwd();">Find</button>
			</div>
			</form>
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
</body>
</html>