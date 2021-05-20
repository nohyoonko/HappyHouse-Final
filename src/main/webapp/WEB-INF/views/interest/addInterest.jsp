<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/template/head.jsp"%>
<script type="text/javascript">
	$(document).ready(
			function() {
				$.get("${pageContext.request.contextPath}/aptrest/sido"
						,function(data, status){
							$.each(data, function(index, vo) {
								$("#sido").append("<option value='"+vo.sido_Code+"'>"+vo.sido_Name+"</option>");
							});//each
						}//function
						, "json"
					);//get
			});//ready
	$(document).ready(
			function() {
				$("#sido").change(function() {
					$.get("${pageContext.request.contextPath}/aptrest/gugun/"+$("#sido").val()
							,function(data, status){
								$("#gugun").empty();
								$("#gugun").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#gugun").append("<option value='"+vo.gugun_Code+"'>"+vo.gugun_Name+"</option>");
								});//each
							}//function
							, "json"
					);//get
				});//change
				$("#gugun").change(function() {
					$.get("${pageContext.request.contextPath}/aptrest/dong/"+$("#gugun").val()
							,function(data, status){
								$("#dong").empty();
								$("#dong").append('<option value="0">선택</option>');
								$.each(data, function(index, vo) {
									$("#dong").append("<option value='"+vo.dong+"'>"+vo.dong+"</option>");
								});//each
							}//function
							, "json"
					);//get
				});//change
				$("#dong").change(function() {

				});//change
			});//ready

	function addInterest() {
		let adress = $('#sido option:checked').text() + " "
				+ $('#gugun option:checked').text() + " "
				+ $('#dong option:checked').text();
		$.get("${pageContext.request.contextPath}/interest/add/"+ adress
		, function(data, status) {
			alert('등록이 완료 되었습니다!');
		});
	}
</script>
</head>
<body>
	<!--헤더 영역 시작 -->
	<%@ include file="/WEB-INF/views/template/top.jsp"%>
	<!--헤더 영역 끝-->

	<!--메인 영역 시작-->
	<h1 class="container d-flex justify-content-center mt-4 mb-4">관심지역
		등록</h1>
	<section
		class="main-content container d-flex justify-content-center mt-3">
		<!--동 검색 시작-->
		<article class="col-sm-6 p-5 text-center"
			style="border-radius: 20px; border: 3px solid WhiteSmoke;">
			<div class="mb-3" id="menu1">
				<select class="form-control" name="city" id="sido">
					<option value="0">도/광역시</option>
				</select>
			</div>
			<div class="mb-3" id="menu2">
				<select class="form-control" name="city" id="gugun">
					<option value="0">시/구</option>
				</select>
			</div>
			<div class="mb-3" id="menu3">
				<select class="form-control" name="city" id="dong">
					<option value="0">읍/면/동</option>
				</select>
			</div>
			<button type="button" class="btn btn-warning" id="interest"
				onclick="javascript:addInterest();">관심지역 등록</button>
		</article>
		<!-- 동 검색 끝-->
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