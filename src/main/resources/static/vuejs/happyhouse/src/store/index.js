import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import aptStore from '@/store/aptstore.js';
import userStore from '@/store/userstore.js';

Vue.use(Vuex);

const store = new Vuex.Store({
  // namespaced: true,
  // state: {
  //   markerlocs: [],
  //   sidos: [],
  //   guguns: [],
  //   dongs: [],
  //   apts: [],
  //   apt: Object,
  //   selected_sido: Object,
  //   selected_gugun: Object,
  //   selected_dong: Object,
  // },
  // mutations: {
  //   SET_APTLIST(state, apts) {
  //     state.apts = apts;
  //   },
  //   ADD_MARKERLOCS(state, markerlocs) {
  //     console.log('Add_Markerlocs call');
  //     state.markerlocs = [];
  //     state.markerlocs = markerlocs;
  //   },
  //   ADD_SIDO(state, selected_sido) {
  //     state.selected_sido = selected_sido;
  //   },
  //   ADD_GUGUN(state, selected_gugun) {
  //     state.selected_gugun = selected_gugun;
  //   },
  //   ADD_DONG(state, selected_dong) {
  //     state.selected_dong = selected_dong;
  //   },
  //   SET_SIDO_LIST(state, sidos) {
  //     state.sidos = sidos;
  //   },
  //   SET_GUGUN_LIST(state, guguns) {
  //     state.guguns = guguns;
  //   },
  //   SET_DONG_LIST(state, dongs) {
  //     state.dongs = dongs;
  //   },
  // },
  // actions: {
  //   addSido({ commit }, selected_sido) {
  //     commit('ADD_SIDO', selected_sido);
  //   },
  //   addGugun({ commit }, selected_gugun) {
  //     commit('ADD_GUGUN', selected_gugun);
  //   },
  //   addDong({ commit }, selected_dong) {
  //     commit('ADD_DONG', selected_dong);
  //   },
  //   addMarkerlocs({ commit }, markerlocs) {
  //     commit('ADD_MARKERLOCS', markerlocs);
  //   },
  //   setAptList({ commit }, apts) {
  //     commit('SET_APTLIST', apts);
  //   },
  //   setSidoList({ commit }, sidos) {
  //     commit('SET_SIDO_LIST', sidos);
  //   },
  //   setGugunList({ commit }, guguns) {
  //     commit('SET_GUGUN_LIST', guguns);
  //   },
  //   setDongList({ commit }, dongs) {
  //     commit('SET_DONG_LIST', dongs);
  //   },
  // },
  modules: {
    aptStore: aptStore,
    userStore: userStore,
  },

  plugins: [
    createPersistedState({
      paths: ['userStore'],
    }),
  ],
});

export default store;
