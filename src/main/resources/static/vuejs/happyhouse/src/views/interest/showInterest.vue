<template>
  <b-container class="bv-example-row">
    <b-row class="mt-4 mb-3">
      <b-col>
        <h2>관심지역 보기</h2>
        <p>"상권정보"를 클릭해서 주변의 다양한 상권(은행, 주유소, 카페 등)을 알아보세요.</p>
      </b-col>
    </b-row>
    <b-row>
      <b-col sm="8" align="center" style="min-width: 22rem">
        <interest-map />
      </b-col>
      <b-col sm="4" style="min-width: 22rem">
        <div class="interest-list" style="overflow: scroll; height: 600px">
          <interest-list />
        </div>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
import InterestMap from "@/components/interest/interestMap.vue";
import InterestList from "@/components/interest/interestList.vue";

export default {
  name: "ShowInterest",
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
