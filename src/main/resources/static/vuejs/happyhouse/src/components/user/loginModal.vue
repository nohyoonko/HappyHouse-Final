<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
              <h2 class="modal-title">로그인</h2>
            </slot>
          </div>

          <div class="modal-body">
            <slot name="body">
              	<form id="loginform" method="post">
                  <div class="form-group">
                    <label for="userid">ID:</label>
                    <input type="text" v-model="userid" class="form-control" id="userid" name="userid" placeholder="Enter ID" />
                  </div>
                  <div class="form-group">
                    <label for="userpwd">Password:</label>
                    <input type="password" v-model="userpwd" class="form-control" id="userpwd" name="userpwd" placeholder="Enter Password" />
                  </div>
                </form>
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              	<button type="button" class="btn btn-info">비밀번호 찾기</button>
				        <button type="button" class="btn btn-primary" @click="callLogin">LogIn</button>
				        <button type="button" class="btn btn-secondary" @click="$emit('close')">Close</button>
            </slot>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import http from '@/util/http-common';
import { mapActions } from 'vuex';
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const storage = window.sessionStorage;
const userStore = 'userStore';

export default {
    data() {
        return {
            userid: "",
            userpwd: "",
        }
    },
    methods: {
        ...mapActions(userStore, ['login']),
        // getInfo() {
        //     http.post("/info",
        //     {
        //         userid: "some@email.com",
        //         userpwd: "some password"
        //     },
        //     {
        //         headers: {
        //             "jwt-auth-token": storage.getItem("jwt-auth-token")
        //         }
        //     }).then(res => {
        //         this.setInfo("정보 조회 성공", res.headers.auth_token, JSON.stringify(res.data));
        //     }).catch(err => {
        //         this.setInfo("정보 조회 실패", "", err.res.data.message);
        //     })
        // },
        callLogin() {
          const user = [this.userid, this.userpwd];
          this.login(user);
          this.$emit('close');
        },
    },
}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 30vw;
  min-width: 350px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>