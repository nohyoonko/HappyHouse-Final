<template>
  <article class="mt-5 mb-5">
    <b-form inline>
      <label class="ml-3 mr-3">가격 범위: </label>
      <label class="mr-3">최소금액</label>
      <b-form-input class="price-group mr-3" type="text" size="sm" v-model="min"/>
      -
      <label class="ml-3 mr-3">최고금액</label>
      <b-form-input class="price-group" type="text" size="sm" v-model="max"/>
      <b-button @click.prevent="getAptDeals" size="sm">검색</b-button>
    </b-form>
    <table class="table table-hover card-list">
      <thead>
        <tr>
          <th>아파트 이름</th>
          <th @click="changeAlign"  style="cursor: pointer">거래금액 <span style="color:gray; font-size:13px">(단위:만원)</span>
            <b-iconstack font-scale="1" variant="white">
              <b-icon v-if="sortbyprice == 1" stacked icon="caret-up-fill" variant="dark" scale="1" ></b-icon>
              <b-icon v-if="!sortbyprice == 1" stacked icon="caret-down-fill" variant="dark" scale="1" ></b-icon>
            </b-iconstack>
          </th>
          <th>전용면적</th>
          <th>거래구분</th>
          <th>날짜</th>
        </tr>
      </thead>
      <tbody v-if="aptdeals != null && aptdeals.length !=0" class="apt-info-list">
        <apt-detail-item v-for="(aptdeal, index) in aptdeals" :key="index" :aptdeal="aptdeal" />
      </tbody>
      <tbody v-else class="apt-info-list">
          <b-row>
      <b-col><b-alert show>거래된 매물 목록이 없습니다.</b-alert></b-col>
      </b-row>
      </tbody>
    </table>
  </article>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import AptDetailItem from '@/components/apt/AptDetailItem.vue';
const aptStore = 'aptStore';

export default {
  name: 'AptDetail',
  components:{
    AptDetailItem,
  },
  data() {
    return {
      sortbyprice : 1,
      min:'0',
      max:'990000',
    }
  },
  computed: {
    ...mapState(aptStore,['apt','apts','aptdeals']),
  },
  watch:{
    apt: function() {
      this.aptclicked();
    },
  },
  filters: {
    price(value) {
      if (!value) return value;
      return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    },
  },
  methods: {
    ...mapActions(aptStore, ['setAptDeals']),
    aptclicked(){
       this.min = '0';
       this.max = '990000';
       this.sortbyprice = 1;
       this.getAptDeals();
    },
    getAptDeals(){
      if(this.min>990000){
        alert("최저금액은 99억원 까지 설정 가능합니다.");
        return;
      }else if(this.max < 0){
        alert("최고금액은 0원 까지 설정 가능합니다.");
        return;
      }
      
      var searchDealInfo={
        dong:this.apt.dong,
        AptName:this.apt.aptName,
        code:this.apt.code,
        min:this.min,
        max:this.max,
        sort:this.sortbyprice,
      };
      this.setAptDeals(searchDealInfo);
    },
    changeAlign(){
      if(this.sortbyprice == 1) this.sortbyprice = 0;
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
