<template>
  <b-container class="mt-3 mb-5">
    <b-card
      border-variant="info"
      header="Welcome to Q&A"
      header-tag="h2"
      header-bg-variant="info"
      header-text-variant="white"
      align="center"
    >
      <b-row>
        <b-col lg="7"></b-col>
        <b-col lg="2" align="right" class="p-0">
          <b-form-group class="mb-0">
            <b-form-checkbox-group v-model="filterOn" class="mt-2">
              <b-form-checkbox value="title">제목</b-form-checkbox>
              <b-form-checkbox value="writer">작성자</b-form-checkbox>
            </b-form-checkbox-group>
          </b-form-group>
        </b-col>
        <b-col lg="3" class="my-1">
          <b-form-group class="mb-0">
            <b-input-group size="sm">
              <b-form-input
                id="filter-input"
                v-model="filter"
                type="search"
                placeholder="Search"
              ></b-form-input>

              <b-input-group-append>
                <b-button :disabled="!filter" @click="filter = ''">Clear</b-button>
              </b-input-group-append>
            </b-input-group>
          </b-form-group>
        </b-col>
      </b-row>

      <b-table
        hover
        stacked="sm"
        id="my-table"
        :items="items"
        :fields="fields"
        :per-page="perPage"
        :current-page="currentPage"
        :filter="filter"
        :filter-included-fields="filterOn"
        @filtered="onFiltered"
      >
        <template #cell(title)="row">
          <span @click="row.toggleDetails">{{ row.item.title }}</span>
        </template>

        <template #row-details="row">
          <b-card
            border-variant="secondary"
            header-bg-variant="secondary"
            header-text-variant="white"
          >
            <template #header>
              <h5 class="mb-0">{{ row.item.title }}</h5>
              <span class="ml-auto">
                <router-link :to="'/update?no=' + row.item.no">
                  <b-button
                    v-if="row.item.writer === loginId"
                    variant="outline-warning"
                    class="mr-1"
                    size="sm"
                    >수정</b-button
                  >
                </router-link>
                <router-link :to="'/delete?no=' + row.item.no">
                  <b-button v-if="row.item.writer === loginId" variant="outline-danger" size="sm"
                    >삭제</b-button
                  ></router-link
                >
              </span>
            </template>

            <b-card-body>
              <b-card-sub-title class="mb-2" align="right"
                >작성자 : {{ row.item.writer }} | 등록일 :
                {{ getDate(row.item.regtime) }}</b-card-sub-title
              >
              <b-card-text
                ><h5>{{ row.item.content }}</h5></b-card-text
              >
            </b-card-body>

            <comment :question="row.item"></comment>
          </b-card>
        </template>
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
      <div class="text-right" v-if="loginId !== 'admin'">
        <button class="btn btn-outline-warning mt-2" @click="movePage">문의하기</button>
      </div>
    </b-card>
  </b-container>
</template>

<script>
import moment from "moment";
import Comment from "../components/Comment.vue";
import { createNamespacedHelpers } from "vuex";

const userHelper = createNamespacedHelpers("userStore");
const boardHelper = createNamespacedHelpers("boardStore");

export default {
  name: "list",
  components: {
    Comment,
  },
  props: ["question"],
  data: function () {
    return {
      perPage: 10,
      currentPage: 1,
      // Note 'isActive' is left out and will not appear in the rendered table
      fields: [
        {
          key: "no",
          label: "번호",
        },
        {
          key: "title",
          label: "제목",
        },
        {
          key: "writer",
          label: "작성자",
        },
        {
          key: "regtime",
          label: "등록일",
          sortable: true,
          formatter: (value) => {
            return moment(new Date(value)).format("YYYY.MM.DD");
          },
        },
      ],
      filter: null,
      filterOn: [],
      pageIndex: 0,
    };
  },
  created() {
    this.getBoardList();
  },
  computed: {
    ...userHelper.mapState({
      loginId: (state) => state.loginUser.id,
    }),
    ...boardHelper.mapState(["items"]),
    rows() {
      return this.items.length;
    },
  },
  methods: {
    ...boardHelper.mapActions(["getBoardList"]),
    movePage() {
      this.$router.push("/create");
    },
    onFiltered(filteredItems) {
      // Trigger pagination to update the number of buttons/pages due to filtering
      this.totalRows = filteredItems.length;
      this.currentPage = 1;
    },
    getDate(value) {
      return moment(new Date(value)).format("YYYY.MM.DD");
    },
  },
};
</script>

<style scoped>
.board-list {
  background-color: white;
}
</style>
