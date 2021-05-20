<template>
    <div>
        <label for="userid">아이디</label>
        <input type="text" name="userid" id="userid" v-model="email" />
        <label for="userpwd">비밀번호</label>
        <input type="password" name="userpwd" id="userpwd" v-model="password" />
        <input type="submit" value="로그인" id="login" @click="login" />
        <hr>
        <span>
            사용자 정보: <span>{{message}}</span>
        </span>
        <hr>
        <button id="getInfo" @click="getInfo">정보확인</button>
        <button id="logout" @click="logout">로그인</button>
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
    </div>
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
        logout() {
            storage.setItem("jwt-auth-token", "");
            storage.setItem("login_user", "");
            this.message = "로그인 해주세요.";
            this.setInfo("로그아웃 성공", "", "");
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
                    this.message = res.data.data.email + "로 로그인 되었습니다.";
                    console.dir(res.headers["jwt-auth-token"]);
                    this.setInfo("성공", res.headers["jwt-auth-token"], JSON.stringify(res.data.data));
                    storage.setItem("jwt-auth-token", res.headers["jwt-auth-token"]);
                    storage.setItem("login_user", res.data.data.email);
                } else {
                    this.setInfo("", "", "");
                    this.message("로그인 해주세요");
                    alert("입력 정보를 확인하세요.");
                }
            }).catch(err => {
                this.setInfo("실패", "", JSON.stringify(err.res || err.message));
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
    }
}
</script>

<style scoped>
table {
    border-collapse: collapse;
    width: 100%;
    word-break: break-all;
}
th {
    width: 50px;
}
td, th {
    border: 1px solid black;
}
</style>