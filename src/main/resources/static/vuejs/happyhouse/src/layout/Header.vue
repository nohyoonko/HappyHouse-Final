<template>
  <header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container">
			<a class="navbar-brand" to="/">HappyHouse</a>
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarColor03" aria-controls="navbarColor03"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarColor03">
				<ul class="navbar-nav mr-auto">
					<li class="nav-item dropdown"><a
						style="color: black; text-decoration: none"
						class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
						role="button" aria-haspopup="true" aria-expanded="false">아파트</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" to="/apt/apt"
								style="color: black; text-decoration: none">매매/전월세</a>
						</div></li>
					<!-- <c:if test="${userinfo != null}"> -->
					<li class="nav-item dropdown"><a
						style="color: black; text-decoration: none"
						class="nav-link dropdown-toggle" data-toggle="dropdown" href="#"
						role="button" aria-haspopup="true" aria-expanded="false">관심지역</a>
						<div class="dropdown-menu">
							<a class="dropdown-item" to="${root}/interest/mvadd"
								style="color: black; text-decoration: none">관심지역 등록</a>
							<a class="dropdown-item" to="${root}/interest/mvlist"
								style="color: black; text-decoration: none">관심지역 보기</a>
						</div></li>
					<!-- </c:if> -->
          <li class="nav-item" style="color: black; text-decoration: none"><router-link to="/list">Q&A</router-link></li>
				</ul>
				<router-link to="/login">로그인</router-link>
				<!-- <c:if test="${userinfo == null}">
				<button type="button" class="btn" data-toggle="modal"
					data-target="#loginModal">로그인</button>
				<button class="btn" type="button" data-toggle="modal"
					data-target="#joinModal">회원가입</button>
				</c:if> -->
				<button class="btn" type="button">
					<a style="color: black; text-decoration: none" to="/notice/">공지사항</a>
				</button>
				<!-- <c:if test="${userinfo != null}"> -->
				<!-- 이 부분은 로그인이 되었을 때만 보여야 한다! c:if 써서 -->
				<!-- <div class="nav-item dropdown">
					<a style="color: black; text-decoration: none" href="#"
						data-toggle="dropdown"
						class="nav-item nav-link dropdown-toggle user-action"
						aria-expanded="false"><img
						src="https://www.tutorialrepublic.com/examples/images/avatar/3.jpg"
						class="rounded-circle" alt="Avatar" /> ${userinfo.username} <b
						class="caret"></b></a>
					<div class="dropdown-menu">
						<a href="${root}/member/profile" class="dropdown-item"><i
							class="fa fa-user-o"></i>PROFILE</a> <a href="${root}/member/logout"
							class="dropdown-item"><i class="material-icons"></i> LOGOUT</a>
					</div>
				</div>
				</c:if> -->
			</div>
		</div>
	</nav>
  </header>
</template>

<script>
export default {
  name: 'AppHeader',
};
</script>

<style>
</style>
