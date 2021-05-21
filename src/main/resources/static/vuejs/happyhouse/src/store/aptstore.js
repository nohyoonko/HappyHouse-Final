import http from '@/util/http-common';

const aptStore = {
  namespaced: true,
  state: {
    markerlocs: [],
    sidos: [],
    guguns: [],
    dongs: [],
    apts: [],
    apt: Object,
    selected_sido: Object,
    selected_gugun: Object,
    selected_dong: Object,
  },
  getters: {
    get_selected_gugun(state) {
      return state.selected_gugun;
    },
    get_dongs(state) {
      return state.dongs;
    }
  },
  mutations: {
    SET_APTLIST(state, apts) {
      state.apts = apts;
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
    setSidoList({ commit }, sidos) {
      commit('SET_SIDO_LIST', sidos);
    },
    setGugunList({ commit }, guguns) {
      commit('SET_GUGUN_LIST', guguns);
    },
    setDongList({ commit }, dongs) {
      commit('SET_DONG_LIST', dongs);
    },
  },
  // plugins: [createPersistedState()],
};

export default aptStore;
