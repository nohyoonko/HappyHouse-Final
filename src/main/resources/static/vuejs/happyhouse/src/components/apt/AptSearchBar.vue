<template>
  <div class="mb-3">
    <b-row >
      <b-col cols="6" align="right">
    <article id="searchbar-article" class="mt-5 justify-content-center ">
      <div class="form-group" id="menu1">
        <b-form-select name="city" id="sido" @change="getGugun" v-model="selected_sido">
          <option value="null" disabled>도/광역시</option>
          <option v-for="sido in sidos" :key="sido.sido_Code" :value="sido">
            {{ sido.sido_Name }}
          </option>
        </b-form-select>
      </div>
      <div class="form-group ml-2" id="menu2">
        <b-form-select name="city" id="gugun" @change="getDong" v-model="selected_gugun">
          <option value="null" disabled>시/구</option>
          <option v-for="gugun in guguns" :key="gugun.gugun_Code" :value="gugun">
            {{ gugun.gugun_Name }}
          </option>
        </b-form-select>
      </div>
      <div class="form-group ml-2" id="menu3">
        <b-form-select name="city" id="dong" @change="dongclick" v-model="selected_dong">
          <option value="null" disabled>읍/면/동</option>
          <option v-for="dong in dongs" :key="dong.dong" :value="dong">{{ dong.dong }}</option>
        </b-form-select>
      </div>
    </article>
      </b-col>
      <b-col cols="2"/>
      <b-col cols="4" >
        <b-input-group prepend="아파트명" class="mt-5">
        <b-form-input v-model="searchName"></b-form-input>
        <b-input-group-append>
          <b-button variant="outline-secondary" @click="setAptList" >검색</b-button>
        </b-input-group-append>
  </b-input-group>
      </b-col>
  </b-row>
    </div>
</template>

<script>
import http from '@/util/http-common';
import {createNamespacedHelpers} from 'vuex'

const
    aptListHelper = createNamespacedHelpers('aptStore')
//import { mapActions, mapState } from 'vuex';
// const aptStore = 'aptStore';
//{mapState: aptMapState, mapActions: aptMapActions} = createNamespacedHelpers('aptStore'),

export default {
  name: 'index',
  components: {},
  computed: {
    selected_gugun: {
      get () {
        //return this.$store.getters.get_selected_gugun('aptStore/')
        return this.$store.getters["aptStore/get_selected_gugun"];
      },
      set (value) {
        this.$store.commit('aptStore/ADD_GUGUN', value)
      }
  },
  selected_sido: {
      get () {
        return this.$store.getters["aptStore/get_selected_sido"];
      },
      set (value) {
        this.$store.commit('aptStore/ADD_SIDO', value)
      }
  },
  selected_dong: {
      get () {
        return this.$store.getters["aptStore/get_selected_dong"];
      },
      set (value) {
        this.$store.commit('aptStore/ADD_DONG', value)
      }
  },
  dongs: {
      get () {
        return this.$store.getters["aptStore/get_dongs"];
      },
      set (value) {
        this.$store.commit('aptStore/SET_DONG_LIST', value)
      }
  },
  sidos: {
      get () {
        return this.$store.getters["aptStore/get_sidos"];
      },
      set (value) {
        this.$store.commit('aptStore/SET_SIDO_LIST', value)
      }
  },
  guguns: {
      get () {
        return this.$store.getters["aptStore/get_guguns"];
      },
      set (value) {
        this.$store.commit('aptStore/SET_GUGUN_LIST', value)
      }
  },
  apts: {
      get () {
        return this.$store.getters["aptStore/get_apts"];
      },
      set (value) {
        this.$store.commit('aptStore/SET_APTLIST', value)
      }
  },
  markerlocs: {
      get () {
        return this.$store.getters["aptStore/get_markerlocs"];
      },
      set (value) {
        this.$store.commit('aptStore/ADD_MARKERLOCS', value)
      }
  },
  },
  data: function () {
    return {
      locs: [],
      searchName:'',
    };
  },
  created() {
    if(this.selected_sido == null || this.selected_sido == ''){
      this.reset();
    }
    http
      .get(`/aptrest/sido`)
      .then(({ data }) => {
        this.sidos = data;
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
  },
  methods: {
    ...aptListHelper.mapActions([
      'setSidoList',
      'setGugunList',
      'setDongList',
      'setAptList',
      'addMarkerlocs',
      'addSido',
      'addGugun',
      'addDong',
    ]),
    reset(){
      this.addSido(null);
      this.addGugun(null);
      this.addDong(null);
      this.setSidoList(null);
      this.setGugunList(null);
      this.setDongList(null);
      this.setAptList(null);
    },
    getGugun() {
      this.addGugun(null);
      this.addDong(null);
      http
        .get(`/aptrest/gugun/${this.selected_sido.sido_Code}`)
        .then(({ data }) => {
          this.guguns = data;
          this.guguns = data;
          this.locs = [];
          for (var i = 0; i < this.guguns.length; i++) {
            var temp = {addr:'', addrtext:''};
            temp.addr = this.selected_sido.sido_Name + ' ' + this.guguns[i].gugun_Name;
            temp.addrtext = this.guguns[i].gugun_Name;
            this.locs[i] = temp;
          }
          this.addMarkerlocs(this.locs);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    getDong() {
      this.addDong(null);
      http
        .get(`/aptrest/dong/${this.selected_gugun.gugun_Code}`)
        .then(({ data }) => {
          this.dongs = data;
          this.locs = [];
          for (var i = 0; i < this.dongs.length; i++) {
            var temp = {addr:'', addrtext:''};
            temp.addr = this.selected_sido.sido_Name +
              ' ' +
              this.selected_gugun.gugun_Name +
              ' ' +
              this.dongs[i].dong;
            temp.addrtext = this.dongs[i].dong;
            this.locs[i] = temp;
          }
          this.addMarkerlocs(this.locs);
          this.addGugun(this.selected_gugun);
          this.setDongList(this.dongs);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    dongclick(){
      this.searchName = '';
      this.setAptList();
    },
    setAptList() {
      if(this.selected_dong != null){
      var senddata={'dong' : this.selected_dong.dong,'aptname':this.searchName};
      this.locs = [];
      http
        .get(`/aptrest/aptlist`,{params : senddata})
        .then(({ data }) => {
          this.apts = data;
          for (var i = 0; i < this.apts.length; i++) {
            var temp = {addr:'', addrtext:''};
            temp.addr = this.selected_sido.sido_Name +
              ' ' +
              this.selected_gugun.gugun_Name +
              ' ' +
              this.selected_dong.dong + ' ' + this.apts[i].jibun
            temp.addrtext = this.apts[i].aptName;
            this.locs[i] = temp;
          }
          this.markerlocs=this.locs;

        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
      }
    },
  },
};
</script>

<style scoped>
.form-group {
  width: 170px;
  float: left;
}
</style>
