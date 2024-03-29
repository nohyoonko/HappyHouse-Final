import Vue from 'vue';
import Vuex from 'vuex';
import createPersistedState from 'vuex-persistedstate';

import aptStore from '@/store/aptstore.js';
import userStore from '@/store/userstore.js';
import boardStore from '@/store/boardstore.js';
import commentStore from '@/store/commentstore.js';
import noticeStore from '@/store/noticestore.js';
import interestStore from '@/store/intereststore.js';
import newsStore from '@/store/newsstore.js';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    aptStore: aptStore,
    userStore: userStore,
    boardStore: boardStore,
    commentStore: commentStore,
    noticeStore: noticeStore,
    interestStore: interestStore,
    newsStore: newsStore,
  },

  plugins: [
    createPersistedState({
      paths: ['userStore'],
      storage: window.sessionStorage,
    }),
  ],
});

export default store;
