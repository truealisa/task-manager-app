import Vue from 'vue'
import Router from 'vue-router'
import Login from './components/login'
import Logout from './components/logout'
import Signup from './components/signup'
import Home from './components/home'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Home',
      component: Home
    },
    {
      path: '/login',
      name: 'Login',
      component: Login
    },
    {
      path: '/logout',
      name: 'Logout',
      component: Logout
    },
    {
      path: '/signup',
      name: 'Signup',
      component: Signup
    }
  ]
})
