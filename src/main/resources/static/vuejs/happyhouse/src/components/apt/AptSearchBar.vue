<template>
  <b-row class="mt-4 mb-4 container text-center">
    	<article class="row mt-5 justify-content-end">
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
  </b-row>
</template>

<script>
import http from '@/util/http-common';
import { mapActions } from 'vuex';
const aptStore = 'aptStore'

export default {
   name: 'index',
   components: {
    
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
      ...mapActions(aptStore, ['addMarkerlocs','addSido','addGugun','addDong','setAptList']),
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
        console.log(data.length);
				// this.addSido(this.selected_sido);
				// this.addGugun(this.selected_gugun);
				// this.addDong(this.selected_dong);
        this.setAptList(this.apts);
        console.log(data.length);
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
      }
   },
}
</script>

<style>
.form-group{
	width: 100px;
}
</style>
