import Vue from "vue";
import Vuex from "vuex";
import aptStore from '@/store/aptstore.js'

Vue.use(Vuex);

const store = new Vuex.Store({
  modules: {
    aptStore: aptStore,
  },
})

export default store

