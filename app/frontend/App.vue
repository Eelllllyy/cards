<template>
  <router-view />
</template>
<script setup>
import {getUser} from "@/modules/home/homeService";
import {useRouter} from 'vue-router';
import {isAuth} from "./modules/login/loginService";

const router = useRouter()

if (window.location.pathname !== '/login') {
  getUser()
}
if (isAuth.value) {
  router.push('/')
}
</script>
<style>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
</style>
