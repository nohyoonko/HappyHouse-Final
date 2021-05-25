<template>
  <div class="text-center">
    <b-spinner
      class="m-5"
      variant="danger"
      style="width: 3rem; height: 3rem"
      label="Large Spinner"
    ></b-spinner>
  </div>
</template>

<script>
import http from '@/util/http-common';
export default {
  name: 'delete',
  created() {
    const storage = window.sessionStorage;
    http
      .delete(`/board/${this.$route.query.no}`, {
        headers: {
          'jwt-auth-token': storage.getItem('jwt-auth-token'),
        },
      })
      .then(({ data }) => {
        let msg = '삭제 처리시 문제가 발생했습니다.';
        if (data === 'success') {
          msg = '삭제가 완료되었습니다.';
        }
        alert(msg);
        this.$router.push('/list');
      })
      .catch(() => {
        alert('삭제 처리시 에러가 발생했습니다.');
      });
  },
};
</script>

<style></style>
