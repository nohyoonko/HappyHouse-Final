<template>
  <tr @click="noticeDetail">
    <td>{{ notice.articleno }}</td>
    <td>{{notice.subject}}</td>
    <td>{{notice.wuserid}}</td>
    <td>{{ notice.count }}</td>
    <td>{{ getFormatDate(notice.regtime) }}</td>
    <td></td>
  </tr>
  
</template>

<script>
import moment from 'moment';
import { mapActions, mapState } from 'vuex';
const noticeStore = 'noticeStore';
export default {
  name: 'noticerow',
  props: {
    notice: {type : Object},
  },
  computed:{
    ...mapState(noticeStore, ['detailflag'])
  },
  methods: {
    ...mapActions(noticeStore, ['getNotices','getNotice','setFlag']),
    getFormatDate(regtime) {
      return moment(new Date(regtime)).format('YYYY.MM.DD');
    },
    noticeDetail() {
      this.getNotice(this.notice.articleno);
      this.openModal();
    },
    openModal() {
      console.log("opening")
      this.setFlag(1);
    }

  },
};
</script>
