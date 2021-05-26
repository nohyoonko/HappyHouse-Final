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
    profileFlag:0,
  },
  getters: {},
  mutations: {
    INIT(state) {
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
    SET_PROFILE_FLAG(state, flag) {
      state.profileFlag = flag;
    }
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
    modify({ commit, dispatch }, user) {
      http
      .put('/member', user,
      {
        headers: {
          "jwt-auth-token": storage.getItem("jwt-auth-token")
        }
      })
        .then((data) => {
          commit('LOGIN', data.data);
          alert('회원수정 성공!');
        })
        .catch(() => {
          alert('회원수정 실패! 비밀번호를 확인해주세요');
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
    async delete({ commit }, userid) {
      await http
        .delete('/member/'+ userid,
        {
          headers: {
            "jwt-auth-token": storage.getItem("jwt-auth-token")
          }
        })
        .then(() => {
          storage.setItem('jwt-auth-token', '');
          storage.setItem('login_user', '');
          commit('SET_PROFILE_FLAG', 0);
          alert('탈퇴 되었습니다.');
        })
        .catch(() => {
          alert('탈퇴에 실패했습니다.');
        });
    },
    setProfileFlag({ commit }, flag) {
      commit('SET_PROFILE_FLAG', flag);
    }
  },
};

export default userStore;
