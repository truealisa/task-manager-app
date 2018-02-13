import Vue from 'vue'
import Router from 'vue-router'
import Login from './components/login.vue'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    }
  ]
})
