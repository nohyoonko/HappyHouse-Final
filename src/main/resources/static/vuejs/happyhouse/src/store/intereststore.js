import http from '@/util/http-common';
const storage = window.sessionStorage;

const interestStore = {
  namespaced: true,
  state: {
    interests:[],
  },
  getters: {
    get_interests(state) {
      return state.interests;
    },
  },
  mutations: {
    SET_INTERESTS(state, interests) {
      state.interests = interests;
    },
  },
  actions: {
    addInterest({ commit }, addr) {
      http
        .post('/interest', {
          userid: storage.getItem("login_user"),
          address: addr,
        },
          {
            headers: {
              "jwt-auth-token": storage.getItem("jwt-auth-token")
            }
          })
        .then(({ data }) => {
          let msg = '관심지역 등록 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '관심지역 등록이 완료되었습니다.';
          }
          alert(msg);
        })
        .catch(() => {
          alert('등록 처리시 에러가 발생했습니다.');
        });
    },
    getInterests({ commit }) {
      alert("get호출");
      http
        .get('/interest/'+storage.getItem("login_user"),
      {
                headers: {
                    "jwt-auth-token": storage.getItem("jwt-auth-token")
                }
      })
        .then(({ data }) => {
          alert("then");
          commit('SET_INTERESTS', data);
        })
        .catch(() => {
          alert('관심목록을 불러오는데 실패했습니다.');
        });
    },
    deleteInterest({ commit }, interest) {
      http
      .delete('/interest/'+ interest.userid +'/' + interest.address,
          {
            headers: {
              "jwt-auth-token": storage.getItem("jwt-auth-token")
            }
          })
      .then(({ data }) => {
        let msg = '관심지역 삭제 처리시 문제가 발생했습니다.';
        if (data === 'success') {
          msg = '관심지역 삭제가 완료되었습니다.';
        }
        alert(msg);
      })
      .catch(() => {
        alert('삭제 처리시 에러가 발생했습니다.');
      });
    }

  },
  // plugins: [createPersistedState()],
};

export default interestStore;
