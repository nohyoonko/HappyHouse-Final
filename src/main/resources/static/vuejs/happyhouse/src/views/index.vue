<template>
  <div id="index">
    <section class="container text-center mb-3">
		<div class="page-header mt-5 pt-5">
			<h1
				style="font-size: 100px; font-weight: bold; color: white; text-shadow: 2px 2px 2px #000; font-family: 'Anton', sans-serif;">HAPPY
				HOUSE</h1>
			<p style="font-weight: bolder;">어떤 집을 찾고 있나요?</p>
		</div>
		<!--동 검색 시작-->
		<article class="row mt-5 justify-content-center">
			<div class="form-group ml-2" id="menu1">
				<select class="form-control" name="city" id="sido" @change="getGugun" v-model="selected_sido">
					<option value="0">도/광역시</option>
					<option v-for="sido in sidos" :key="sido.sido_Code" :value="sido.sido_Code" >{{sido.sido_Name}}</option>
				</select>
			</div>
			<div class="form-group ml-2" id="menu2">
				<select class="form-control" name="city" id="gugun" @change="getDong" v-model="selected_gugun">
					<option value="0">시/구</option>
					<option v-for="gugun in guguns" :key="gugun.gugun_Code" :value="gugun.gugun_Code" >{{gugun.gugun_Name}}</option>
				</select>
			</div>
			<div class="form-group ml-2" id="menu3">
				<select class="form-control" name="city" id="dong" @change="getApt" v-model="selected_dong">
					<option value="0">읍/면/동</option>
					<option v-for="dong in dongs" :key="dong.dong" :value="dong.dong" >{{dong.dong}}</option>
				</select>
			</div>
		</article>
		<!-- 동 검색 끝-->
		<index-map v-bind:markerlocs="markerlocs"/>
  </section>
  </div>
</template>

<script>
import http from '@/util/http-common';
import IndexMap from '@/components/IndexMap.vue';
export default {
	name: 'index',
	components: {
		IndexMap,
	},
	watch: {
		markerlocs: function() {
			console.log(this.markerlocs.length);
		}
	},
	data : function() {
		return {
			sidos:[],
			selected_sido:"도/광역시",
			guguns:[],
			selected_gugun:'시/구',
			dongs:[],
			selected_dong:'읍/면/동',
			apts:[],
			markerlocs:[],
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
		getGugun() {
			http
      .get(`/aptrest/gugun/${this.selected_sido}`)
      .then(({ data }) => {
        this.guguns = data;
				for(var i = 0; i < this.guguns.length; i++){
					this.markerlocs[i] = this.selected_sido + this.guguns[i];
					console.log(this.markerlocs[i]);
				}
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
		},
			getDong() {
			http
      .get(`/aptrest/dong/${this.selected_gugun}`)
      .then(({ data }) => {
        this.dongs = data;
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
		},
		getApt(){
			http
      .get(`/aptrest/apt/${this.selected_dong}`)
      .then(({ data }) => {
        this.apts = data;
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
</style>