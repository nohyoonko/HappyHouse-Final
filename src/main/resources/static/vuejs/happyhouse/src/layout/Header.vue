<template>
  <header fluid>
    <b-navbar toggleable="lg" variant="light">
      <b-navbar-brand tag="h1"><router-link class="brand" to="/"><b-icon-house-door-fill /> HappyHouse</router-link></b-navbar-brand>

      <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

      <b-collapse id="nav-collapse" is-nav>
        <b-navbar-nav>
      <b-nav-item-dropdown text="아파트">
            <b-dropdown-item><router-link to="/apt" class="drop">매매/전월세</router-link></b-dropdown-item>
          </b-nav-item-dropdown>
      <b-nav-item-dropdown text="관심지역">
            <b-dropdown-item><router-link to="/interest" class="drop">관심지역 등록</router-link></b-dropdown-item>
        <b-dropdown-item><router-link to="/interest"  class="drop">관심지역 보기</router-link></b-dropdown-item>
          </b-nav-item-dropdown>
      <b-nav-item><router-link class="routerlink secondary" to="/list">Q&A</router-link></b-nav-item>
        </b-navbar-nav>

        <!-- Right aligned nav items -->
        <b-navbar-nav class="ml-auto">
          <b-nav-item><router-link to="/login">로그인</router-link></b-nav-item>
          <b-nav-item><router-link to="/join">회원가입</router-link></b-nav-item>
      <b-nav-item><router-link to="/notice">공지사항</router-link></b-nav-item>
          
      <b-nav-item-dropdown right>
            <!-- Using 'button-content' slot -->
            <template #button-content>사용자</template>
        <b-dropdown-item><router-link to="/profile" class="drop">프로필</router-link></b-dropdown-item>
        <b-dropdown-item><router-link to="/logout" class="drop">로그아웃</router-link></b-dropdown-item>
            </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </header>
</template>

<script>
export default {
  name: 'AppHeader',
};
</script>

<style scoped>
a {
	color: #6c757d;
	text-decoration: none;
}

a:hover {
	color: #343a40;
}

.brand, .drop {
	color: black;
}

.container-fluid {
	padding: 0px;
}
</style>