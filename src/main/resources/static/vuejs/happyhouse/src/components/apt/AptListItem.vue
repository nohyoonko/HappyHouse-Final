<template>
  <b-row
    class="m-2"
    @click="chooseApt"
    @mouseover="showInfo(true)"
    @mouseout="showInfo(false)"
    :class="{ 'mouse-over-bgcolor': isColor }"
  >
    <!-- <b-col cols="2" class="text-center">
      <img src="@/assets/apt.png" class="img-list" alt="" />
    </b-col>
    <b-col cols="10"> [{{ this.apt.no }}] {{ this.apt.AptName }}</b-col> -->

    <div
      class="apt-card card shadow text-center pb-3 mb-3 mt-3"
      style="display: flex; cursor: pointer"
      @click="chooseApt"
    >
      <img
        class="card-img-top"
        src="http://www.ksilbo.co.kr/news/photo/202008/770672_439915_052.jpg"
      />
      <div>
        <div class="apt-name mt-2 mb-2" style="font-weight: bold">{{apt.aptName}}</div>
      </div>

      <div  class="card overlay aptclick" style="background-color: blue;" value="`+ apt.dong+` `+ apt.aptName +`">
        <div class="text pt-3 container-fluid">
          <div class="apt-name mb-2" style="font-weight: bold; font-size: small">
            <div class="card-header row justify-content-center">
              <span class="aptname" style="font-size: medium">{{apt.aptName}}</span>
            </div>
            <div class="row solid pt-2" style="border-top: 2px solid #999"></div>
            <div class="row mb-2 justify-content-center"></div>
            <div class="row mb-2 justify-content-center">
              <i class="fa fa-hands-helping mr-2" style="color: white"></i> 거래구분
              <span class="badge badge-info ml-2 apt-type">'매매'</span>
            </div>
            <div class="row pb-5 justify-content-center">
              <i class="fa fa-calendar-alt mr-2" style="color: white"></i>
              <span class="apt-date">{{apt.buildYear}}년</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </b-row>
</template>

<script>
import { mapActions } from 'vuex';
const aptStore = 'aptStore';

export default {
  name: 'AptListItem',
  data() {
    return {
      isColor: false,
      isInfo: false,
    };
  },
  props: {
    apt: Object,
  },
  methods: {
    ...mapActions(aptStore,['setApt']),
    chooseApt() {
      this.setApt(this.apt);
    },
    showInfo(flag) {
      this.isInfo = flag;
    },
  },
};
</script>

<style scoped>
.img-list {
  width: 50px;
}
.overlay {
	position: absolute;
	top: 0;
	bottom: 0;
	left: 0;
	right: 0;
	height: 100%;
	width: 100%;
	opacity: 0;
	transition: 0.5s ease;
	background-color: #0244a7;
}

.apt-card:hover .overlay {
	opacity: 1;
}

.text {
	color: white;
	font-size: 20px;
	position: absolute;
	top: 60%;
	left: 50%;
	-webkit-transform: translate(-50%, -50%);
	-ms-transform: translate(-50%, -50%);
	transform: translate(-50%, -50%);
	text-align: center;
}
</style>
