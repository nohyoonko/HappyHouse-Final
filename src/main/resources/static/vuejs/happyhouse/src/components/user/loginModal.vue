<template>
    <!-- <div>
        <label for="userid">아이디</label>
        <input type="text" name="userid" id="userid" v-model="userid" />
        <label for="userpwd">비밀번호</label>
        <input type="password" name="userpwd" id="userpwd" v-model="userpwd" />
        <input type="submit" value="로그인" id="login" @click="login" />
        <hr>
        <span>
            사용자 정보: <span>{{message}}</span>
        </span>
        <hr>
        <button id="getInfo" @click="getInfo">정보확인</button>
        <button id="logout" @click="logout">로그아웃</button>
        <hr>
        <table>
            <tr>
                <th>상태</th>
                <td id="status">{{status}}</td>
            </tr>
            <tr>
                <th>토큰</th>
                <td id="token">{{token}}</td>
            </tr>
            <tr>
                <th>정보</th>
                <td id="info">{{info}}</td>
            </tr>
        </table>
    </div> -->
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
				        <button type="button" class="btn btn-primary" @click="login">LogIn</button>
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
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const storage = window.sessionStorage;

export default {
    data() {
        return {
            userid: "",
            userpwd: "",
            message: "로그인 해주세요.",
            status: "",
            token: "",
            info: ""
        }
    },
    methods: {
        setInfo(status, token, info) {
            this.status = status;
            this.token = token;
            this.info = info;
        },
        getInfo() {
            http.post("/info",
            {
                userid: "some@email.com",
                userpwd: "some password"
            },
            {
                headers: {
                    "jwt-auth-token": storage.getItem("jwt-auth-token")
                }
            }).then(res => {
                this.setInfo("정보 조회 성공", res.headers.auth_token, JSON.stringify(res.data));
            }).catch(err => {
                this.setInfo("정보 조회 실패", "", err.res.data.message);
            })
        },
        login() {
            storage.setItem("jwt-auth-token", "");
            storage.setItem("login_user", "");
            http.post("/user/login", 
            {
                userid: this.userid,
                userpwd: this.userpwd,
            }).then(res => {
                if (res.data.status) {
                    this.message = res.data.data.userid + "로 로그인 되었습니다.";
                    console.dir(res.headers["jwt-auth-token"]);
                    this.setInfo("성공", res.headers["jwt-auth-token"], JSON.stringify(res.data.data));
                    storage.setItem("jwt-auth-token", res.headers["jwt-auth-token"]);
                    storage.setItem("login_user", res.data.data.username);
                    this.$emit('close');
                } else {
                    this.setInfo("", "", "");
                    this.message("로그인 해주세요");
                }
            }).catch(err => {
                this.setInfo("실패", "", JSON.stringify(err.res || err.message));
                alert("로그인 실패!");
                this.$emit('close');
            })
        },
        init() {
            if (storage.getItem("jwt-auth-token")) {
                this.message = storage.getItem("login_user")+ "로 로그인 되었습니다.";
            } else {
                storage.setItem("jwt-auth-token", "");
            }
        }
    },
    mounted() {
        this.init();
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
  /* transition: opacity .3s ease; */
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 450px;
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