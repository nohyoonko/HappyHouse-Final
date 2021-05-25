import Vue from 'vue';
import VueRouter from 'vue-router';
import Index from '@/views/index.vue';
import List from '@/views/list.vue';
import Create from '@/views/create.vue';
import Read from '@/views/read.vue';
import Update from '@/views/update.vue';
import Delete from '@/views/delete.vue';
import NoticeList from '@/views/notice/list.vue';
import Apt from '@/views/Apt.vue';
import AddInterest from '@/views/interest/addInterest.vue';
import ShowInterest from '@/views/interest/showInterest.vue';

Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'index',
    component: Index,
  },
  {
    path: '/list',
    name: 'list',
    component: List,
  },
  {
    path: '/create',
    name: 'create',
    component: Create,
  },
  {
    path: '/read',
    name: 'read',
    component: Read,
  },
  {
    path: '/update',
    name: 'update',
    component: Update,
  },
  {
    path: '/delete',
    name: 'delete',
    component: Delete,
  },
  {
    path: '/apt',
    name: 'apt',
    component: Apt,
  },
  {
    path: '/showInterest',
    name: 'ShowInterest',
    component: ShowInterest,
  },
  {
    path: '/addInterest',
    name: 'addInterest',
    component: AddInterest,
  },
  {
    path: '/notice',
    name: 'notice',
    component: NoticeList,
  },
];

const router = new VueRouter({
  mode: 'history',
  routes,
});

export default router;
