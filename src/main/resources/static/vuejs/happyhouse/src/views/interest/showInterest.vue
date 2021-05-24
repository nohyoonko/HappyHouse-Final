<template>
  <b-container class="bv-example-row">
    <b-row>
      <b-col>
        <h2>관심지역 정보보기</h2>
      </b-col>
    </b-row>
    <b-row>
      <b-col cols="8" align="left">
        <interest-map />
      </b-col>
      <b-col cols="4">
        <div class="interest-list" style="overflow: scroll; height: 400px">
				 <interest-list />
		    </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import InterestMap from '@/components/interest/interestMap.vue';
import InterestList from '@/components/interest/interestList.vue';

export default {
  name: 'ShowInterest',
  components: {
    InterestList,
    InterestMap,
  },
  data() {
    return {};
  },
  methods: {},
};
</script>

<style scoped></style>
