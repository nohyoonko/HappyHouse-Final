<template>
  <div id="app">
    <app-header></app-header>
    <router-view></router-view>
    <app-footer></app-footer>
  </div>
</template>

<script>
import AppHeader from "@/layout/Header.vue";
import AppFooter from "@/layout/Footer.vue";
export default {
  name: "App",
  components: {
    AppHeader,
    AppFooter,
  },
};
</script>

<style>
* {
  font-family: "Jua", sans-serif;
  list-style: none;
  padding: 0;
  margin: 0;
  text-decoration: none;
}

.main-body {
  height: 100%;
  overflow: hidden;
  background-image: url("./assets/back.jpg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
}
</style>
