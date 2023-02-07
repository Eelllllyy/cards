import {createRouter, createWebHistory} from 'vue-router';
import {isAuth} from "@/modules/login/loginService";

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: () => import ('@/modules/login/page/loginPage.vue')
  },
  {
    path: '/',
    name: 'Home',
    component: () => import ('@/modules/home/page/homePage.vue')
  },
  {
    path: '/mobile',
    name: 'Mobile',
    component: () => import ('@/modules/noAccess/page/noAccess.vue')
  }
]

const router = createRouter({
  history: createWebHistory(),
  routes,
  scrollBehavior() {
    return {top: 0};
  },
});

router.beforeEach((to, from) => {
  if (from.name === undefined) {
    return
  } else if (to.name === 'Login' && isAuth.value) {
    return {name: 'Home'}
  } else if (to.name !== 'Login' && !isAuth.value) {
    return {name: 'Login'};
  } else return
})

export default router;
