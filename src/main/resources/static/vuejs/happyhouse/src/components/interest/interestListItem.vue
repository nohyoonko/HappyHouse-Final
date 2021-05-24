<template>
  <div class="apt-card card shadow text-center p-3 mb-3 mt-3" style="display: flex">
    <h4 class="mb-3 mt-2">{{interest.address}}</h4>
    <div class="text-right">
      <button
        class="btn btn-success mr-1"
        @click.prevent="chooseInterest"
      >
        지도에서 확인
      </button>
      <button
        class="btn btn-danger"
        @click.prevent="delInterest"
      >
        삭제
      </button>
    </div>
  </div>
</template>

<script>
import { mapActions } from 'vuex';
const interestStore = 'interestStore';

export default {
  name: 'InterestListItem',
  data() {
    return {
      isColor: false,
      isInfo: false,
    };
  },
  props: {
    interest: Object,
  },
  methods: {
    ...mapActions(interestStore, ['setInterest', 'deleteInterest','getInterests']),
    chooseInterest() {
      this.setInterest(this.interest);
    },
    async delInterest() {
      await this.deleteInterest(this.interest);
      await this.getInterests();
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
