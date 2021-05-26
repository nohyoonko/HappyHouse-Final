import http from '@/util/http-common';
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const storage = window.sessionStorage;

const commentStore = {
  namespaced: true,
  state: {
    comment: null,
  },
  mutations: {
    GET_COMMENT(state, data) {
      state.comment = data;
    },
  },
  actions: {
    async getComment({ commit }, articleno) {
      await http
        .get(`/comment/${articleno}`, {
          headers: {
            'jwt-auth-token': storage.getItem('jwt-auth-token'),
          },
        })
        .then(({ data }) => {
          commit('GET_COMMENT', data);
        })
        .catch(() => {
          alert('답글을 불러오는 중 에러가 발생했습니다.');
        });
    },
    insertComment({ commit }, comment) {
      console.log(comment);
      console.log(JSON.stringify(comment));
      http
        .post('/comment', JSON.stringify(comment), {
          headers: {
            'jwt-auth-token': storage.getItem('jwt-auth-token'),
          },
        })
        .then(({ data }) => {
          let msg = '답글 등록 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '답글 등록이 완료되었습니다.';
          }
          alert(msg);
        })
        .catch(() => {
          alert('답글 등록 처리시 에러가 발생했습니다.');
        });
    },
    deleteComment({ commit }, commentno) {
      http
        .delete(`/comment/${commentno}`, {
          headers: {
            'jwt-auth-token': storage.getItem('jwt-auth-token'),
          },
        })
        .then(({ data }) => {
          let msg = '답글 삭제 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '답글 삭제가 완료되었습니다.';
          }
          alert(msg);
        })
        .catch(() => {
          alert('답글 삭제 처리시 에러가 발생했습니다.');
        });
    },
  },
};

export default commentStore;
