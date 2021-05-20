<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script type="text/javascript">
function login() {
	if(document.getElementById("userid").value == "") {
		alert("아이디 입력!!!");
		return;
	} else if(document.getElementById("userpwd").value == "") {
		alert("비밀번호 입력!!!");
		return;
	} else {
		document.getElementById("loginform").action = "${root}/member/login";
		document.getElementById("loginform").submit();
	}
}

function mvfindPwd() {
	document.location.href = "${root}/member/findPwd";
}
</script>
<!-- 로그인 모달 -->
<!-- The Modal -->
<div class="modal fade" id="loginModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title">로그인</h4>
			</div>

			<!-- Modal body -->
			<div class="modal-body">
				<form id="loginform" method="post">
					<div class="form-group">
						<label for="usr">ID:</label> <input type="text"
							class="form-control" id="userid" name="userid" placeholder="Enter ID" />
					</div>
					<div class="form-group">
						<label for="pwd">Password:</label> <input type="password"
							class="form-control" id="userpwd" name="userpwd" placeholder="Enter Password" />
					</div>
				</form>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-info"
					onclick="javascript:mvfindPwd();">비밀번호 찾기</button>
				<button type="button" class="btn btn-primary" data-dismiss="modal"
					id="loginBt" onclick="javascript:login();">LogIn</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>