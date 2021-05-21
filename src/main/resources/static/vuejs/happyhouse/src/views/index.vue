<template>
  <div id="index" class="main-body">
    <section class="container text-center mb-3">
		<div class="page-header mt-5 pt-5">
			<h1 class="brand">HAPPY HOUSE</h1>
			<p style="font-weight: bolder; font-size: 15pt;">어떤 집을 찾고 있나요?</p>
		</div>
		<!--동 검색 시작-->
		<article class="row mt-5 justify-content-center">
			<div class="form-group ml-2" id="menu1">
				<b-form-select name="city" id="sido" @change="getGugun" v-model="selected_sido">
					<option value="null" disabled>도/광역시</option>
					<option v-for="sido in sidos" :key="sido.sido_Code" :value="sido" >{{sido.sido_Name}}</option>
				</b-form-select>
			</div>
			<div class="form-group ml-2" id="menu2">
				<b-form-select name="city" id="gugun" @change="getDong" v-model="selected_gugun">
					<option value="null" disabled>시/구</option>
					<option v-for="gugun in guguns" :key="gugun.gugun_Code" :value="gugun" >{{gugun.gugun_Name}}</option>
				</b-form-select>
			</div>
			<div class="form-group ml-2" id="menu3">
				<b-form-select name="city" id="dong" @change="mvapt" v-model="selected_dong">
					<option value="null" disabled>읍/면/동</option>
					<option v-for="dong in dongs" :key="dong.dong" :value="dong" >{{dong.dong}}</option>
				</b-form-select>
			</div>
		</article>
		<!-- 동 검색 끝-->
		<index-map />
  </section>
  </div>
</template>

<script>
import http from '@/util/http-common';
import IndexMap from '@/components/IndexMap.vue';
import { mapActions } from 'vuex';
const aptStore = 'aptStore'

export default {
   name: 'index',
   components: {
      IndexMap,
   },
   data : function() {
      return {
         sidos:[],
         selected_sido: null,
         guguns:[],
         selected_gugun: null,
         dongs:[],
         selected_dong: null,
         apts:[],
         locs:['11','22'],
      };
   },
   created() {
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
      ...mapActions(aptStore, ['setSidoList','setGugunList','setDongList','setAptList','addMarkerlocs','addSido','addGugun','addDong']),
      getGugun() {
         http
      .get(`/aptrest/gugun/${this.selected_sido.sido_Code}`)
      .then(({ data }) => {
        this.guguns = data;
            this.locs = [];
            for(var i = 0; i < this.guguns.length; i++){
               this.locs[i] = this.selected_sido.sido_Name +" "+ this.guguns[i].gugun_Name;
            }
            this.addMarkerlocs(this.locs);
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
      },
         getDong() {
         http
      .get(`/aptrest/dong/${this.selected_gugun.gugun_Code}`)
      .then(({ data }) => {
        this.dongs = data;
            this.locs = [];
            for(var i = 0; i < this.dongs.length; i++){
               this.locs[i] = this.selected_sido.sido_Name +" "+ this.selected_gugun.gugun_Name +" " + this.dongs[i].dong;
            }
            this.addMarkerlocs(this.locs);
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
      },
      mvapt(){
         http
      .get(`/aptrest/apt/${this.selected_dong.dong}`)
      .then(({ data }) => {
        this.apts = data;
        this.setSidoList(this.sidos);
        this.setGugunList(this.guguns);
        this.setDongList(this.dongs);
				this.addSido(this.selected_sido);
				this.addGugun(this.selected_gugun);
				this.addDong(this.selected_dong);
        this.setAptList(this.apts);
				this.$router.push('/apt');
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
      }
   },
}
</script>

<style scoped>
.form-group{
	width: 200px;
}
.main-body {
  height: 100%;
  overflow: hidden;
  background-image: url("../assets/back.jpg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
}
.brand {
	font-size: 100px; 
	font-weight: bold; 
	color: white; 
	text-shadow: 2px 2px 2px #000; 
	font-family: 'Anton', sans-serif;
}
</style>