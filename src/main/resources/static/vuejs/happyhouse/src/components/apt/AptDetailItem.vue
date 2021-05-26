<template>
  <tr>
    <td>
      {{ aptdeal.aptName }}
      <span v-if="aptdeal.floor != null"> {{ aptdeal.floor }}층</span>
    </td>
    <td>{{ aptdeal.dealAmount }}</td>
    <td>{{ aptdeal.area }}</td>
    <td><span class="badge badge-info ml-2 apt-type">'매매'</span></td>
    <td>{{ aptdeal.dealYear }}년 {{ aptdeal.dealMonth }}월 {{ aptdeal.dealDay }}일</td>
  </tr>
</template>

<script>
import { mapActions } from "vuex";

export default {
  name: "AptListItem",
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
    ...mapActions(["selectApt"]),
    chooseApt() {
      this.selectApt(this.apt);
    },
    showInfo(flag) {
      this.isInfo = flag;
    },
  },
};
</script>

<style scoped></style>
