<script setup lang="ts">
import SlideShow from '@/components/widget/SlideShow.vue'
import { authStore } from '@/stores/auth'
import { onMounted, onBeforeUnmount, ref } from 'vue'
import axios from 'axios'
import type { Product } from '@/model/product'

const news = [
  {
    title: 'BLACK FRIDAY - DEAL SLAY, GIÁ RẺ NGẤT NGÂY',
    image: 'https://shopdunk.com/images/thumbs/0033149_banner%20black%20friday_App_1600.png',
    date: '23/11/2024',
  },
  {
    title: "TRẢ GÓP 3 'KHÔNG' - SỞ HỮU DỄ DÀNG, KHÔNG LO VỀ GIÁ",
    image:
      'https://shopdunk.com/images/thumbs/0032071_banner%20tra%CC%89%20go%CC%81p%201_PC_1600.png',
    date: '06/11/2024',
  },
  {
    title:
      'Tổng hợp CTKM tháng 11 tại ShopDunk. Ưu đãi lên đến 13 Triệu cho sản phẩm Apple chính hãng',
    image: 'https://shopdunk.com/images/thumbs/0032038_banner tổng T11_App_1600.png',
    date: '01/11/2024',
  },
]

const productTypes = [
  {
    name: 'iPhone',
    image: 'https://shopdunk.com/images/uploaded-source/IP_Mobile.png',
  },
  {
    name: 'Mac',
    image: 'https://shopdunk.com/images/uploaded-source/Mac_Mobile.png',
  },
  {
    name: 'iPad',
    image: 'https://shopdunk.com/images/uploaded-source/IPad_Mobile.png',
  },
  {
    name: 'Wacth',
    image: 'https://shopdunk.com/images/uploaded-source/Watch_Mobile.png',
  },
  {
    name: 'Âm thanh',
    image: 'https://shopdunk.com/images/uploaded-source/sounds.png',
  },
  {
    name: 'Accessories',
    image: 'https://shopdunk.com/images/uploaded-source/Phu_kien_icon.png',
  },
]

const listPath: string[] = [
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20tr%E1%BA%A3%20g%C3%B3p%201',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20iP15sr-T11',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20Mcsr-T11',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20iPsr-T11',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20Wsr-T11',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20APsr-T11',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang_7/banner%20mac',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang_7/banner%20iPad',
  'https://shopdunk.com/images/uploaded/banner/banner%202024/Thang11-2024/Thang11_V2/banner%20sacom',
]

const listImageSlides = ref<string[]>([])
const product = ref<Product[]>([])

const getLinkImageSlides = () => {
  listImageSlides.value = listPath.map((item, index) => {
    if (window.innerWidth >= 1001) {
      item = index === 5 ? `${item}_PC-min.png` : `${item}_PC.png`
    }
    if (window.innerWidth <= 767) {
      item = index === 5 ? `${item}_MB-min.png` : `${item}_MB.png`
    }
    return item
  })
}

onMounted(async () => {
  getLinkImageSlides()
  window.addEventListener('resize', getLinkImageSlides)
  await axios.get<Product[]>('http://localhost:3000/product').then((res) => {
    product.value = res.data
  })
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', getLinkImageSlides)
})

const getAuthStore = authStore()
</script>

<template>
  <SlideShow
    v-if="getAuthStore.windowSize >= 1001 || getAuthStore.windowSize <= 767"
    :list-image="listImageSlides"
  />
  <ul
    v-if="getAuthStore.windowSize <= 767"
    class="flex items-center flex-wrap w-[95%] mx-auto mt-[15px]"
  >
    <li
      v-for="(item, index) in productTypes"
      :key="index"
      :style="{ width: 'calc(100% / 3 - 10px)' }"
      class="relative float-left m-[5px] pt-[20px] h-[145px] bg-white rounded-2xl shadow-[0_1px_8px_0_rgba(0,0,0,0.03)]"
    >
      <router-link to="">
        <img :src="item.image" alt="" class="w-full max-w-[120px] h-auto m-auto" />
        <span
          class="absolute text-center text-[15px] text-[#86868B] left-0 right-0 bottom-[10px]"
          >{{ item.name }}</span
        >
      </router-link>
    </li>
  </ul>
  <div class="flex justify-center">
    <div :class="{ 'px-5': getAuthStore.windowSize <= 1250 }" class="max-w-[1200px]">
      <div v-for="(item, index) in product" :key="index">
        <span
          :class="{ 'mt-16': index === 0 }"
          class="w-full flex justify-center text-3xl font-semibold mb-6"
          >{{ item.ctg }}</span
        >
        <div
          :class="[
            getAuthStore.windowSize < 482 ? 'grid-cols-2 gap-[10px]' : 'grid-cols-3 gap-[15px]',
          ]"
          class="grid auto-rows-[minmax(min-content,max-content)] lg:grid-cols-4 lg:gap-5"
        >
          <div
            v-for="itemDetail in item.data"
            :key="itemDetail.id"
            class="max-w-[285px] bg-white rounded-md pt-2 px-2 pb-5 first:ml-0 last:mr-0 shadow-[0_1px_8px_0_rgba(0,0,0,0.04)] hover:shadow-xl"
          >
            <div class="flex md:h-[50px] h-[25px] w-full justify-end">
              <img
                v-if="itemDetail.icon"
                :src="itemDetail.icon.image"
                alt=""
                :class="[
                  itemDetail.icon.name != 'new' ? 'max-w-[50px]' : 'max-w-[69px] max-h-[30px]',
                ]"
              />
            </div>
            <div class="px-3">
              <img :src="itemDetail.image" alt="" class="cursor-pointer mb-7" />
              <p
                class="md:min-h-[54px] min-h-[42px] cursor-pointer md:text-lg text-[15px] font-bold text-ellipsis line-clamp-2"
              >
                {{ itemDetail.name }}
              </p>
              <span class="text-[#0066CC] font-bold md:text-base text-[14px] leading-none">
                {{
                  Intl.NumberFormat('vi-VN', { style: 'decimal' }).format(itemDetail.currentPrice!)
                }}<span class="md:text-[13px] text-[11px]">₫</span>
              </span>
              <br v-if="getAuthStore.windowSize <= 790" />
              <span
                :class="[getAuthStore.windowSize > 790 ? 'px-2' : 'pr-2']"
                class="text-[#86868B] line-through md:text-sm text-[12px] leading-none"
              >
                {{
                  Intl.NumberFormat('vi-VN', { style: 'decimal' }).format(
                    itemDetail.originalPrice!,
                  )
                }}<span class="md:text-[13px] text-[9px]">₫</span>
              </span>
              <span class="md:text-sm text-[12px] text-[#86868B]">{{ itemDetail.sale }}</span>
            </div>
          </div>
        </div>
        <div class="flex h-[40px] justify-center items-center mt-7 mb-10">
          <router-link
            to="/"
            class="md:border md:border-[#0066CC] text-[#0066CC] md:hover:text-white text-sm text-center md:rounded-lg px-[45px] py-[10px] md:hover:bg-[#0066CC]"
            >Xem tất cả {{ item.ctg }} <i class="fa-solid fa-chevron-right"></i
          ></router-link>
        </div>
      </div>
    </div>
  </div>
  <div class="md:max-w-[1200px] w-full mx-auto mt-10 mb-[80px]">
    <img
      :src="
        getAuthStore.windowSize <= 767
          ? 'https://shopdunk.com/images/uploaded/banner-doanh-nghiep-04.png'
          : 'https://shopdunk.com/images/uploaded/Trang%20ch%E1%BB%A7/2.jpeg'
      "
      alt=""
      class="w-full"
    />
  </div>
  <div :class="{ 'px-5': getAuthStore.windowSize <= 1250 }" class="max-w-[1200px] mx-auto">
    <span class="w-full flex justify-center text-[24px] font-semibold mb-[15px]">Tin tức</span>
    <div
      :class="[getAuthStore.windowSize < 482 ? 'grid-cols-1' : 'grid-cols-2']"
      class="grid auto-rows-[minmax(min-content,max-content)] md:grid-cols-3 lg:gap-5 gap-[15px]"
    >
      <div
        v-for="(item, index) in news"
        :key="index"
        class="w-auto bg-white rounded-lg pb-5 first:ml-0 last:mr-0 shadow-[0_1px_8px_0_rgba(0,0,0,0.04)] hover:shadow-xl"
      >
        <img
          :src="item.image"
          alt=""
          class="cursor-pointer w-full max-h-[218px] h-[176px] mb-4 rounded-t-lg object-cover"
        />
        <div class="px-4">
          <p
            class="min-h-[80px] mb-5 cursor-pointer lg:text-[18px] text-[17px] font-semibold text-ellipsis line-clamp-3"
          >
            {{ item.title }}
          </p>
          <span class="lg:text-[15px] text-[13px] text-[#86868B]">{{ item.date }}</span>
        </div>
      </div>
    </div>
    <div class="flex h-[40px] justify-center items-center mt-7 mb-10">
      <router-link
        to="/"
        class="md:border md:border-[#0066CC] text-[#0066CC] md:hover:text-white text-sm text-center md:rounded-lg px-[45px] py-[10px] md:hover:bg-[#0066CC]"
        >Xem tất cả Tin tức <i class="fa-solid fa-chevron-right"></i
      ></router-link>
    </div>
  </div>
</template>
