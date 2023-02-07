import { ref, reactive } from 'vue';
import axios from 'axios';
import VueCookies from 'vue-cookies'
import router from '../../router';

export const code = reactive({
  one: null,
  two: null,
  three: null,
  four: null
})
export const incorrect = ref(false)
export const isAuth = ref(false)
export const toAuth = async() => {
  try{
    const response = await axios.post('/api/session', {
    code: code.one + code.two + code.three + code.four
    });
    VueCookies.set('token', response.data.access, '15d', null, null, true)
    incorrect.value = false
    isAuth.value = true
    router.push('/')
  }catch(e){
    console.error(e)
    incorrect.value = true
    isAuth.value = false
    setTimeout(() => (incorrect.value = false ,  code.one = null,code.two = null, code.three = null,code.four = null, form.childNodes[0].focus()),900) 
  }
}