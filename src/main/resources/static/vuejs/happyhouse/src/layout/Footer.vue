<template>
  <footer id="footer">
    <b-navbar type="dark">
      <b-navbar-nav class="ml-auto">
        <b-nav-item href="#">사이트소개</b-nav-item>
        <b-nav-item href="#">개인정보처리방침</b-nav-item>
        <b-nav-item href="#">이용약관</b-nav-item>
        <b-nav-item href="#">오시는길</b-nav-item>
        <b-nav-item>&copy; SSAFY Corp.</b-nav-item>
      </b-navbar-nav>
    </b-navbar>
  </footer>
</template>

<script>
export default {
  name: "AppFooter",
};
</script>

<style scoped>
.navbar {
  background-color: rgb(65, 43, 28);
}
#footer {
  position: fixed;
  bottom: 0;
  width: 100%;
  z-index: 4;
}
</style>
