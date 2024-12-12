<template>
  <ul :class="classUL">
    <li :class="classLI" v-for="(item, index) in props.listDynamic" :key="index">
      <slot name="link" :item="item"></slot>
    </li>
  </ul>
</template>

<script setup lang="ts">
type ListItem1 = {
  text: string
  url: string
  subItems: {
    text: string
    url: string
  }[]
}[]

type classList = string | object

const props = defineProps<{
  listDynamic: ListItem1
  classUL?: classList[]
  classLI?: classList[]
}>()
</script>
