<template>
  <div class="apt-card card shadow text-center p-3 mb-3 mt-3" style="display: flex">
    <h4 class="mb-3 mt-2">{{ interest.address }}</h4>
    <div class="text-right">
      <b-button variant="outline-success" size="sm" class="mr-1" @click.prevent="chooseInterest"
        >지도에서 확인</b-button
      >
      <b-button variant="outline-danger" size="sm" @click.prevent="delInterest">삭제</b-button>
    </div>
  </div>
</template>

<script>
import { mapActions } from "vuex";
const interestStore = "interestStore";

export default {
  name: "InterestListItem",
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
    ...mapActions(interestStore, ["setInterest", "deleteInterest", "getInterests"]),
    chooseInterest() {
      this.setInterest(this.interest);
    },
    async delInterest() {
      await this.deleteInterest(this.interest);
      await this.getInterests();
      this.$router.go();
    },
  },
};
</script>

<style scoped></style>
