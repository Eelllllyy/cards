<template>
  <div class="wrapper">
    <div
      class="content"
      :class="{'error-border' : incorrect}"
      @click.capture="focusInput"
    >
      <h2>Use your code</h2>
      <p>to enter the darkroom</p>
      <form
        id="form"
        class="form"
      >
        <input
          v-model="code.one"
          class="input"
          :class="{error : incorrect}"
          type="text"
          maxlength="1"
          placeholder="_"
          @keyup="actionInput"
        >
        <input
          v-model="code.two"
          class="input"
          :class="{error : incorrect}"
          type="text"
          maxlength="1"
          placeholder="_"
          @keyup="actionInput"
        >
        <input
          v-model="code.three"
          class="input"
          :class="{error : incorrect}"
          type="text"
          maxlength="1"
          placeholder="_"
          @keyup="actionInput"
        >
        <input
          v-model="code.four"
          class="input"
          :class="{error : incorrect}"
          type="text"
          maxlength="1"
          placeholder="_"
          @keyup="actionInput"
        >
      </form>
    </div>
  </div>
</template>
<script setup>
import { watch } from 'vue'
import { code, incorrect, toAuth , isAuth} from "@/modules/login/loginService";

watch(()=> [code.one, code.two, code.three, code.four] ,() => {
  if(code.one && code.two && code.three && code.four){
    toAuth()
  }
})
const actionInput = (e) =>  {
  if(e.key === "Backspace" || e.key === "Delete"){
    e.target?.previousSibling?.focus();
  }
  else if(e.key === "Shift" || e.key === 'CapsLock' || e.key === "Tab" || e.key === "ArrowLeft" || e.key === "ArrowRight" || e.key === "ArrowUp" || e.key === "ArrowDown"){
    e.target.focus();
  }
  else{
    e.target?.nextSibling?.focus();
  }
}
const focusInput = () => {
  let inputs = document.getElementsByTagName('input')
  let codeKeys = Object.values(code)
  let emptyInput = codeKeys.indexOf(null)
  inputs[emptyInput].focus()
}
</script>
<style scoped>
.wrapper{
  background: url('../assets/images/loginWrapper.svg') no-repeat center center / cover;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
}
.content{
  position: fixed; 
  top: 37%; 
  right: 16.3em;
  width: 372px;
  height: 238px;
  background: rgba(0, 0, 0, 0.7);
  border: 2px solid #FFFFFF;
  border-radius: 31px;
  text-align: center;
  padding: 40px;
  color: white;
}
.form{
  display: flex;
  justify-content: space-between;
  margin-top: 37px;
  transition: all 0.7s ease;
}
.input{
  width: 66px;
  height: 64px;
  background: rgba(255, 255, 255, 0.1);
  border: 2px solid #FFFFFF;
  outline: none;
  font-size: 40px;
  color: white;
  background: transparent;
  text-align: center;
  caret-color: transparent;
}
input[type=number]::-webkit-inner-spin-button, 
input[type=number]::-webkit-outer-spin-button { 
  -webkit-appearance: none; 
  margin: 0; 
}
:focus::-webkit-input-placeholder {color: white}
:focus::-moz-placeholder          {color: white}
:focus:-moz-placeholder           {color: white}
:focus:-ms-input-placeholder      {color: white}
::placeholder {
  color: transparent;
  transition: color 0.6s ease;
}
.error-border{
  border: none;
  box-shadow: 0 0 30px red;
}
.error{
  box-shadow: 0 0 30px red;
  border: none;
  transition: all 0.4s ease;
  animation: shake 0.3s;
}
@keyframes shake {
  0% { transform: translate(1px, 1px) rotate(0deg); }
  10% { transform: translate(-1px, -2px) rotate(-1deg); }
  20% { transform: translate(-3px, 0px) rotate(1deg); }
  30% { transform: translate(3px, 2px) rotate(0deg); }
  40% { transform: translate(1px, -1px) rotate(1deg); }
  50% { transform: translate(-1px, 2px) rotate(-1deg); }
  60% { transform: translate(-3px, 1px) rotate(0deg); }
  70% { transform: translate(3px, 1px) rotate(-1deg); }
  80% { transform: translate(-1px, -1px) rotate(1deg); }
  90% { transform: translate(1px, 2px) rotate(0deg); }
  100% { transform: translate(1px, -2px) rotate(-1deg); }
}
@media(min-width: 2000px){
  .content{
    width: 25em;
    height: 13em;
    font-size: 2em;
    top: 37%;
    right: 8.3em;
  }
  .input{
    width: 3em;
    height: 3em;
    margin-top: 1em;
    font-weight: 900;
  }
}
@media(min-width: 4000px){
  .content{
    width: 26em;
    height: 14em;
    font-size: 3em;
    top: 37%;
    right: 8.3em;
    padding: 70px 70px 0 70px;
  }
  .input{
    width: 5em;
    height: 5em;
    margin-top: 1em;
    font-size: 50px;
  }
}
@media(min-width: 6000px){
  .content{
    width: 28em;
    height: 15em;
    font-size: 4em;
    top: 37%;
    right: 8.3em;
    padding: 85px 90px 0 90px
  }
  .input{
    margin-top: 2em;
    font-size: 64px;
  }
}
@media(min-width: 8000px){
  .content{
    width: 28em;
    height: 15em;
    font-size: 6em;
    top: 37%;
    right: 8.3em;
    padding: 130px 130px 0 130px;
  }
  .input{
    font-size: 103px;
  }
}
</style>