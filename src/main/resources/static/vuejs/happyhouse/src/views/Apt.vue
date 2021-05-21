<template>
  <b-container class="bv-example-row">
    <b-row>
      <b-col>
        <h2>아파트 매매 정보</h2>
      </b-col>
    </b-row>
    <apt-search-bar />
    <b-row>
      <b-col cols="6" align="left">
        <apt-map />
      </b-col>
      <b-col cols="6">
        <apt-list />
        <!-- <apt-detail /> -->
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import AptSearchBar from '@/components/apt/AptSearchBar.vue';
import AptMap from '@/components/apt/AptMap.vue';
import AptList from '@/components/apt/AptList.vue';
// import AptDetail from '@/components/apt/AptDetail.vue';

export default {
  name: 'Apt',
  components: {
    AptSearchBar,
    AptList,
    //AptDetail,
    AptMap,
  },
  data() {
    return {};
  },
  methods: {},
};
</script>

<style scoped></style>
