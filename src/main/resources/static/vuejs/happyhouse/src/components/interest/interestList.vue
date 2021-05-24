<template>
  <b-container v-if="interests && interests.length != 0" class="bv-example-row mt-3">
    <interest-list-item v-for="(interest, index) in interests" :key="index" :interest="interest" />
  </b-container>
  <b-container v-else class="bv-example-row mt-3">
    <b-row>
      <b-col><b-alert show>관심지역 목록이 없습니다.</b-alert></b-col>
    </b-row>
  </b-container>
</template>

<script>
import { mapState, mapActions } from 'vuex';
import InterestListItem from '@/components/interest/interestListItem.vue';
const interestStore = 'interestStore';

export default {
  name: 'interestList',
  components: {
    InterestListItem,
  },
  computed: {
    ...mapState(interestStore, ['interests']),
    // interests: {
    //   get () {
    //     //return this.$store.getters.get_selected_gugun('aptStore/')
    //     return this.$store.getters["interestStore/get_interests"];
    //   },
    //   set (value) {
    //     this.$store.commit('interestStore/SET_INTERESTS', value)
    //   }
  //},
  },
  watch:{
    interests: function() {
      console.log("changed!");
    }
  },
  created() {
    this.getInterestareas();
  },
  methods: {
     ...mapActions(interestStore,['getInterests']),
     getInterestareas(){
       this.getInterests();
     }
  },
};
</script>

<style></style>
