<template>
  <section>
		<div class="container mt-3">
			<div class="jumbotron">
				<div class="row">
					<div class="col-md-4 col-xs-12 col-sm-6 col-lg-4">
						<img
							src="https://www.svgimages.com/svg-image/s5/man-passportsize-silhouette-icon-256x256.png"
							alt="stack photo" class="img" />
					</div>
					<div class="col-md-8 col-xs-12 col-sm-6 col-lg-8">
						<div class="container" style="border-bottom: 1px solid black">
							<h2>{{loginUser.name}}</h2>
						</div>
						<hr />
						<ul class="container details">
							<li>
								<p>
									<span class="glyphicon glyphicon-earphone one"
										style="width: 50px"></span>{{loginUser.phone}}
								</p>
							</li>
							<li>
								<p>
									<span class="glyphicon glyphicon-envelope one"
										style="width: 50px"></span>{{loginUser.email}}
								</p>
							</li>
							<li>
								<p>
									<span class="glyphicon glyphicon-envelope one"
										style="width: 50px"></span>{{loginUser.address}}
								</p>
							</li>
						</ul>
					</div>
					<div class="d-flex col-11 m-3 justify-content-end">
						<button type="button" class="btn btn-info" data-toggle="modal"
							data-target="#reModal" @click="modUserInfo">수정</button>
						<div class="p-2"></div>
						<button type="button" class="btn btn-danger" data-toggle="modal"
							data-target="#delModal"  @click="delUserInfo">탈퇴</button>
					</div>
				</div>
			</div>
		</div>

    <modify-modal v-if="profileFlag == 1" :form="loginUser"></modify-modal>
    <delete-modal v-if="profileFlag == 2" :form="loginUser"></delete-modal>
	</section>
</template>

<script>
import { mapActions, mapState } from 'vuex';
import ModifyModal from '@/components/user/modifyUserInfo';
import DeleteModal from '@/components/user/deleteUserInfo';
const userStore = 'userStore';
export default {
components:{
  ModifyModal,
  DeleteModal,

},
computed :{
  ...mapState(userStore,['loginUser','profileFlag']),
},
methods: {
  ...mapActions(userStore,['setProfileFlag']),
  modUserInfo() {
    this.setProfileFlag(1);
  },
  delUserInfo(){
    this.setProfileFlag(2);
  },
},
}
</script>

<style>

</style>