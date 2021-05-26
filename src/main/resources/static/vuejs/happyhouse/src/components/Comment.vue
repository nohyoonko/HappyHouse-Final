<template>
  <b-card-body body-bg-variant="light">
    <div v-if="this.comment != null && this.comment != ''">
      <p class="mb-3 text-right">
        관리자 : {{ this.comment.userid }} | 답변일 : {{ getDate(this.comment.time) }}
      </p>
      <h5><b-icon-reply-fill></b-icon-reply-fill> {{ this.comment.answer }}</h5>
      <p v-if="loginId === 'admin'" class="mb-0 text-right">
        <b-button variant="outline-danger" size="sm" @click="callDelete">삭제</b-button>
      </p>
    </div>
    <div v-else>
      <span v-if="this.loginId !== 'admin'">등록된 답변이 없습니다.</span>
      <b-row v-if="this.loginId === 'admin'">
        <b-col cols="10">
          <b-form-group>
            <b-form-textarea
              id="textarea-no-resize"
              v-model="commentInput"
              placeholder="답변을 등록해주세요."
              no-resize
            ></b-form-textarea>
          </b-form-group>
        </b-col>
        <b-col cols="2" align="center">
          <b-button pill variant="info" size="lg" @click="sendComment(question.no)">등록</b-button>
        </b-col>
      </b-row>
    </div>
  </b-card-body>
</template>

<script>
import moment from "moment";
import { createNamespacedHelpers } from "vuex";

const userHelper = createNamespacedHelpers("userStore");
const commentHelper = createNamespacedHelpers("commentStore");

export default {
  data() {
    return {
      commentInput: null,
      question: null,
    };
  },
  created() {
    this.question = this.$attrs.question;
    this.setComment(this.question.no);
  },
  computed: {
    ...userHelper.mapState({
      loginId: (state) => state.loginUser.id,
    }),
    ...commentHelper.mapState(["comment"]),
  },
  methods: {
    ...commentHelper.mapActions(["getComment", "insertComment", "deleteComment"]),
    setComment(no) {
      this.getComment(no);
    },
    sendComment(no) {
      const param = {
        userid: this.loginId,
        articleno: no,
        answer: this.commentInput,
      };
      this.insertComment(param);
      this.$router.go();
    },
    callDelete() {
      this.deleteComment(this.comment.commentno);
      this.$router.go();
    },
    getDate(value) {
      return moment(new Date(value)).format("YYYY.MM.DD");
    },
  },
};
</script>

<style scoped></style>
