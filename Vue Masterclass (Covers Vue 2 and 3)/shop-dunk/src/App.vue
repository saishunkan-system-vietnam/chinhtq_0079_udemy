<script setup lang="ts">
import { RouterLink, RouterView } from 'vue-router'
import { onMounted, onBeforeUnmount, ref, computed } from 'vue'
import { authStore } from './stores/auth'
import MenuDefault from './components/widget/MenuDefault.vue'

const showMenu = ref(false)
const menuItemsSm = ref([
  { text: 'iPhone', url: '/home', subItems: [] },
  { text: 'iPad', url: '/', subItems: [] },
  { text: 'Mac', url: '/', subItems: [] },
  { text: 'Watch', url: '/', subItems: [] },
  { text: 'Âm thanh', url: '/', subItems: [] },
  { text: 'Phụ kiện', url: '/', subItems: [] },
  { text: 'Máy cũ', url: '/jobs/results', subItems: [] },
])
const menuItemsXl = ref([
  ...menuItemsSm.value,
  {
    text: 'Dịch vụ',
    url: '/',
    subItems: [
      { text: 'Bảo Hành Ủy Quyền Apple (ShopDunk Care)', url: '/' },
      { text: 'Apple Care', url: '/' },
      { text: 'Bảo Hành Mở Rộng', url: '/' },
      { text: 'Bảo Hành Vip 1 đổi 1', url: '/' },
      { text: 'Bảo Hành Kim Cương', url: '/' },
      { text: 'Microsoft-Office', url: '/' },
      { text: 'Thu Cũ Đổi Mới', url: '/' },
      { text: 'Sim Thẻ', url: '/' },
      { text: 'Trả Góp', url: '/' },
      { text: 'Bán hàng doanh nghiệp', url: '/' },
      { text: 'WorkShop', url: '/' },
      { text: 'MBTI', url: '/' },
    ],
  },
  { text: 'Tin tức', url: '/', subItems: [] },
  { text: 'Khuyến mại', url: '/', subItems: [] },
])

const menuDropDown = ref([
  { text: 'Tạo tài khoản ngay', url: '/' },
  { text: 'Đăng nhập', url: '/' },
  { text: 'Dịch vụ', url: '/' },
  {
    text: 'Tin tức',
    url: '/',
    subItems: [{ icon: null, text: 'Góc cảm ơn', url: '/' }],
    show: false,
  },
  { text: 'Khuyến mại', url: '/' },
  {
    text: 'Ngôn ngữ',
    url: '/',
    subItems: [
      { icon: 'https://shopdunk.com/images/flags/vn.png', text: 'Tiếng việt', url: '/' },
      { icon: 'https://shopdunk.com/images/flags/us.png', text: 'English', url: '/' },
    ],
    show: false,
  },
])

const getIconMenu = computed(() =>
  showMenu.value
    ? 'https://shopdunk.com/images/uploaded-source/icon/icon_Close.png'
    : 'https://shopdunk.com/images/uploaded-source/icon/nav-menu-mobile.png',
)

const getAuthStore = authStore()

const handleSearch = () => {
  console.log('aaa')
}

const handleCart = () => {
  console.log('aaa')
}

const handleLogin = () => {
  console.log('aaa')
}

const handleShowMenu = () => (showMenu.value = !showMenu.value)

const handleShowMenuChild = (index: number) => {
  if (menuDropDown.value[index].show !== undefined) {
    menuDropDown.value[index].show = !menuDropDown.value[index].show
  }
}

onMounted(() => {
  window.addEventListener('resize', getAuthStore.updateWindowSize)
})

onBeforeUnmount(() => {
  window.removeEventListener('resize', getAuthStore.updateWindowSize)
})
</script>

<template>
  <header class="sticky top-0 z-10">
    <div
      :class="{
        relative: getAuthStore.windowSize < 1001,
      }"
      class="bg-zinc-600 max-w-full xl:h-[50px] h-11 px-3 flex justify-center items-center"
    >
      <img
        :class="{
          absolute: getAuthStore.windowSize < 1001,
          'left-[3%]': getAuthStore.windowSize < 1001,
          'left-[4%]': getAuthStore.windowSize <= 767,
        }"
        class="sm:block lg:hidden cursor-pointer w-[25px]"
        :src="getIconMenu"
        alt=""
        @click="handleShowMenu"
      />
      <router-link :to="{ name: 'home' }" class="flex justify-center">
        <img
          src="https://shopdunk.com/images/thumbs/0027333_logo-shopdunk.png"
          alt=""
          class="lg:w-[180px] w-[150px]"
        />
      </router-link>
      <nav class="sm:hidden lg:block h-full w-[1001px] mr-3">
        <MenuDefault
          :listDynamic="menuItemsXl"
          :classUL="['flex', 'justify-around', 'h-full', 'list-none']"
          :classLI="['h-full', 'relative', 'group', 'first:ml-0']"
        >
          <template v-slot:link="props">
            <router-link
              :to="props.item.url"
              class="flex h-full items-center px-2 py-2.5 xl:text-[15px] text-[13px] text-[#d2d2d7] hover:text-white hover:bg-zinc-500"
              >{{ props.item.text }}
              <svg
                v-if="props.item.subItems.length > 0"
                class="ml-1"
                width="12"
                height="4"
                viewBox="0 0 18 10"
                fill="none"
                xmlns="http://www.w3.org/2000/svg"
              >
                <path
                  d="M16.2253 1.00096C16.4386 1.00096 16.6239 1.06736 16.7811 1.20017C16.927 1.33297 17 1.50154 17 1.70585C17 1.89996 16.9214 2.06852 16.7642 2.21154L9.97684 8.60158C9.70737 8.86719 9.38737 9 9.01684 9C8.63509 9 8.30386 8.86719 8.02316 8.60158L1.23579 2.21154C1.0786 2.0583 1 1.88974 1 1.70586C1 1.52197 1.07298 1.35851 1.21895 1.21549C1.36491 1.07247 1.55018 1.00096 1.77474 1.00096C1.98807 0.990742 2.16772 1.06225 2.31368 1.21549L9 7.51359L15.6863 1.21549C15.8323 1.07247 16.0119 1.00096 16.2253 1.00096Z"
                  fill="white"
                  stroke="white"
                ></path>
              </svg>
            </router-link>
            <div v-if="props.item.subItems.length > 0" class="hidden group-hover:block">
              <div
                v-if="props.item.subItems.length > 0"
                class="w-0 h-0 border-l-8 border-r-8 border-b-8 border-l-transparent border-r-transparent border-b-zinc-600"
              ></div>
            </div>
            <ul
              v-if="props.item.subItems.length > 0"
              class="absolute left-0 hidden w-[240px] bg-zinc-600 text-[#d2d2d7] shadow-lg group-hover:block"
            >
              <li
                v-for="subItem in props.item.subItems"
                :key="subItem.text"
                class="hover:bg-zinc-500"
              >
                <router-link :to="subItem.url" class="block px-4 py-3 text-[15px]">
                  {{ subItem.text }}
                </router-link>
                <div class="bg-[#d2d2d71a] h-[1px]"></div>
              </li>
            </ul>
          </template>
        </MenuDefault>
      </nav>
      <div
        :class="{
          absolute: getAuthStore.windowSize < 1001,
          'right-[4%]': getAuthStore.windowSize < 1001,
        }"
        class="cursor-pointer flex lg:w-28 w-20 h-full items-center justify-around mr-2"
      >
        <img
          src="https://shopdunk.com/images/uploaded-source/icon/search-icon-1.png"
          alt=""
          class="w-5 h-5"
          @click="handleSearch"
        />

        <div class="cursor-pointer relative" @click="handleCart">
          <img src="https://shopdunk.com/images/uploaded-source/icon/cart-icon.png" alt="" />
          <span
            class="absolute right-[-5px] top-[11px] bg-white w-[15px] h-[15px] rounded-[50%] text-xs leading-[16px] text-center"
            >0</span
          >
        </div>
        <div class="sm:hidden lg:block cursor-pointer" @click="handleLogin">
          <img
            src="https://shopdunk.com/images/uploaded-source/icon/login.png"
            alt=""
            class="w-[18px] h-[18px]"
          />
        </div>
      </div>
      <div
        :class="{
          absolute: getAuthStore.windowSize < 1001,
          'left-[13%]': getAuthStore.windowSize <= 767,
          'left-[10%]': getAuthStore.windowSize < 1001,
          'top-3': getAuthStore.windowSize < 1001,
        }"
        class="cursor-pointer h-[18px] flex flex-row items-end mr-3"
      >
        <img src="https://shopdunk.com/images/flags/vn.png" alt="" class="mr-2" />
        <img src="https://shopdunk.com/images/flags/us.png" alt="" />
      </div>
    </div>
    <div v-if="getAuthStore.windowSize < 1001" class="w-full bg-white">
      <ul class="flex justify-around list-none">
        <li
          v-for="(menuItem, index) in menuItemsSm"
          :key="menuItem.text"
          :class="[
            { hidden: index === 4 && getAuthStore.windowSize > 767 },
            'py-[6px]',
            'first:ml-0',
          ]"
        >
          <router-link :to="menuItem.url" class="text-[13px] text-zinc-800 font-normal"
            >{{ menuItem.text }}
          </router-link>
        </li>
      </ul>
    </div>
    <div
      v-show="showMenu"
      class="absolute w-full bg-white border border-gray-200 shadow-md transition-all duration-300 ease-in"
      :class="{ 'opacity-100 scale-100': showMenu, 'opacity-0 scale-95': !showMenu }"
    >
      <ul class="w-full px-4">
        <li
          v-for="(item, index) in menuDropDown"
          :key="index"
          :class="{
            'border-b-[1.5px]': index != menuDropDown.length - 1,
          }"
          class="w-full py-4"
        >
          <div
            :class="{ 'cursor-pointer': item.subItems }"
            class="flex items-center justify-between"
            @click="handleShowMenuChild(index)"
          >
            <span v-if="item.subItems" class="ml-2 text-[15px] text-zinc-800 font-normal">{{
              item.text
            }}</span>
            <router-link v-else :to="item.url" class="ml-2 text-[15px] text-zinc-800 font-normal"
              >{{ item.text }}
            </router-link>
            <svg
              v-if="item.subItems"
              class="mr-3"
              width="14"
              height="14"
              viewBox="0 0 18 10"
              fill="none"
              xmlns="http://www.w3.org/2000/svg"
            >
              <path
                d="M16.2253 1.00096C16.4386 1.00096 16.6239 1.06736 16.7811 1.20017C16.927 1.33297 17 1.50154 17 1.70585C17 1.89996 16.9214 2.06852 16.7642 2.21154L9.97684 8.60158C9.70737 8.86719 9.38737 9 9.01684 9C8.63509 9 8.30386 8.86719 8.02316 8.60158L1.23579 2.21154C1.0786 2.0583 1 1.88974 1 1.70586C1 1.52197 1.07298 1.35851 1.21895 1.21549C1.36491 1.07247 1.55018 1.00096 1.77474 1.00096C1.98807 0.990742 2.16772 1.06225 2.31368 1.21549L9 7.51359L15.6863 1.21549C15.8323 1.07247 16.0119 1.00096 16.2253 1.00096Z"
                fill="#a1a1aa"
                stroke="#a1a1aa"
              ></path>
            </svg>
          </div>
          <ul
            v-if="item.show"
            :class="{
              'list-disc': index != menuDropDown.length - 1,
              'ml-8': index == menuDropDown.length - 1,
              'ml-12': index != menuDropDown.length - 1,
              'mt-1': index != menuDropDown.length - 1,
            }"
          >
            <li
              v-for="(itemChild, index) in item.subItems"
              :key="index"
              :class="{
                flex: itemChild.icon,
                'items-center': itemChild.icon,
                'pt-2': itemChild.icon,
              }"
            >
              <img v-if="itemChild.icon" :src="itemChild.icon" alt="" class="h-3" />
              <router-link
                :to="itemChild.url"
                class="ml-2 text-[15px] text-zinc-800 hover:text-blue-500"
                >{{ itemChild.text }}
              </router-link>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </header>

  <main class="overflow-y-auto w-full flex-1 bg-[#f5f5f7]">
    <router-view></router-view>
  </main>
</template>
