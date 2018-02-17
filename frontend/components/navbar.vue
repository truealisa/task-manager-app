<template>
  <nav class="navbar">
    <span class="navbar-text">
      Hello, {{ currentUser.name }}!
      <router-link to="/logout" class="btn btn-logout">Logout</router-link>
    </span>
  </nav>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Navbar',
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  }
}
</script>

<style lang="css" scoped>
  .navbar {
    padding: 0;
    color: #555;
  }

  .navbar .navbar-text {
    width: 100%;
    text-align: right;
    margin-right: 15px;
    padding-bottom: 0;
  }

  .btn-logout {
    color: #fff;
    padding: 5px 8px 8px;
    line-height: 16px;
    margin-left: 10px;
  }
</style>
