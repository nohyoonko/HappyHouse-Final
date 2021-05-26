import http from '@/util/http-common';
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const storage = window.sessionStorage;

const boardStore = {
  namespaced: true,
  state: {
    items: [],
  },
  mutations: {
    GET_BOARD_LIST(state, data) {
      state.items = data;
    },
  },
  actions: {
    getBoardList({ commit }) {
      http
        .get('/board', {
          headers: {
            'jwt-auth-token': storage.getItem('jwt-auth-token'),
          },
        })
        .then(({ data }) => {
          commit('GET_BOARD_LIST', data);
        })
        .catch(() => {
          alert('Q&A 목록을 불러오는 중 문제가 발생했습니다.');
        });
    },
  },
};

export default boardStore;
