import http from '@/util/http-common';

const aptStore = {
  namespaced: true,
  state: {
    markerlocs: [],
    sidos: [],
    guguns: [],
    dongs: [],
    apts: [],
    aptdeals:[],
    apt: Object,
    selected_sido: Object,
    selected_gugun: Object,
    selected_dong: Object,
    searchName: Object,
  },
  getters: {
    get_selected_gugun(state) {
      return state.selected_gugun;
    },
    get_selected_sido(state) {
      return state.selected_sido;
    },
    get_selected_dong(state) {
      return state.selected_dong;
    },
    get_dongs(state) {
      return state.dongs;
    },
    get_sidos(state) {
      return state.sidos;
    },
    get_guguns(state) {
      return state.guguns;
    },
    get_apts(state) {
      return state.apts;
    },
    get_aptdeals(state) {
      return state.aptdeals;
    },
    get_apt(state) {
      return state.apt;
    },
    get_markerlocs(state) {
      return state.markerlocs;
    },
    get_searchName(state) {
      return state.searchName;
    },
    
  },
  mutations: {
    SET_APTLIST(state, apts) {
      state.apts = apts;
    },
    SET_APT(state, apt) {
      state.apt = apt;
    },
    ADD_MARKERLOCS(state, markerlocs) {
      console.log('Add_Markerlocs call');
      state.markerlocs = [];
      state.markerlocs = markerlocs;
    },
    ADD_SIDO(state, selected_sido) {
      state.selected_sido = selected_sido;
    },
    ADD_GUGUN(state, selected_gugun) {
      state.selected_gugun = selected_gugun;
    },
    ADD_DONG(state, selected_dong) {
      state.selected_dong = selected_dong;
    },
    SET_SIDO_LIST(state, sidos) {
      state.sidos = sidos;
    },
    SET_GUGUN_LIST(state, guguns) {
      state.guguns = guguns;
    },
    SET_DONG_LIST(state, dongs) {
      state.dongs = dongs;
    },
    SET_SEARCHNAME(state, searchName) {
      state.searchName = searchName;
    },
    SET_APTDEALS(state, aptdeals) {
      state.aptdeals = aptdeals;
    }
  },
  actions: {
    addSido({ commit }, selected_sido) {
      commit('ADD_SIDO', selected_sido);
    },
    addGugun({ commit }, selected_gugun) {
      commit('ADD_GUGUN', selected_gugun);
    },
    addDong({ commit }, selected_dong) {
      commit('ADD_DONG', selected_dong);
    },
    addMarkerlocs({ commit }, markerlocs) {
      commit('ADD_MARKERLOCS', markerlocs);
    },
    setAptList({ commit }, apts) {
      commit('SET_APTLIST', apts);
    },
    setApt({ commit }, apt) {
      commit('SET_APT', apt);
    },
    setSidoList({ commit }, sidos) {
      commit('SET_SIDO_LIST', sidos);
    },
    setGugunList({ commit }, guguns) {
      commit('SET_GUGUN_LIST', guguns);
    },
    setDongList({ commit }, dongs) {
      commit('SET_DONG_LIST', dongs);
    },
    setSearchName({ commit }, searchName) {
      commit('SET_SEARCHNAME', searchName);
    },
    setAptDeals({ commit }, searchdealInfo) {
      http
      .get(`/aptrest/dealInfo`,{params : searchdealInfo})
      .then(({ data }) => {
        commit('SET_APTDEALS',data);
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
    }
  },
  // plugins: [createPersistedState()],
};

export default aptStore;
