<template>
  <header class="container-fluid bg-light">
    <b-container class="bg-light">
      <b-navbar toggleable="lg" variant="light">
        <b-navbar-brand tag="h1" style="margin-bottom: 0"
          ><router-link class="brand" to="/"
            ><b-icon-house-door-fill /> HappyHouse</router-link
          ></b-navbar-brand
        >

        <b-navbar-toggle target="nav-collapse"></b-navbar-toggle>

        <b-collapse id="nav-collapse" is-nav>
          <b-navbar-nav>
            <b-nav-item-dropdown text="아파트">
              <b-dropdown-item
                ><router-link to="/apt" class="drop">매매/전월세</router-link></b-dropdown-item
              >
            </b-nav-item-dropdown>
            <b-nav-item-dropdown text="관심지역">
              <b-dropdown-item
                ><router-link to="/addInterest" class="drop"
                  >관심지역 등록</router-link
                ></b-dropdown-item
              >
              <b-dropdown-item
                ><router-link to="/showInterest" class="drop"
                  >관심지역 보기</router-link
                ></b-dropdown-item
              >
            </b-nav-item-dropdown>
            <b-nav-item
              ><router-link class="routerlink secondary" to="/list">Q&A</router-link></b-nav-item
            >
          </b-navbar-nav>

          <!-- Right aligned nav items -->
          <b-navbar-nav class="ml-auto">
            <b-nav-item @click="showModal = true" v-if="loginName === ''">로그인</b-nav-item>
            <b-nav-item @click="showJoinModal = true" v-if="loginName === ''">회원가입</b-nav-item>
            <b-nav-item><router-link to="/notice">공지사항</router-link></b-nav-item>
            <b-nav-item-dropdown right v-if="loginName !== ''">
              <!-- Using 'button-content' slot -->
              <template #button-content>
                <b-avatar variant="dark" size="sm"></b-avatar> {{ loginName }} 님</template
              >
              <b-dropdown-item
                ><router-link to="/profile" class="drop">프로필</router-link></b-dropdown-item
              >
              <b-dropdown-item @click="callLogout" class="drop">로그아웃</b-dropdown-item>
            </b-nav-item-dropdown>
          </b-navbar-nav>
        </b-collapse>
      </b-navbar>

      <!-- Modal -->
      <login-modal v-if="showModal" @close="showModal = false"></login-modal>
      <join-modal v-if="showJoinModal" @close="showJoinModal = false"></join-modal>
    </b-container>
  </header>
</template>

<script>
import loginModal from "../components/user/loginModal.vue";
import joinModal from "../components/user/joinModal.vue";
import { createNamespacedHelpers } from "vuex";
const userHelper = createNamespacedHelpers("userStore");

export default {
  components: { loginModal, joinModal },
  name: "AppHeader",
  data() {
    return {
      showModal: false,
      showJoinModal: false,
    };
  },
  methods: {
    ...userHelper.mapActions(["logout", "join"]),
    callLogout() {
      this.logout().then(() => this.$router.push("/"));
    },
  },
  computed: {
    ...userHelper.mapState({
      loginName: (state) => state.loginUser.name,
    }),
  },
};
</script>

<style scoped>
a {
  color: rgba(0, 0, 0, 0.55);
  text-decoration: none;
}

a:focus,
:hover {
  color: rgba(0, 0, 0, 0.7);
  text-decoration: none;
}

a:active {
  color: rgba(0, 0, 0, 0.9);
  text-decoration: none;
}

.brand,
.drop {
  color: black;
}

.brand:focus {
  color: black;
}
</style>
