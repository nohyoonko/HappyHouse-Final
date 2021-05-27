<template>
  <section>
    <div class="container mt-3">
      <div class="jumbotron m-3 p-5">
        <div class="row">
          <div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
            <img
              src="data:image/svg+xml;base64,PHN2ZyBoZWlnaHQ9IjUxMiIgdmlld0JveD0iMCAwIDUxMiA1MTIiIHdpZHRoPSI1MTIiIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyI+PGcgaWQ9ImZsYXQiPjxwYXRoIGQ9Im0yOTYgMzQ0IDEyNi43ODYgNzMuNGE2MCA2MCAwIDAgMSAyOS4zMzQgNDMuNDRsMy44OCAyNy4xNmgtNDAwbDMuODgtMjcuMTU4YTYwIDYwIDAgMCAxIDI5LjMzNC00My40NDJsMTI2Ljc4Ni03My40IiBmaWxsPSIjZmZiM2IzIi8+PHBhdGggZD0ibTMxNy4zMjQgNDQ2LjIxNiAyNi42NzYgMTcuNzg0LTE2IDI0aC0yNHYtMjV6IiBmaWxsPSIjZmFhNmIyIi8+PHBhdGggZD0ibTIxNiAzNDRoLTMyLjhhNDUuNiA0NS42IDAgMCAxIC0yNy4zNTgtOS4xMTkgNDUuNiA0NS42IDAgMCAxIC0xOC4xMjktMzkuNjIzbDExLjU2LTE2Ny4xMWE4Ni4wOSA4Ni4wOSAwIDAgMSAyNS4wMS01NC45MzQgODYuMDgxIDg2LjA4MSAwIDAgMSA2MS44NjQtMjUuMjE0cTE1LjQyNi4xNzcgMzAuODUgMGE1Ny44ODcgNTcuODg3IDAgMCAxIDUyLjUgMzIgNjEuMDcyIDYxLjA3MiAwIDAgMSAzNS4zMTMgMzAuNjI3bC4yMDguNDE2YTYxLjA2NyA2MS4wNjcgMCAwIDEgNS44NjIgMTguODc1bDE3Ljg5NCAxMjguMjY2YTYwLjc2MiA2MC43NjIgMCAwIDEgLTI2LjQ3NCA1OC45NWwtLjU1MS4zNjdhNjIuMTI1IDYyLjEyNSAwIDAgMSAtMzQuNTM4IDEwLjQ5OWMtMTAuMzg1IDAtMjEuMjExIDAtMjEuMjExIDB6IiBmaWxsPSIjNjgzYjBkIi8+PHBhdGggZD0ibTIxNS40OTYgMzEydjMybC04IDI0djEyMGg5NnYtMTIwbC04LTI0di0zMnoiIGZpbGw9IiNmZGM5YTYiLz48cGF0aCBkPSJtMjk1LjUgMzEydjE4LjMzYTY0Ljc4OCA2NC43ODggMCAwIDEgLTM5LjczIDEzLjY3aC0xLjE2YTYyLjU2OCA2Mi41NjggMCAwIDEgLTM5LjExLTEzLjY1di0xOC4zNXoiIGZpbGw9IiNmZGM5YTYiLz48cGF0aCBkPSJtMjk1LjUgMzEydjE4LjMzYTY0Ljc4OCA2NC43ODggMCAwIDEgLTM5LjczIDEzLjY3aC0xLjE2YTYyLjU2OCA2Mi41NjggMCAwIDEgLTM5LjExLTEzLjY1di0xOC4zNXoiIGZpbGw9IiNlNmFmODkiLz48cGF0aCBkPSJtOTYgNDg4di0zMmE4IDggMCAwIDEgMTYgMHYzMnoiIGZpbGw9IiNmYWE2YjIiLz48cGF0aCBkPSJtNDAwIDQ4OHYtMzJhOCA4IDAgMCAxIDE2IDB2MzJ6IiBmaWxsPSIjZmFhNmIyIi8+PHBhdGggZD0ibTE3NS41IDE3NmgtMTEuMDZhMjAuOTQ0IDIwLjk0NCAwIDAgMCAtMjAuOTQgMjAuOTQ0djE0LjExMmEyMC45NDQgMjAuOTQ0IDAgMCAwIDIuMjExIDkuMzY2IDIwLjk0NCAyMC45NDQgMCAwIDAgMTguNzI5IDExLjU3OGgxNS4wNnoiIGZpbGw9IiNmZGM5YTYiLz48cGF0aCBkPSJtMzM1LjUgMTc2aDExLjA1NWEyMC45NDQgMjAuOTQ0IDAgMCAxIDIwLjk0NSAyMC45NDR2MTQuMTEyYTIwLjk0NCAyMC45NDQgMCAwIDEgLTIuMjExIDkuMzY2IDIwLjk0NCAyMC45NDQgMCAwIDEgLTE4LjczOCAxMS41NzhoLTE1LjA1MXoiIGZpbGw9IiNmZGM5YTYiLz48cGF0aCBkPSJtMjcyLjQxMiA0MDguMDkxYTggOCAwIDAgMSAtNy4xNDktMTEuNTc5bDgtMTZhOCA4IDAgMSAxIDE0LjMxIDcuMTU1bC04IDE2YTggOCAwIDAgMSAtNy4xNjEgNC40MjR6IiBmaWxsPSIjZTZhZjg5Ii8+PHBhdGggZD0ibTI0MC4wMDYgNDA4LjA5MWE4IDggMCAwIDEgLTcuMTYxLTQuNDI0bC04LTE2YTggOCAwIDEgMSAxNC4zMS03LjE1NWw4IDE2YTggOCAwIDAgMSAtNy4xNDkgMTEuNTc5eiIgZmlsbD0iI2U2YWY4OSIvPjxwYXRoIGQ9Im0xOTQuMDA3IDQ0Ni42NjItMjYuMDA3IDE3LjMzOCAxNiAyNGgyNHYtMjV6IiBmaWxsPSIjZmFhNmIyIi8+PHBhdGggZD0ibTIxNS40OTMgMzIwLTQwLjc5MyA0NS44ODhhNDIgNDIgMCAwIDAgLTEuNzYyIDUzLjY4OWwzNC41NTUgNDQuNDIzdi05Nmw4LTI0eiIgZmlsbD0iI2ZhYTZiMiIvPjxwYXRoIGQ9Im0yOTUuNDkzIDMyMCA0MC43ODkgNDUuODg4YTQyIDQyIDAgMCAxIDEuNzYyIDUzLjY4OWwtMzQuNTUxIDQ0LjQyM3YtOTZsLTgtMjR6IiBmaWxsPSIjZmFhNmIyIi8+PHBhdGggZD0ibTMwMy41IDQyNGExMDcuMzMzIDEwNy4zMzMgMCAwIDEgLTk2IDBsLjUgNjRoOTZ6IiBmaWxsPSIjZWFlYWU4Ii8+PHBhdGggZD0ibTI1NS43NzUgMzI4LjA1M2gtMS4xNjlhNjIuNjM3IDYyLjYzNyAwIDAgMSAtNTUuOTY3LTM0LjM0M2wtLjUxNC0xLjAxNmEyMDkuMjg0IDIwOS4yODQgMCAwIDEgLTIyLjYzNi05NC42ODJjLjAxMS0xOS44MjUuMDExLTM4LjAxMi4wMTEtMzguMDEyYTE1Ni4zMDcgMTU2LjMwNyAwIDAgMCA3NS45MTEtMTkuNjcxbDM2LjU4OS0yMC4zMjkgNDcuNSA1NnYyMy4yMThhMjA5LjAyIDIwOS4wMiAwIDAgMSAtMjEuNiA5Mi41MjRsLS4wOTQuMTg5YTY0LjgxNCA2NC44MTQgMCAwIDEgLTU4LjAzMSAzNi4xMjJ6IiBmaWxsPSIjZmRjOWE2Ii8+PGcgZmlsbD0iIzY4M2IwZCI+PHBhdGggZD0ibTMwMy41IDE4NGgtMjRhOCA4IDAgMCAxIDAtMTZoMjRhOCA4IDAgMCAxIDAgMTZ6Ii8+PGNpcmNsZSBjeD0iMjg5LjQ5NiIgY3k9IjIwMiIgcj0iMTEiLz48cGF0aCBkPSJtMjMxLjUgMTg0aC0yNGE4IDggMCAxIDEgMC0xNmgyNGE4IDggMCAwIDEgMCAxNnoiLz48Y2lyY2xlIGN4PSIyMjEuNDk2IiBjeT0iMjAyIiByPSIxMSIvPjwvZz48cGF0aCBkPSJtMjU1LjUgMjgzLjg2YTQyLjg0MSA0Mi44NDEgMCAwIDEgLTE4LjY4NC00LjI2OGwtLjgxMy0uMzk0YTggOCAwIDEgMSA2Ljk4Mi0xNC40bC44MTIuMzkzYTI2Ljk3NiAyNi45NzYgMCAwIDAgMjQuMDI3LS4zIDggOCAwIDAgMSA3LjM0IDE0LjIxNiA0Mi44ODQgNDIuODg0IDAgMCAxIC0xOS42NjQgNC43NTN6IiBmaWxsPSIjZTZhZjg5Ii8+PHBhdGggZD0ibTI2NCAyNDhoLTE2YTggOCAwIDAgMSAtOC04di0xNmE4IDggMCAwIDEgMTYgMHY4aDhhOCA4IDAgMCAxIDAgMTZ6IiBmaWxsPSIjZTZhZjg5Ii8+PC9nPjwvc3ZnPg=="
              stacked
            />
          </div>
          <div class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
            <div class="container">
              <h2>{{ loginUser.name }}</h2>
            </div>
            <hr />
            <ul class="container details">
              <li class="m-3">
                <h5>
                  <span class="h5"
                    ><b-icon-telephone-fill variant="info" class="mr-2"></b-icon-telephone-fill
                  ></span>
                  번호 : {{ loginUser.phone }}
                </h5>
              </li>
              <li class="m-3">
                <h5>
                  <span class="h5"
                    ><b-icon-mailbox2 variant="info" class="mr-2"></b-icon-mailbox2
                  ></span>
                  이메일 : {{ loginUser.email }}
                </h5>
              </li>
              <li class="m-3">
                <h5>
                  <span class="h5"
                    ><b-icon-house-fill variant="info" class="mr-2"></b-icon-house-fill
                  ></span>
                  주소 : {{ loginUser.address }}
                </h5>
              </li>
            </ul>
          </div>
          <div class="d-flex col-11 justify-content-end">
            <button
              type="button"
              class="btn btn-outline-warning"
              data-toggle="modal"
              data-target="#reModal"
              @click="modUserInfo"
            >
              수정
            </button>
            <div class="p-2"></div>
            <button
              type="button"
              class="btn btn-outline-danger"
              data-toggle="modal"
              data-target="#delModal"
              @click="delUserInfo"
            >
              탈퇴
            </button>
          </div>
        </div>
      </div>
    </div>

    <modify-modal v-if="profileFlag == 1" :form="loginUser"></modify-modal>
    <delete-modal v-if="profileFlag == 2" :form="loginUser"></delete-modal>
  </section>
</template>

<script>
import { mapActions, mapState } from "vuex";
import ModifyModal from "@/components/user/modifyUserInfo";
import DeleteModal from "@/components/user/deleteUserInfo";
const userStore = "userStore";
export default {
  components: {
    ModifyModal,
    DeleteModal,
  },
  computed: {
    ...mapState(userStore, ["loginUser", "profileFlag"]),
  },
  methods: {
    ...mapActions(userStore, ["setProfileFlag"]),
    modUserInfo() {
      this.setProfileFlag(1);
    },
    delUserInfo() {
      this.setProfileFlag(2);
    },
  },
};
</script>

<style></style>
