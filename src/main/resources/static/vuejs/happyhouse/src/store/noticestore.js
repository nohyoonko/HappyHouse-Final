import http from '@/util/http-common';
const storage = window.sessionStorage;

const noticeStore = {
  namespaced: true,
  state: {
    notices: [
    ],
    notice: Object,
    flag : 0,
  },
  getters: {
    get_notices(state) {
      return state.notices;
    },
    get_notice(state) {
      return state.notice;
    },
  },
  mutations: {
    SET_NOTICES(state, notices) {
      for (let i = 0; i < notices.length; i++){
        notices[i].kind = '공지';
      }
      state.notices = notices;
    },
    SET_NOTICE(state, notice) {
      state.notice = notice;
    },
    SET_FLAG(state, flag) {
      state.flag = flag;
    },
  },
  actions: {
    addNotice({ commit }, notice) {
      let userid= storage.getItem("login_user");
      notice.userid = userid;
      http
        .post('/notice', notice,
          {
            headers: {
              "jwt-auth-token": storage.getItem("jwt-auth-token")
            }
          })
        .then(({ data }) => {
          let msg = '공지 등록 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '공지 등록이 완료되었습니다.';
          }
          alert(msg);
        })
        .catch(() => {
          alert('공지 등록 처리시 에러가 발생했습니다.');
        });
    },
    modifyNotice({ commit }, notice) {
      http
        .put('/notice/'+notice.articleno, notice,
          {
            headers: {
              "jwt-auth-token": storage.getItem("jwt-auth-token")
            }
          })
        .then(({ data }) => {
          let msg = '공지 수정 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '공지 수정이 완료되었습니다.';
          }
          alert(msg);
        })
        .catch(() => {
          alert('공지 수정 처리시 에러가 발생했습니다.');
        });
    },
    getNotices({ commit }, notice) {
      http
        .get('/notice/get', { params: notice },
      {
                headers: {
                    "jwt-auth-token": storage.getItem("jwt-auth-token")
                }
      })
        .then(({ data }) => {
          commit('SET_NOTICES', data);
        })
        .catch(() => {
          alert('공지목록을 불러오는데 실패했습니다.');
        });
    },
    getNotice({ commit }, articleno) {
      http
        .get('/notice/get/' + articleno,
      {
                headers: {
                    "jwt-auth-token": storage.getItem("jwt-auth-token")
                }
      })
        .then(({ data }) => {
          commit('SET_NOTICE', data);
        })
        .catch(() => {
          alert('공지를 불러오는데 실패했습니다.');
        });
    },
    deleteNotice({ commit }, articleno) {
      http
      .delete('/notice/'+ articleno,
          {
            headers: {
              "jwt-auth-token": storage.getItem("jwt-auth-token")
            }
          })
      .then(({ data }) => {
        let msg = '삭제 처리시 문제가 발생했습니다.';
        if (data === 'success') {
          msg = '삭제가 완료되었습니다.';
        }
        alert(msg);
      })
      .catch(() => {
        alert('삭제 처리시 에러가 발생했습니다.');
      });
    },
    setFlag({ commit }, flag) {
      commit('SET_FLAG', flag)
    },

  },
  // plugins: [createPersistedState()],
};

export default noticeStore;
