<template>
  <article class="mt-5 mb-5">
    <b-form inline>
      <label class="ml-3 mr-3">가격 범위: </label>
      <label class="mr-3">최소금액</label>
      <b-form-input class="price-group mr-3" type="text" size="sm" v-model="min" />
      -
      <label class="ml-3 mr-3">최고금액</label>
      <b-form-input class="price-group" type="text" size="sm" v-model="max" />
      <b-button @click.prevent="getAptDeals" class="ml-1" size="sm">검색</b-button>
    </b-form>

    <b-table
      id="my-table"
      :items="aptdeals"
      :fields="fields"
      :current-page="currentPage"
      :per-page="perPage"
      :sort-by.sync="sortBy"
      :sort-desc.sync="sortDesc"
      stacked="sm"
    >
    </b-table>
    <b-pagination
      v-model="currentPage"
      :total-rows="rows"
      :per-page="perPage"
      aria-controls="my-table"
      first-text="First"
      prev-text="Prev"
      next-text="Next"
      last-text="Last"
      align="center"
    ></b-pagination>

    <!-- </table> -->
  </article>
</template>

<script>
import { mapState, mapActions } from "vuex";
//import AptDetailItem from "@/components/apt/AptDetailItem.vue";
const aptStore = "aptStore";

export default {
  name: "AptDetail",
  components: {
    //AptDetailItem,
  },
  data() {
    return {
      sortbyprice: 1,
      min: "0",
      max: "990000",
      perPage: 10,
      currentPage: 1,
      items: [],
      fields: [
        { key: "aptName", label: "아파트이름", sortable: true },
        { key: "dealAmount", label: "거래금액", sortable: true },
        { key: "area", label: "전용면적", sortable: true },
        { key: "kind", label: "거래구분", sortable: false },
        { key: "dealfinalday", label: "날짜", sortable: true },
      ],
    };
  },
  computed: {
    ...mapState(aptStore, ["apt", "apts", "aptdeals"]),
    rows() {
      return this.aptdeals.length;
    },
  },
  watch: {
    apt: function () {
      this.aptclicked();
    },
  },
  filters: {
    price(value) {
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    },
  },
  methods: {
    ...mapActions(aptStore, ["setAptDeals"]),
    aptclicked() {
      this.min = "0";
      this.max = "990000";
      this.sortbyprice = 1;
      this.getAptDeals();
    },
    getAptDeals() {
      if (this.min > 990000) {
        alert("최저금액은 99억원 까지 설정 가능합니다.");
        return;
      } else if (this.max < 0) {
        alert("최고금액은 0원 까지 설정 가능합니다.");
        return;
      }

      var searchDealInfo = {
        dong: this.apt.dong,
        AptName: this.apt.aptName,
        code: this.apt.code,
        min: this.min,
        max: this.max,
        sort: this.sortbyprice,
      };
      this.setAptDeals(searchDealInfo);
    },
    changeAlign() {
      if (this.sortbyprice == 1) this.sortbyprice = 0;
      else this.sortbyprice = 1;
      this.getAptDeals();
    },
  },
};
</script>

<style scoped>
.price-group {
  width: 100px;
}
</style>
