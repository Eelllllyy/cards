<template>
  <div
    v-if="!card.passed"
    class="card"
  >
    <div class="front">
      <!-- <img 
        :src="card.image_one?.url"
        alt="avatar"
      > -->
    </div>
    <div
      v-if="card.id !== currentId"
      class="back black"
    />
    <div
      v-else
      class="back red"
    />
  </div>
  <div
    v-else
    class="card passed"
  >
    <img
      class="img"
      :src="card.image_two?.url"
      alt="avatar"
    > 
  </div>
</template>
<script setup>
import { currentId } from "@/modules/home/homeService";
const props = defineProps({
  card: {
    type: Object,
    required: true,
    default: () => {
    }
  }
})
</script>
<style scoped>
.card{
  cursor: pointer;
  height: 100%;
  transform: translate(-50%, -50%);
}
.front,
.back{
  width: 100%;
  height: 100%;
  overflow: hidden;
  backface-visibility: hidden;
  position: absolute;
  transition: transform .6s linear;
  background-color: #323a3ae1;
  border-radius: 14px;
}
.front img{
  height: 100%;
  width: 100%;
}
.img{
  height: 100%;
  width: 100%;
}
.back{
  transform: perspective(600px) rotateY(180deg);
}
.black{
  background-color: #272727;
  border-radius: 17px;
}
.red{
  background-color: #e72b2b;
  border-radius: 17px;
}
.card:hover > .front{
  transform: perspective(600px) rotateY(-180deg);
}
.card:hover > .back{
  transform: perspective(600px) rotateY(0deg);
}
.passed{
  width: 100%;
  height: 100%;
  animation: ani 2.5s forwards;
}

@keyframes ani {
  0% {
    opacity: 0;
    transform: translate(-50%, -50%) rotateY(180deg)
  }

  100% {
    opacity:1;
    transform: translate(-50%, -50%) perspective(600px) rotateY(0deg)
  }
}
</style>