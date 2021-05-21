import Vue from "vue";
import Vuex from "vuex";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    markerlocs:[]

  },
  getters: {
    
  },
  mutations: {
    ADD_MARKERLOCS(state, markerlocs) {
      console.log('Add_Markerlocs call');
      state.markerlocs = [];
      state.markerlocs = markerlocs;
    }
  },
  actions: {
    addMarkerlocs({ commit }, markerlocs) {
      commit('ADD_MARKERLOCS', markerlocs);
    }
  },
  modules: {},
});
