<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <div class="modal-header">
            <h4 class="modal-title">새로운 글 쓰기</h4>
            <button type="button" class="close" data-dismiss="modal" @click="closeModal">
              &times;
            </button>
          </div>

          <!-- Modal body -->
          <div class="modal-body" id="write-modal">
            <form id="write-form" method="post" action="">
              <div class="form-group">
                <label for="title">제목:</label>
                <input
                  type="text"
                  id="title"
                  class="form-control"
                  name="subject"
                  v-model="subject"
                />
                <label for="comment">내용:</label>
                <textarea
                  id="content"
                  class="form-control"
                  rows="5"
                  name="content"
                  v-model="content"
                ></textarea>
              </div>
              <div class="text-right">
                <button
                  type="button"
                  class="btn btn-sm btn-outline-info write-submit"
                  @click="createNotice"
                >
                  작성
                </button>
                <button
                  type="button"
                  class="ml-2 btn btn-sm btn-outline-danger"
                  data-dismiss="modal"
                  @click="closeModal"
                >
                  닫기
                </button>
              </div>
            </form>
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
      subject: "",
      content: "",
    };
  },
  computed: {
    ...mapState(userStore, ["loginUser"]),
    ...mapState(noticeStore, ["notice"]),
  },
  methods: {
    ...mapActions(noticeStore, ["setFlag", "addNotice"]),
    closeModal() {
      this.setFlag(0);
    },
    createNotice() {
      let newNotice = {
        subject: this.subject,
        content: this.content,
      };
      this.addNotice(newNotice);
      this.closeModal();
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
