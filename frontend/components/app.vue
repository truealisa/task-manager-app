<template>
  <div id="app">
    <template v-if="currentUser">
      <Navbar></Navbar>
    </template>
    <h1 class="main-header">Simple TODO Lists <br><span>From Ruby Garage</span></h1>
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

<style lang="css">
html {
  border-bottom: 7px solid #333;
  border-top: 7px solid #333;
  height: 100%;
}

body {
  background: linear-gradient(#D5D0C2 40%, #D19312 60%);
}

.main-header {
  display: block;
  width: 100%;
  text-align: center;
  font-size: 30px;
  font-weight: bold;
  margin-top: 60px;
  text-transform: uppercase;
  color: #333;
  line-height: 25px;
  margin-bottom: 40px;
  text-shadow: 0px 1px 0px #eee;
}

.main-header span {
  font-weight: normal;
  font-size: 19px;
}
</style>
