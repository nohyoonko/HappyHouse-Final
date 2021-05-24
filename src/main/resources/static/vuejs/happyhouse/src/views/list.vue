<template>
  <b-container>
    <h2 class="text-center">Q&A</h2>
    <div v-if="items.length" class="board-list">
      <table class="table table-bordered table-condensed">
        <colgroup>
          <col :style="{ width: '5%' }" />
          <col :style="{ width: '50%' }" />
          <col :style="{ width: '10%' }" />
          <col :style="{ width: '25%' }" />
        </colgroup>
        <tr>
          <th>번호</th>
          <th>제목</th>
          <th>작성자</th>
          <th>날짜</th>
        </tr>
        <list-row
          v-for="(item, index) in items"
          :key="`${index}_items`"
          :no="item.no"
          :title="item.title"
          :writer="item.writer"
          :regtime="item.regtime"
        />
      </table>
    </div>
    <div v-else>글이 없습니다.</div>
    <div class="text-right">
      <button class="btn btn-primary" @click="movePage">등록</button>
    </div>
  </b-container>
</template>

<script>
import http from '@/util/http-common';
import ListRow from '@/components/Row.vue';
export default {
  name: 'list',
  components: {
    ListRow,
  },
  data: function () {
    return {
      items: [],
    };
  },
  created() {
    const storage = window.sessionStorage;
    http
      .get('/board',
      {
                headers: {
                    "jwt-auth-token": storage.getItem("jwt-auth-token")
                }
      })
      .then(({ data }) => {
        this.items = data;
      })
      .catch(() => {
        alert('에러가 발생했습니다.');
      });
  },
  methods: {
    movePage() {
      this.$router.push('/create');
    },
  },
};
</script>

<style>
.board-list{
  background-color: white;
}
</style>
