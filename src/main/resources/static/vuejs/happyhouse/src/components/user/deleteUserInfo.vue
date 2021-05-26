
<template>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
					<h5 class="modal-title">글 삭제</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close" @click="closeModal">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>

          <!-- Modal body -->
				<div class="modal-body">
					<p>탈퇴 하시겠습니까?</p>
				</div>

        <div class="modal-footer">
					<button type="button" class="btn btn-primary mr-2" data-dismiss="modal"
						@click="delUser">Yes</button>
					<button type="button" class="btn btn-secondary"
						data-dismiss="modal" @click="closeModal">No</button>
				</div>

        </div>
      </div>
    </div>
  </transition>
</template>

<script>
import { mapActions, mapState } from 'vuex';
const userStore = 'userStore';

export default {
    props: {
            form: {
                type: Object
            }
        
    },
    data() {
        return {
        }
    },
    computed:{
        ...mapState(userStore,['loginUser'])
    },
    methods: {
        ...mapActions(userStore, ['logout','delete','setProfileFlag']),
        closeModal() {
        this.setProfileFlag(0);
        },
        delUser(){
          this.delete(this.form.id);
          this.logout().then(() => this.$router.push('/'));
        }
  }
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
}

.modal-default-button {
  float: right;
}


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