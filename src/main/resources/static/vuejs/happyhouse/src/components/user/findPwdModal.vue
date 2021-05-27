<template>
  <transition name="modal">
    <b-modal
      id="findPwdModal"
      centered
      ref="modal"
      title="비밀번호 찾기"
      header-bg-variant="info"
      header-text-variant="light"
      @show="resetForm"
      @hidden="resetForm"
      @ok="onSubmit"
    >
      <b-form ref="form" class="p-3">
        <b-form-group label="Name : ">
          <b-form-input
            id="name-input"
            name="name-input"
            v-model="info.username"
            v-validate="{ required: true }"
            :state="validateState('name-input')"
            aria-describedby="name-feedback"
            placeholder="Enter Name"
            data-vv-as="Name"
            required
          ></b-form-input>
          <b-form-invalid-feedback id="name-feedback">{{
            veeErrors.first("name-input")
          }}</b-form-invalid-feedback>
        </b-form-group>

        <b-form-group label="User ID : ">
          <b-form-input
            id="userid-input"
            name="userid-input"
            v-model="info.userid"
            v-validate="{ required: true }"
            :state="validateState('userid-input')"
            aria-describedby="userid-feedback"
            placeholder="Enter User ID"
            data-vv-as="User ID"
            required
          ></b-form-input>
          <b-form-invalid-feedback id="userid-feedback">{{
            veeErrors.first("userid-input")
          }}</b-form-invalid-feedback>
        </b-form-group>

        <b-form-group label="User E-mail :">
          <b-form-input
            id="email-input"
            name="email-input"
            type="email"
            v-model="info.email"
            v-validate="{ required: true }"
            :state="validateState('email-input')"
            aria-describedby="email-feedback"
            placeholder="Enter E-mail"
            required
          ></b-form-input>
          <b-form-invalid-feedback id="email-feedback">{{
            veeErrors.first("email-input")
          }}</b-form-invalid-feedback>
        </b-form-group>
      </b-form>
      <template #modal-footer="{ ok, cancel }">
        <b-button variant="success" @click="ok()">Find</b-button>
        <b-button variant="danger" @click="cancel()">Close</b-button>
      </template>
    </b-modal>
  </transition>
</template>

<script>
import { mapActions } from "vuex";
const userStore = "userStore";

export default {
  data() {
    return {
      info: {
        username: "",
        userid: "",
        email: "",
      },
    };
  },
  methods: {
    ...mapActions(userStore, ["findpwd"]),
    validateState(ref) {
      if (this.veeFields[ref] && (this.veeFields[ref].dirty || this.veeFields[ref].validated)) {
        return !this.veeErrors.has(ref);
      }
      return null;
    },
    resetForm() {
      this.info = {
        username: null,
        userid: null,
        email: null,
      };

      this.$nextTick(() => {
        this.$validator.reset();
      });
    },
    onSubmit() {
      this.$validator.validateAll().then((result) => {
        if (!result) {
          return;
        }
        this.findpwd(JSON.stringify(this.info));
      });
    },
  },
};
</script>

<style></style>
