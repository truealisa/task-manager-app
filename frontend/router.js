import Vue from 'vue'
import Router from 'vue-router'
import Login from './components/login'
import Logout from './components/logout'
import Hello from './components/hello'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  routes: [
    {
      path: '/',
      name: 'Login',
      component: Login
    },
    {
      path: '/projects',
      name: 'Projects',
      component: Hello
    },
    {
      path: '/logout',
      name: 'Logout',
      component: Logout
    }
  ]
})
