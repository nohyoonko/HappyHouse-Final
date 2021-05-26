<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="modal-header">
            <h4 class="modal-title" id="articleSubject">{{ notice.subject }}</h4>
            <div class="text-right">
              <!-- 글 작성자와 로그인한 유저가 같으면, 수정/삭제가 보임 -->
              <button
                id="modifybt"
                class="btn btn-outline-info btn-sm"
                @click="modNotice"
                v-if="loginUser.id == 'admin'"
              >
                수정
              </button>
              <button
                id="delbt"
                class="btn btn-sm btn-outline-danger ml-2"
                @click="delNotice"
                v-if="loginUser.id == 'admin'"
              >
                삭제
              </button>
              <button
                type="button"
                class="close"
                @mouseover="cursor = pointer"
                @click="closeModal"
                data-dismiss="modal"
              >
                &times;
              </button>
            </div>
          </div>

          <!-- Modal body -->
          <div class="modal-body">
            <div>
              <table class="table table-hover">
                <tr>
                  <th>글 번호</th>
                  <td id="articleNo">{{ notice.articleno }}</td>
                </tr>
                <tr>
                  <th>작성자</th>
                  <td id="articleUserId">{{ notice.userid }}</td>
                </tr>
                <tr>
                  <th>조회수</th>
                  <td id="articleCount">{{ notice.count }}</td>
                </tr>
                <tr>
                  <th>작성일</th>
                  <td id="articleDate">{{ notice.regtime }}</td>
                </tr>
                <tr>
                  <th>분류</th>
                  <td><span class="badge badge-primary">공지</span></td>
                </tr>
              </table>
            </div>
            <div class="card desc p-3" id="articleContent">{{ notice.content }}</div>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import { mapActions, mapState } from "vuex";
// 토큰 및 사용자 정보를 저장하기 위해 세션 스토리지 사용.
const userStore = "userStore";
const noticeStore = "noticeStore";

export default {
  data() {
    return {
      userid: "",
      userpwd: "",
    };
  },
  computed: {
    ...mapState(userStore, ["loginUser"]),
    ...mapState(noticeStore, ["notice"]),
  },
  methods: {
    ...mapActions(noticeStore, ["setFlag"]),
    closeModal() {
      this.setFlag(0);
    },
    modNotice() {
      this.setFlag(2);
    },
    delNotice() {
      this.setFlag(3);
    },
  },
};
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  width: 30vw;
  min-width: 350px;
  margin: 0px auto;
  padding: 20px 30px;
  background-color: #fff;
  border-radius: 2px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  font-family: Helvetica, Arial, sans-serif;
}

.modal-header h3 {
  margin-top: 0;
  color: #42b983;
}

.modal-body {
  margin: 20px 0;
}

.modal-default-button {
  float: right;
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
