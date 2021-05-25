import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import aptStore from '@/store/aptstore.js';
import userStore from '@/store/userstore.js';
import noticeStore from '@/store/noticestore.js';
import interestStore from '@/store/intereststore.js';

Vue.use(Vuex);

const store = new Vuex.Store({

  modules: {
    aptStore: aptStore,
    userStore: userStore,
    noticeStore: noticeStore,
    interestStore: interestStore,
  },

  plugins: [
    createPersistedState({
      paths: ['userStore'],
      storage: window.sessionStorage,
    }),
  ],
});

export default store;
