<template>
  <b-row
    class="m-2"
    @click="chooseApt"
    @mouseover="colorChange(true)"
    @mouseout="colorChange(false)"
    :class="{ 'mouse-over-bgcolor': isColor }"
  >
    <!-- <b-col cols="2" class="text-center">
      <img src="@/assets/apt.png" class="img-list" alt="" />
    </b-col>
    <b-col cols="10"> [{{ this.apt.no }}] {{ this.apt.AptName }}</b-col> -->

    <div
      class="apt-card card shadow text-center pb-3 mb-3 mt-3"
      style="display: flex; cursor: pointer"
    >
      <img
        class="card-img-top"
        src="http://www.ksilbo.co.kr/news/photo/202008/770672_439915_052.jpg"
      />
      <div>
        <div class="apt-name mt-2 mb-2" style="font-weight: bold">`+vo.aptName+`</div>
      </div>
      <div class="card overlay aptclick" value="`+ vo.dong+` `+ vo.aptName +`">
        <div class="text pt-3 container-fluid">
          <div class="apt-name mb-2" style="font-weight: bold; font-size: small">
            <div class="card-header row justify-content-center">
              <span class="aptname" style="font-size: medium">`+vo.aptName+`</span>
            </div>
            <div class="row solid pt-2" style="border-top: 2px solid #999"></div>
            <div class="row mb-2 justify-content-center"></div>
            <div class="row mb-2 justify-content-center">
              <i class="fa fa-hands-helping mr-2" style="color: white"></i> 거래구분
              <span class="badge badge-info ml-2 apt-type">'매매'</span>
            </div>
            <div class="row pb-5 justify-content-center">
              <i class="fa fa-calendar-alt mr-2" style="color: white"></i>
              <span class="apt-date">`+vo.buildYear+`년</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  </b-row>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'AptListItem',
  data() {
    return {
      isColor: false,
    };
  },
  props: {
    apt: Object,
  },
  methods: {
    // chooseApt() {
    //   // this.$emit('select-apt', this.apt);
    //   this.$store.dispatch('selectApt', this.apt);
    // },
    ...mapActions(['selectApt']),
    chooseApt() {
      this.selectApt(this.apt);
    },
    colorChange(flag) {
      this.isColor = flag;
    },
  },
};
</script>

<style scoped>
.img-list {
  width: 50px;
}
.mouse-over-bgcolor {
  background-color: lightblue;
}
</style>
