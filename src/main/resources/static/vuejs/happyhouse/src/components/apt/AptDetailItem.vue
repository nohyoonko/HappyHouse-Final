<template>
    <tr>
      <td>{{aptdeal.aptName}}</td>
      <td>{{aptdeal.dealAmount}}</td>
      <td>{{aptdeal.area}}</td>
      <td>매매</td>
      <td>{{aptdeal.dealYear}}년 {{aptdeal.dealMonth}}월 {{aptdeal.dealDay}}일</td>
    </tr>
</template>

<script>
import { mapActions } from 'vuex';

export default {
  name: 'AptListItem',
  data() {
    return {
      isColor: false,
      isInfo: false,
    };
  },
  props: {
    aptdeal: Object,
  },
  methods: {
    ...mapActions(['selectApt']),
    chooseApt() {
      this.selectApt(this.apt);
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
