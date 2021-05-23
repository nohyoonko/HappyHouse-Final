import Vue from 'vue';
import Vuex from 'vuex';
import aptStore from '@/store/aptstore.js';
import userStore from '@/store/userstore.js';

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    aptStore: aptStore,
    userStore: userStore,
  },
});

export default store;
