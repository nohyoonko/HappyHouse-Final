<template>
  <b-container>
    <b-row class="mt-4 mb-3">
      <b-col>
        <h2>아파트 매매 정보</h2>
      </b-col>
    </b-row>
    <apt-search-bar />
    <b-row>
      <b-col cols="8" align="left">
        <apt-map />
      </b-col>
      <b-col cols="4">
        <div class="apt-list" style="overflow: scroll; height: 70vh">
          <!-- <div style="display: none">현재 존재하는 집이 없습니다.</div> -->
          <apt-list />
        </div>
      </b-col>
      <b-col>
        <apt-detail />
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import AptSearchBar from "@/components/apt/AptSearchBar.vue";
import AptMap from "@/components/apt/AptMap.vue";
import AptList from "@/components/apt/AptList.vue";
import AptDetail from "@/components/apt/AptDetail.vue";

export default {
  name: "Apt",
  components: {
    AptSearchBar,
    AptList,
    AptMap,
    AptDetail,
  },
  data() {
    return {};
  },
  methods: {},
};
</script>

<style scoped></style>
