import { defineStore } from 'pinia'

export const authStore = defineStore('size', {
  state: () => ({ windowSize: window.innerWidth }),
  actions: {
    updateWindowSize() {
      this.windowSize = window.innerWidth
    }
  }
})
