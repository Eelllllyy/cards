import {ref} from 'vue'
import axios from 'axios';
import VueCookies from 'vue-cookies'
import {isAuth} from '@/modules/login/loginService';

export const cards = ref([])
export const passed= ref(0)
export const currentId = ref(null)
export const noAccess = ref(false)
export const getCards = async () => {
  try {
    const response = await axios.get('/api/users', {
      headers: {
        Authorization: VueCookies.get('token'),
      },
    })
    cards.value = response.data
  } catch (e) {
    console.error(e)
  }
}
export const getUser = async (router) => {
  try {
    const token = VueCookies.get('token')
    if (token) {
      const {data} = await axios.get('/api/session', {
        headers: {
          Authorization: VueCookies.get('token')
        }
      });
      currentId.value = data.id
      isAuth.value = true
      if (window.location.pathname === '/login') {
        router.push('/')
      }
    } else {
      // TODO: add method for logout
      isAuth.value = false
      VueCookies.remove('token')
      window.location.href = '/login'
    }
  } catch (e) {
    console.error(e)
    window.location.href = '/login'
    isAuth.value = false
  }
}
