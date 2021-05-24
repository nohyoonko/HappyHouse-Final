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
                
                <!-- Modal body -->
                <div class="modal-body">
                    <slot name="body">
                        <form id="joinform" class="was-validated" method="post">
                        <div class="form-group">
                            <label>User ID (* 20자 이내)</label> <input type="text"
                                class="form-control under20" id="ip_usr" name="userid" placeholder="Enter ID"
                                required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User Password (* 20자 이내)</label> <input type="password"
                                class="form-control under20" id="ip_pwd" name="userpwd"
                                placeholder="Enter Password" required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User Password Confirm (* 20자 이내)</label> <input
                                type="password" class="form-control under20" id="ip_pwdCon" name="userPwdCon"
                                placeholder="Enter Password" required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User Name (* 10자 이내)</label> <input type="text"
                                class="form-control under10" id="name" name="username" placeholder="Name"
                                required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User CellPhone (* 20자 이내)</label> <input type="tel"
                                class="form-control under20" id="tel" name="phone" placeholder="010-1234-5678"
                                required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User E-mail (* 50자 이내)</label> <input type="email"
                                class="form-control under50" id="email" name="email"
                                placeholder="example@example.com" required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        <div class="form-group">
                            <label>User Address (*)</label> <input type="text"
                                class="form-control" id="address" name="address" placeholder="시/구/동" required>
                            <div class="valid-feedback">Valid.</div>
                            <div class="invalid-feedback">Please fill out this field.</div>
                        </div>
                        </form>
                    </slot>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <slot name="footer">
                        <button type="button" class="btn btn-success" id="joinBt">Join</button>
                        <button type="button" class="btn btn-secondary" @click="$emit('close')">Close</button>
                    </slot>
                </div>
            </div>
        </div>
    </div>
</transition>
</template>

<script>
import Vue from 'vue';
import { ValidationProvider, extend } from 'vee-validate';

// Add a rule.
extend('secret', {
  validate: value => value === 'example',
  message: 'This is not the magic word'
});

// Register it globally
Vue.component('ValidationProvider', ValidationProvider);

export default {
    data() {
        return {
            
        }
    },
}
</script>

<style scoped>
.modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, .5);
  display: table;
  transition: opacity .3s ease;
  overflow-y: initial !important
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
  box-shadow: 0 2px 8px rgba(0, 0, 0, .33);
  transition: all .3s ease;
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