<template>
  <b-container class="mt-3">
    <b-card
      border-variant="info"
      header="공지사항"
      header-tag="h2"
      header-bg-variant="info"
      header-text-variant="white"
      align="center"
    >
      <div class="mt-3 mb-3">
        <form id="searchform" class="form-inline justify-content-end" action="">
          <input type="hidden" name="act" value="list" />
          <select class="form-control mr-1" name="key" id="key" v-model="selField">
            <option value="articleno">글번호</option>
            <option value="subject">제목</option>
          </select>
          <input
            class="form-control mr-sm-2"
            type="text"
            name="word"
            id="word"
            placeholder="Search"
            v-model="word"
          />
          <b-button variant="warning" class="text-white" type="button" @click="searchArticle">
            Search
          </b-button>
        </form>
      </div>
      <!--테이블 시작-->
      <b-table
        stacked="sm"
        id="my-table"
        @row-clicked="noticeDetail"
        :fields="fields"
        :items="notices"
        :per-page="perPage"
        :current-page="currentPage"
      ></b-table>
      <!--테이블 끝-->
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

      <div class="dropup mt-5" v-if="loginUser.id == 'admin'">
        <div class="text-right">
          <!-- <button type="button" class="btn" data-toggle="dropdown"><i class="fas fa-plus-circle w3-text-red"></i></button> -->
          <b-button
            type="button"
            fill
            variant="warning"
            data-toggle="dropdown"
            style="border-radius: 35px; width: 50px; height: 50px; font-size: 25px"
            @click="createNotice"
          >
            <span style="color: white; font-size: 30px">+</span>
          </b-button>
          <div class="dropdown-menu">
            <a class="dropdown-item" href="#" data-toggle="modal" data-target="#myModal">글쓰기</a>
          </div>
        </div>
      </div>

      <detail-modal v-if="flag == 1" @close="closeModal"></detail-modal>
      <modify-modal v-if="flag == 2" @close="closeModal"></modify-modal>
      <delete-modal v-if="flag == 3" @close="closeModal"></delete-modal>
      <create-modal v-if="flag == 4" @close="closeModal"></create-modal>
    </b-card>
  </b-container>
</template>

<script>
import detailModal from "@/components/notice/DetailModal.vue";
import ModifyModal from "@/components/notice/ModifyModal.vue";
import DeleteModal from "@/components/notice/DeleteModal.vue";
import CreateModal from "@/components/notice/CreateModal.vue";
import { mapActions, mapState } from "vuex";
const noticeStore = "noticeStore";
const userStore = "userStore";
export default {
  name: "noticelist",
  components: {
    detailModal,
    ModifyModal,
    DeleteModal,
    CreateModal,
  },
  data: function () {
    return {
      perPage: 10,
      currentPage: 1,
      items: [],
      fields: [
        { key: "articleno", label: "글번호" },
        { key: "subject", label: "제목" },
        { key: "userid", label: "작성자" },
        { key: "count", label: "조회수" },
        { key: "regtime", label: "작성일" },
        { key: "kind", label: "분류" },
      ],
      showDetailModal: false,
      selField: "articleno",
      word: "",
      pageIndex: 0,
      noticeItems: [],
    };
  },
  computed: {
    ...mapState(noticeStore, ["flag"]),
    ...mapState(userStore, ["loginUser"]),
    notices: {
      get() {
        return this.$store.getters["noticeStore/get_notices"];
      },
      set(value) {
        this.$store.commit("noticeStore/SET_NOTICES", value);
      },
    },
    rows() {
      return this.notices.length;
    },
  },
  watch: {
    flag: function () {
      this.getList();
      if (this.flag == 0) this.$router.go();
    },
  },
  created: function () {
    this.getList(null);
  },
  methods: {
    ...mapActions(noticeStore, ["getNotices", "getNotice", "setFlag"]),
    getList() {
      let searchnotice = {
        key: this.selField,
        word: this.word,
      };
      this.getNotices(searchnotice);
    },
    closeModal() {
      this.setFlag(0);
    },
    createNotice() {
      this.setFlag(4);
    },
    noticeDetail(item) {
      this.getNotice(item.articleno);
      this.openModal();
    },
    openModal() {
      this.setFlag(1);
    },
    searchArticle() {
      let searchnotice = {
        key: this.selField,
        word: this.word,
      };
      this.getNotices(searchnotice);
    },
  },
};
</script>

<style>
.board-list {
  background-color: white;
}
</style>
