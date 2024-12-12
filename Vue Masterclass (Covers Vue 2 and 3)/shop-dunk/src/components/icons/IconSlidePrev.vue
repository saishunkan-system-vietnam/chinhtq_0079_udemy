<template>
  <div
    :style="{
      width: props.size ?? '48px',
      height: props.size ?? '48px',
    }"
    class="flex cursor-pointer rounded-full bg-gray-400 opacity-10 justify-center items-center py-3 pr-1 hover:opacity-70"
  >
    <svg
      xmlns="http://www.w3.org/2000/svg"
      viewBox="0 -960 960 960"
      :fill="props.color ?? 'White'"
      class="w-full h-full"
    >
      <path d="M655-80 255-480l400-400 56 57-343 343 343 343-56 57Z" />
    </svg>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  size?: string
  color?: string
}>()
</script>
