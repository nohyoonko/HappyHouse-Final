<template>
  <div id="app" height="100%">
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
</style>
