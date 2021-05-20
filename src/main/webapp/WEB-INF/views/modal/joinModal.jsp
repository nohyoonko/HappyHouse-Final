<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<script>
$(document).ready(function() {
	$("#joinBt").click(function() {
 		if($("#ip_usr").val() == "") {
			alert("아이디 입력!!!");
			return;
		} else if($("#ip_pwd").val() == "") {
			alert("비밀번호 입력!!!");
			return;
		} else if($("#ip_pwdCon").val() != $("#ip_pwd").val()) {
			alert("비밀번호 확인!!!");
			return;
		} else if($("#name").val() == "") {
			alert("이름 입력!!!");
			return;
		} else if($("#tel").val() == "") {
			alert("전화번호 입력!!!");
			return;
		} else if($("#email").val() == "") {
			alert("이메일 입력!!!");
			return;
		} else if($("#address").val() == "") {
			alert("주소 입력!!!");
			return;
		} else {
			$("#joinform").attr("action", "${root}/member/join").submit();
		}
	});
});
</script>
<!-- 회원가입 모달 -->
<!-- The Modal -->
<div class="modal fade" id="joinModal">
	<div class="modal-dialog modal-dialog-centered">
		<div class="modal-content">
			<!-- Modal Header -->
			<div class="modal-header">
				<h4 class="modal-title ">회원가입</h4>
			</div>
			
			<form id="joinform" class="was-validated" method="post">
			<!-- Modal body -->
			<div class="modal-body">
					<div class="form-group">
						<label>User ID (* 20자 이내)</label> <input type="text"
							class="form-control under20" id="ip_usr" name="userid" placeholder="Enter ID"
							required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User Password (* 20자 이내)</label> <input type="password"
							class="form-control under20" id="ip_pwd" name="userpwd"
							placeholder="Enter Password" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User Password Confirm (* 20자 이내)</label> <input
							type="password" class="form-control under20" id="ip_pwdCon" name="userPwdCon"
							placeholder="Enter Password" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User Name (* 10자 이내)</label> <input type="text"
							class="form-control under10" id="name" name="username" placeholder="Name"
							required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User CellPhone (* 20자 이내)</label> <input type="tel"
							class="form-control under20" id="tel" name="phone" placeholder="010-1234-5678"
							required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User E-mail (* 50자 이내)</label> <input type="email"
							class="form-control under50" id="email" name="email"
							placeholder="example@example.com" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
					<div class="form-group">
						<label>User Address (*)</label> <input type="text"
							class="form-control" id="address" name="address" placeholder="시/구/동" required>
						<div class="valid-feedback">Valid.</div>
						<div class="invalid-feedback">Please fill out this field.</div>
					</div>
			</div>

			<!-- Modal footer -->
			<div class="modal-footer">
				<button type="button" class="btn btn-success" id="joinBt">Join</button>
				<button type="button" class="btn btn-secondary" data-dismiss="modal" id="joinCl">Close</button>
			</div>
			
			</form>
		</div>
	</div>
</div>