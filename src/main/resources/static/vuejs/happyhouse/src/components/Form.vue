<template>
  <b-container class="mt-3">
    <b-card border-variant="warning" header-bg-variant="warning">
      <template #header>
        <h4 class="mb-0">문의하기</h4>
      </template>
      <b-card-body>
        <b-card-sub-title align="right">작성자: {{ loginId }}</b-card-sub-title>
        <div class="form-group">
          <label for="title">제목</label>
          <input
            type="text"
            class="form-control"
            id="title"
            ref="title"
            placeholder="제목을 입력하세요"
            v-model="title"
          />
        </div>
        <div class="form-group">
          <label for="content">내용</label>
          <b-form-textarea
            type="text"
            class="form-control"
            id="contnet"
            ref="content"
            rows="5"
            placeholder="내용을 입력하세요"
            v-model="content"
            no-resize
          ></b-form-textarea>
        </div>
        <div class="text-right">
          <button
            class="btn btn-outline-success mr-2"
            v-if="type == 'create'"
            @click="checkHandler"
          >
            등록
          </button>
          <button class="btn btn-outline-warning mr-2" v-else @click="checkHandler">수정</button>
          <button class="btn btn-outline-secondary" @click="moveList">목록</button>
        </div>
      </b-card-body>
    </b-card>
  </b-container>
</template>

<script>
import http from '@/util/http-common';
import { createNamespacedHelpers } from 'vuex';

const userHelper = createNamespacedHelpers('userStore');
const storage = window.sessionStorage;

export default {
  name: 'board-Form',
  props: {
    type: { type: String },
  },
  data: function () {
    return {
      no: '',
      regtime: '',
      writer: '',
      title: '',
      content: '',
    };
  },
  computed: {
    ...userHelper.mapState({
      loginId: (state) => state.loginUser.id,
    }),
  },
  methods: {
    checkHandler() {
      let err = true;
      let msg = '';
      err && !this.title && ((msg = '제목 입력해주세요'), (err = false), this.$refs.title.focus());
      err &&
        !this.content &&
        ((msg = '내용 입력해주세요'), (err = false), this.$refs.content.focus());

      if (!err) alert(msg);
      else this.type == 'create' ? this.createHandler() : this.updateHandler();
    },
    createHandler() {
      http
        .post(
          '/board',
          {
            writer: this.loginId,
            title: this.title,
            content: this.content,
          },
          {
            headers: {
              'jwt-auth-token': storage.getItem('jwt-auth-token'),
            },
          }
        )
        .then(({ data }) => {
          let msg = '등록 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '등록이 완료되었습니다.';
          }
          alert(msg);
          this.moveList();
        })
        .catch(() => {
          alert('등록 처리시 에러가 발생했습니다.');
        });
    },
    updateHandler() {
      http
        .put(
          `/board/${this.no}`,
          {
            no: this.no,
            regtime: this.regtime,
            writer: this.writer,
            title: this.title,
            content: this.content,
          },
          {
            headers: {
              'jwt-auth-token': storage.getItem('jwt-auth-token'),
            },
          }
        )
        .then(({ data }) => {
          let msg = '수정 처리시 문제가 발생했습니다.';
          if (data === 'success') {
            msg = '수정이 완료되었습니다.';
          }
          alert(msg);
          this.moveList();
        })
        .catch(() => {
          alert('수정 처리시 에러가 발생했습니다.');
        });
    },
    moveList() {
      this.$router.push('/list');
    },
  },
  created() {
    if (this.type === 'update') {
      http
        .get(`/board/${this.$route.query.no}`, {
          headers: {
            'jwt-auth-token': storage.getItem('jwt-auth-token'),
          },
        })
        .then(({ data }) => {
          this.no = data.no;
          this.regtime = data.regtime;
          this.writer = data.writer;
          this.title = data.title;
          this.content = data.content;
        })
        .catch(() => {
          alert('에러가 발생했습니다.');
        });
    }
  },
};
</script>

<style scoped></style>
