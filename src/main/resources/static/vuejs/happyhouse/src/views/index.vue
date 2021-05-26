<template>
  <div id="index" class="main-body">
    <section class="container text-center mb-3">
      <div class="page-header mt-4 pt-5">
        <h1 class="brand">HAPPY HOUSE</h1>
        <p style="font-weight: bolder; font-size: 15pt">어떤 집을 찾고 있나요?</p>
      </div>
      <!--동 검색 시작-->
      <article class="row mt-5 justify-content-center">
        <div class="form-group ml-2" id="menu1">
          <b-form-select name="city" id="sido" @change="getGugun" v-model="selected_sido">
            <option value="null" disabled>도/광역시</option>
            <option v-for="sido in sidos" :key="sido.sido_Code" :value="sido">
              {{ sido.sido_Name }}
            </option>
          </b-form-select>
        </div>
        <div class="form-group ml-2" id="menu2">
          <b-form-select name="city" id="gugun" @change="getDong" v-model="selected_gugun">
            <option value="null" disabled>시/구</option>
            <option v-for="gugun in guguns" :key="gugun.gugun_Code" :value="gugun">
              {{ gugun.gugun_Name }}
            </option>
          </b-form-select>
        </div>
        <div class="form-group ml-2" id="menu3">
          <b-form-select name="city" id="dong" @change="mvapt" v-model="selected_dong">
            <option value="null" disabled>읍/면/동</option>
            <option v-for="dong in dongs" :key="dong.dong" :value="dong">{{ dong.dong }}</option>
          </b-form-select>
        </div>
      </article>
      <!-- 동 검색 끝-->
      <index-map />
    </section>
    <b-container fluid style="background-color: white" class="pt-4">
      <b-row class="mb-3 justify-content-center">
        <b-col sm="4" class="mb-3">
          <b-card border-variant="info" align="center" style="min-width: 20rem">
            <div>
              <h3 class="text-info">가장 인기 있는 동네 TOP 5</h3>
              <h5>TOP 1 : {{ top }}</h5>
            </div>
            <index-interest-chart />
          </b-card>
        </b-col>
        <b-col sm="4" class="mb-3">
          <b-card
            border-variant="info"
            header="오늘의 뉴스"
            header-text-variant="info"
            header-border-variant="info"
            header-tag="h4"
            style="min-width: 20rem"
          >
            <ul>
              <li v-for="(article, index) in news" :key="index" class="mb-3">
                <b-card-title
                  ><h5>
                    <a :href="article.url">❍ {{ article.title }}</a>
                  </h5></b-card-title
                >
                <b-card-sub-title>{{ article.summary.substr(0, 82) }}</b-card-sub-title>
              </li>
            </ul>
          </b-card>
        </b-col>
      </b-row>
    </b-container>
  </div>
</template>

<script>
import http from "@/util/http-common";
import moment from "moment";
import IndexMap from "@/components/index/IndexMap.vue";
import IndexInterestChart from "@/components/index/IndexInterestChart.vue";
import { mapActions, mapState } from "vuex";
const aptStore = "aptStore";
const interestStore = "interestStore";
const newsStore = "newsStore";

export default {
  name: "index",
  components: {
    IndexMap,
    IndexInterestChart,
  },
  data: function () {
    return {
      sidos: [],
      selected_sido: null,
      guguns: [],
      selected_gugun: null,
      dongs: [],
      selected_dong: null,
      apts: [],
      locs: [],
      top: "",
      today: "",
    };
  },
  computed: {
    ...mapState(interestStore, ["topinterests"]),
    ...mapState(newsStore, ["news"]),
  },
  watch: {
    topinterests: function () {
      let topone = this.topinterests[0].address + "";
      var jbSplit = topone.split(" ");
      this.top = jbSplit[2];
    },
    today: function () {
      this.today = moment(new Date()).format("YYYY.MM.DD");
    },
  },
  created() {
    http
      .get(`/aptrest/sido`)
      .then(({ data }) => {
        this.sidos = data;
      })
      .catch(() => {
        alert("에러가 발생했습니다.");
      });
    this.getNews();
  },
  methods: {
    ...mapActions(aptStore, [
      "setSidoList",
      "setGugunList",
      "setDongList",
      "setAptList",
      "addMarkerlocs",
      "addSido",
      "addGugun",
      "addDong",
    ]),
    ...mapActions(newsStore, ["getNews"]),
    getGugun() {
      http
        .get(`/aptrest/gugun/${this.selected_sido.sido_Code}`)
        .then(({ data }) => {
          this.guguns = data;
          this.locs = [];
          for (var i = 0; i < this.guguns.length; i++) {
            var temp = { addr: "", addrtext: "" };
            temp.addr = this.selected_sido.sido_Name + " " + this.guguns[i].gugun_Name;
            temp.addrtext = this.guguns[i].gugun_Name;
            this.locs[i] = temp;
          }
          this.addMarkerlocs(this.locs);
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });
    },
    getDong() {
      http
        .get(`/aptrest/dong/${this.selected_gugun.gugun_Code}`)
        .then(({ data }) => {
          this.dongs = data;
          this.locs = [];
          for (var i = 0; i < this.dongs.length; i++) {
            var temp = { addr: "", addrtext: "" };
            temp.addr =
              this.selected_sido.sido_Name +
              " " +
              this.selected_gugun.gugun_Name +
              " " +
              this.dongs[i].dong;
            temp.addrtext = this.dongs[i].dong;
            this.locs[i] = temp;
          }
          this.addMarkerlocs(this.locs);
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });
    },
    mvapt() {
      var senddata = { dong: this.selected_dong.dong, aptname: "" };
      http
        .get(`/aptrest/aptlist`, { params: senddata })
        .then(({ data }) => {
          this.apts = data;
          this.setSidoList(this.sidos);
          this.setGugunList(this.guguns);
          this.setDongList(this.dongs);
          this.addSido(this.selected_sido);
          this.addGugun(this.selected_gugun);
          this.addDong(this.selected_dong);
          this.setAptList(this.apts);
          this.locs = [];
          for (var i = 0; i < this.apts.length; i++) {
            var temp = { addr: "", addrtext: "" };
            temp.addr =
              this.selected_sido.sido_Name +
              " " +
              this.selected_gugun.gugun_Name +
              " " +
              this.selected_dong.dong +
              " " +
              this.apts[i].jibun;
            temp.addrtext = this.apts[i].aptName;
            this.locs[i] = temp;
          }

          this.addMarkerlocs(this.locs);
          this.$router.push("/apt");
        })
        .catch(() => {
          alert("에러가 발생했습니다.");
        });
    },
  },
};
</script>

<style scoped>
.form-group {
  width: 180px;
}
.main-body {
  height: 100%;
  overflow: hidden;
  background-image: url("../assets/back.jpg");
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  position: relative;
}
.brand {
  font-size: 100px;
  font-weight: bold;
  color: white;
  text-shadow: 2px 2px 2px #000;
  font-family: "Anton", sans-serif;
}
a {
  color: black;
}
a:hover {
  color: #17a2b8;
}
</style>
