<template>
  <div class="wrapper">
    <main class="main">
      <article class="cards">
        <div
        v-if="passed<42"
          v-for="card in cards"
          :class="[allCardsOpen? 'end-card' : 'one-card']"
        >
          <oneCard
            :key="card.id"
            :card="card"
          />
        </div>
        <div v-else>
          <img src="...">
        </div>
      </article>
      <article class="decription">
        <div class="decription-content">
          <div class="header-text">
            <h1>Secret project</h1>
            <h4>Uncover the mystery</h4>
          </div>
          <p class="text-indent">
            В городе начали ходить слухи о том, что Группа Адептов Гибкой Разработки затевает что-то крупное еще с лета: постоянные расспросы, хитрые взгляды, тайные встречи, фотосессии по всей стране. Их работа завершена и они затерялись в толпе до следующего крупного расследования.
          </p>
          <p class="text-indent">
            ГАГР засекретила все материалы перед своим исчезновением, но оставила след из хлебных крошек, чтобы рано или поздно город узнал о них. Он начинается с фрагментов фотографий, которые были найдены в одной из лабораторий группы.
          </p>
          <p class="text-indent">
            Вы должны найти свой фрагмент, перейти по qr-коду с телефона в ТГ бота и следовать инструкциям чтобы открыть свой фрагмент.  Только после открытия всей картины, можно продвинуться. (логотип ГАГР) При прохождении квеста в ТГ держите эту страницу открытой
          </p>
        </div>
      </article>
    </main>
  </div>
</template>
<script setup>
import oneCard from '@/modules/home/components/oneCard.vue';
import { cards, getCards , getUser, passed} from "@/modules/home/homeService";
import { onMounted, watch,ref } from 'vue'
const  allCardsOpen = ref(false)
watch(()=> passed.value, () => {
  if(passed.value == 42){
    allCardsOpen.value = true
  }
})
onMounted( () => {
  getCards()
  let ws = `${import.meta.env.VITE_WS_URL}`;
  let socket = new WebSocket(ws);
  socket.onopen = () => {
    socket.send(
        JSON.stringify({
          command: "subscribe",
          identifier: JSON.stringify({
            channel: "UserChannel"
          }),
        })
    );
    socket.onmessage = (event) => {
      let data = JSON.parse(event.data);
      if (!data.type && data.message) {
        // cards.value.map(e => data.message.user_id === e.id ? e.passed = data.message.passed : e )
        cards.value.map(e => data.message.user_id === e.id ? (e.passed = data.message.passed, passed.value+=1 ): e )
      }
    };
  };
})
</script>
<style scoped>
.wrapper{
  background: url('../assets/images/homeWrapper.svg') no-repeat center center / cover;
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  padding: 7% 3% 5%;
}
img{
  animation: ani 4.5s forwards
}
.main{
  width: 90%;
  height: 80%;
  margin: 0 auto;
  display: flex;
  justify-content: space-evenly;
}
.cards{
  width: 50%;
  display: flex;
  flex-wrap: wrap;
}
.decription{
  width: 40%;
  display: flex;
  align-items: center;
  justify-content: flex-end;
}
.decription-content{
  max-width: 408px;
  min-width: 252px;
  background: rgba(0, 0, 0, 0.7);
  border: 2px solid #FFFFFF;
  backdrop-filter: blur(5px);
  border-radius: 31px;
  color: white;
  padding: 38px 32px 34px;
}
.header-text{
  text-align: center;
  margin-bottom: 20px;
}
.text-indent{
  text-indent: 20px;
  text-align: justify;
}
.one-card{
  margin:3px;
  width: 12%;
  height: 23%;
}
.end-card{
  width: 13%;
  height: 24%;
  animation: ani 4.5s forwards;
}

@keyframes ani {
  0% {
    opacity: 0;
  }

  100% {
    opacity:1;
  }
}
@media(min-width: 2000px){
  .decription-content{
    font-size: 1.4em;
    max-width: 87%;
    padding: 40px;
  }
  .one-card{
  width: 13%;
  }
}
@media(min-width: 3000px){
  .decription-content{
    font-size: 2.3em;
    max-width: 96%;
    padding: 65px;
  }
  .text-indent{
  text-indent: 90px;
}
}
@media(min-width: 4000px){
  .decription-content{
    font-size: 2.9em;
    max-width: 95%;
    padding: 78px;
  }
}
@media(min-width: 5000px){
  .decription-content{
    font-size: 3.7em;
    max-width: 92%;
    padding: 90px;
  }
}
@media(min-width: 6000px){
  .decription-content{
    font-size: 4.5em;
    max-width: 92%;
    padding: 130px;
  }
}
@media(min-width: 7000px){
  .decription-content{
    font-size: 5.6em;
    max-width: 100%;
    padding: 160px
  }
}
@media(min-width: 8000px){
  .decription-content{
    font-size: 6em;
    max-width: 90%;
  }
}
@media(min-width: 9000px){
  .decription-content{
    font-size: 6.5em;
    max-width: 86%;
    padding: 200px;
  }
}
@media(max-width: 1000px){
  .decription-content{
    font-size: 0.6em;
    max-width: 89%;
  }
}
</style>
