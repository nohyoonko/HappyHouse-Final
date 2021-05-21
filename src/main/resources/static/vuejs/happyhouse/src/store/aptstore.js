const aptStore = {
  namespaced: true,
  state: {
    apts: [],
    apt: Object,
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
  },
  actions: {
    addSido() {},
    addGugun() {},
    addDong() {},
    addMarkerlocs({ commit }, markerlocs) {
      commit('ADD_MARKERLOCS', markerlocs);
    },
    setAptList({ commit }, apts) {
      commit('SET_APTLIST', apts);
    },
  },
  // plugins: [createPersistedState()],
};

export default aptStore;
