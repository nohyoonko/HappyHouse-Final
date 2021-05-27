<template>
  <transition name="modal">
    <!-- 회원가입 모달 -->
    <!-- The Modal -->
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <!-- Modal Header -->
          <div class="modal-header">
            <slot name="header">
              <h2 class="modal-title">회원가입</h2>
            </slot>
          </div>
          <b-form @submit.stop.prevent="onSubmit">
            <!-- Modal body -->
            <div class="modal-body">
              <slot name="body">
                <b-form-group id="userid" label="User ID" label-for="userid-input">
                  <b-form-input
                    id="userid-input"
                    name="userid-input"
                    v-model="form.userid"
                    v-validate="{ required: true, max: 10 }"
                    :state="validateState('userid-input')"
                    aria-describedby="userid-input-feedback"
                    data-vv-as="ID"
                    placeholder="Enter ID"
                  ></b-form-input>

                  <b-form-invalid-feedback id="userid-input-feedback">{{
                    veeErrors.first("userid-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>

                <b-form-group id="userpwd" label="User Password" label-for="userpwd-input">
                  <b-form-input
                    id="userpwd-input"
                    name="userpwd-input"
                    v-model="form.userpwd"
                    type="password"
                    v-validate="{ required: true, min: 5 }"
                    :state="validateState('userpwd-input')"
                    aria-describedby="userpwd-input-feedback"
                    data-vv-as="Password"
                    placeholder="Enter Password"
                  ></b-form-input>

                  <b-form-invalid-feedback id="userpwd-input-feedback">{{
                    veeErrors.first("userpwd-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>

                <!-- <b-form-group id="userpwd-confirm" label="User Password Confirm" label-for="userpwd-confirm">
                                <b-form-input
                                id="userpwd-confirm"
                                name="userpwd-confirm"
                                type="password"
                                v-validate="{ required: true, confirmed: userpwd }"
                                :state="validateState('userpwd-confirm')"
                                aria-describedby="userpwd-confirm-feedback"
                                data-vv-as="Password Confirm"
                                placeholder="Enter Password, Again"
                                ></b-form-input>

                                <b-form-invalid-feedback id="userpwd-confirm-feedback">{{ veeErrors.first('userpwd-confirm') }}</b-form-invalid-feedback>
                            </b-form-group> -->

                <b-form-group id="name" label="User Name" label-for="name-input">
                  <b-form-input
                    id="name-input"
                    name="name-input"
                    v-model="form.username"
                    v-validate="{ required: true }"
                    :state="validateState('name-input')"
                    aria-describedby="name-input-feedback"
                    data-vv-as="Name"
                    placeholder="Enter Name"
                  ></b-form-input>

                  <b-form-invalid-feedback id="name-input-feedback">{{
                    veeErrors.first("name-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>

                <b-form-group id="phone" label="User Phone" label-for="phone-input">
                  <b-form-input
                    id="phone-input"
                    name="phone-input"
                    type="tel"
                    v-model="form.phone"
                    v-validate="{ required: true }"
                    :state="validateState('phone-input')"
                    aria-describedby="phone-input-feedback"
                    data-vv-as="Phone"
                    placeholder="010-1234-5678"
                  ></b-form-input>

                  <b-form-invalid-feedback id="phone-input-feedback">{{
                    veeErrors.first("phone-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>

                <b-form-group id="email" label="User E-mail" label-for="email-input">
                  <b-form-input
                    id="email-input"
                    name="email-input"
                    v-model="form.email"
                    v-validate="{ required: true, email: true }"
                    :state="validateState('email-input')"
                    aria-describedby="email-input-feedback"
                    data-vv-as="E-mail"
                    placeholder="example@example.com"
                  ></b-form-input>

                  <b-form-invalid-feedback id="email-input-feedback">{{
                    veeErrors.first("email-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>

                <b-form-group id="address" label="User Address" label-for="address-input">
                  <b-form-input
                    id="address-input"
                    name="address-input"
                    v-model="form.address"
                    v-validate="{ required: true }"
                    :state="validateState('address-input')"
                    aria-describedby="address-input-feedback"
                    data-vv-as="Address"
                    placeholder="시/구/동"
                  ></b-form-input>

                  <b-form-invalid-feedback id="address-input-feedback">{{
                    veeErrors.first("address-input")
                  }}</b-form-invalid-feedback>
                </b-form-group>
              </slot>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
              <slot name="footer">
                <b-button type="submit" variant="success">Join</b-button>
                <b-button class="ml-2" variant="danger" @click="resetForm()">Reset</b-button>
                <b-button type="button" variant="secondary" @click="$emit('close')">Close</b-button>
              </slot>
            </div>
          </b-form>
        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import { mapActions } from "vuex";
const userStore = "userStore";

export default {
  data() {
    return {
      form: {
        userid: null,
        userpwd: null,
        username: null,
        email: null,
        phone: null,
        address: null,
      },
    };
  },
  methods: {
    ...mapActions(userStore, ["join"]),
    validateState(ref) {
      if (this.veeFields[ref] && (this.veeFields[ref].dirty || this.veeFields[ref].validated)) {
        return !this.veeErrors.has(ref);
      }
      return null;
    },
    resetForm() {
      this.form = {
        userid: null,
        userpwd: null,
        name: null,
        email: null,
        phone: null,
        address: null,
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
        this.join(this.form);
        this.$emit("close");
      });
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
  overflow-y: initial !important;
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
  height: 60vh;
  overflow-y: auto;
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
