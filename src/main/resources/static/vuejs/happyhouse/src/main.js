import Vue from 'vue';
import App from './App.vue';
import router from './router';
import store from './store';
import VeeValidate from 'vee-validate';
import ko from 'vee-validate/dist/locale/ko.js';
import { BootstrapVue, IconsPlugin } from 'bootstrap-vue';
import * as VueGoogleMaps from 'vue2-google-maps';

Vue.use(VeeValidate, {
  // This is the default
  inject: true,
  // Important to name this something other than 'fields'
  fieldsBagName: 'veeFields',
  // This is not required but avoids possible naming conflicts
  errorBagName: 'veeErrors',
  locale: 'ko',
  dictionary: { ko },
});

ko.messages.required = (field) => `${field} 필수입력란 입니다.`;

// Install BootstrapVue
Vue.use(BootstrapVue);
// Optionally install the BootstrapVue icon components plugin
Vue.use(IconsPlugin);

import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap-vue/dist/bootstrap-vue.css';

Vue.config.productionTip = false;
Vue.use(VueGoogleMaps, {
  load: {
    key: 'AIzaSyDFnYGyE6aKiF7it3aMtqBERPFQxW4EShw',
    libraries: 'places',
  },
});

new Vue({
  router,
  store,
  render: (h) => h(App),
}).$mount('#app');
