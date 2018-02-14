<template>
  <div id="app">
    <template v-if="currentUser">
      <Navbar></Navbar>
    </template>
    <div class="container-fluid">
      <router-view></router-view>
      <template>
        <Foot></Foot>
      </template>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

import Navbar from '../components/navbar'
import Foot from '../components/foot'

export default {
  name: 'app',
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  created () {
    this.checkCurrentLogin()
  },
  updated () {
    this.checkCurrentLogin()
  },
  methods: {
    checkCurrentLogin () {
      if (!this.currentUser && this.$route.path !== '/') {
        this.$router.push('/?redirect=' + this.$route.path)
      }
    }
  },
  components: {
    Navbar,
    Foot
  }
}
</script>

<style scoped>
</style>
