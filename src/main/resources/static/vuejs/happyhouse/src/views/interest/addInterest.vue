<template>
  <div id="add-body">
   <h1 class="container d-flex justify-content-center mt-4 mb-4">관심지역
		등록</h1>
	<section
		class="main-content container d-flex justify-content-center mt-3">
		<!--동 검색 시작-->
	<article class="col-sm-6 p-5 text-center"
			style="border-radius: 20px; border: 3px solid WhiteSmoke;">
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
        <b-form-select name="city" id="dong" v-model="selected_dong">
          <option value="null" disabled>읍/면/동</option>
          <option v-for="dong in dongs" :key="dong.dong" :value="dong">{{ dong.dong }}</option>
        </b-form-select>
      </div>
			<button type="button" class="btn btn-warning" id="interest"
				@click="selectedInterest">관심지역 등록</button>
		</article>
		<!-- 동 검색 끝-->
	</section>
  </div>
</template>

<script>
import http from '@/util/http-common';
import {createNamespacedHelpers} from 'vuex'

const 
aptListHelper = createNamespacedHelpers('aptStore')
export default {
  name:'addInterest',
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
  },
  created() {
    this.reset();
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
      'addSido',
      'addGugun',
      'addDong',
      'addInterest'
    ]),
    reset(){
      this.addSido(null);
      this.addGugun(null);
      this.addDong(null);
      this.setSidoList(null);
      this.setGugunList(null);
      this.setDongList(null);
    },
    getGugun() {
      this.addGugun(null);
      this.addDong(null);
      http
        .get(`/aptrest/gugun/${this.selected_sido.sido_Code}`)
        .then(({ data }) => {
          this.guguns = data;
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
          this.addGugun(this.selected_gugun);
          this.setDongList(this.dongs);
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    },
    selectedInterest(){
      var addr = this.selected_sido.sido_Name + ' ' + this.selected_gugun.gugun_Name + ' ' + this.selected_dong.dong;
      this.addInterest(addr);
    },
  },
}
</script>

<style>
#add-body{
  height: 700px;
}
</style>