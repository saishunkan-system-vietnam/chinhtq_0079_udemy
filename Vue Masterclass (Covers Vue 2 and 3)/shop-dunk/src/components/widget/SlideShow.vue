<template>
  <div class="relative w-full mx-auto overflow-hidden">
    <div
      class="flex transition-transform duration-500"
      :style="{ transform: `translateX(-${currentIndex * 100}%)` }"
    >
      <div
        v-for="(slide, index) in props.listImage"
        :key="index"
        class="w-full h-full flex-shrink-0"
      >
        <img :src="slide" alt="Slide" class="w-full h-full object-cover" />
      </div>
    </div>

    <div class="absolute top-[45%] left-[3%]">
      <IconSlidePrev @click="prevSlides" />
    </div>

    <div class="absolute top-[45%] right-[3%]">
      <IconSlideNext @click="nextSlides" />
    </div>

    <div class="absolute bottom-4 left-0 right-0 flex justify-center space-x-2">
      <span
        v-for="(_, index) in props.listImage"
        :key="index"
        class="cursor-pointer w-2 h-2 rounded-full hover:bg-gray-700"
        :class="{
          'bg-gray-700': currentIndex === index,
          'bg-gray-300': currentIndex !== index,
        }"
        @click="changeSlides(index)"
      ></span>
    </div>
  </div>
</template>
<script setup lang="ts">
import { onMounted, onBeforeUnmount, ref } from 'vue'
import IconSlidePrev from '../icons/IconSlidePrev.vue'
import IconSlideNext from '../icons/IconSlideNext.vue'

const props = defineProps<{
  listImage: string[]
}>()

const currentIndex = ref(0)
let slideInterval: number

const startSlideshow = () => {
  slideInterval = setInterval(() => {
    currentIndex.value = (currentIndex.value + 1) % props.listImage.length
  }, 5000)
}

const changeSlides = (index: number) => {
  stopSlideshow()
  currentIndex.value = index
  startSlideshow()
}

const stopSlideshow = () => {
  clearInterval(slideInterval)
}

const nextSlides = () => {
  stopSlideshow()
  currentIndex.value++
  if (currentIndex.value === props.listImage.length) {
    currentIndex.value = 0
  }
  startSlideshow()
}

const prevSlides = () => {
  stopSlideshow()
  if (currentIndex.value === 0) {
    currentIndex.value = props.listImage.length - 1
  } else {
    currentIndex.value--
  }
  startSlideshow()
}

onMounted(() => {
  startSlideshow()
})

onBeforeUnmount(() => {
  stopSlideshow()
})
</script>
