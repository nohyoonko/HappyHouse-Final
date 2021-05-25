import http from '@/util/http-common';
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const storage = window.sessionStorage;

const userStore = {
  namespaced: true,
  state: {
    loginUser: {
      id: '',
      name: '',
      email: '',
      phone: '',
      address: '',
    },
  },
  getters: {},
  mutations: {
    INIT(state) {
      console.log(state.loginUser);
      if (storage.getItem('login_user') === null) {
        state.loginUser.id = '';
        state.loginUser.name = '';
        state.loginUser.email = '';
        state.loginUser.phone = '';
        state.loginUser.address = '';
      }
    },
    LOGIN(state, data) {
      state.loginUser.id = data.userid;
      state.loginUser.name = data.username;
      state.loginUser.email = data.email;
      state.loginUser.phone = data.phone;
      state.loginUser.address = data.address;
    },
    LOGOUT(state) {
      state.loginUser.id = '';
      state.loginUser.name = '';
      state.loginUser.email = '';
      state.loginUser.phone = '';
      state.loginUser.address = '';
    },
    MODIFY_MEMBER(state, member) {
      state.loginUser.name = member.username;
      state.loginUser.email = member.email;
      state.loginUser.phone = member.phone;
      state.loginUser.address = member.address;
    },
  },
  actions: {
    init({ commit }) {
      commit('INIT');
    },
    login({ commit }, user) {
      storage.setItem('jwt-auth-token', '');
      storage.setItem('login_user', '');
      http
        .post('/user/login', {
          userid: user[0],
          userpwd: user[1],
        })
        .then((res) => {
          if (res.data.status) {
            storage.setItem('jwt-auth-token', res.headers['jwt-auth-token']);
            storage.setItem('login_user', res.data.data.userid);
            commit('LOGIN', res.data.data);
          }
        })
        .catch(() => {
          alert('아이디나 비밀번호를 확인하세요.');
        });
    },
    logout({ commit }) {
      storage.setItem('jwt-auth-token', '');
      storage.setItem('login_user', '');
      commit('LOGOUT');
    },
    join({ commit }, user) {
      http
        .post('/member/join', user)
        .then(() => {
          alert('회원가입 성공!');
        })
        .catch(() => {
          alert('회원가입 실패!');
        });
    },
    findpwd({ commit }, info) {
      http
        .post('/member/findpwd', info)
        .then((res) => {
          alert(res.data);
        })
        .catch(() => {
          alert('비밀번호를 찾을 수 없습니다.');
        });
    },
  },
};

export default userStore;
