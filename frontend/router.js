import Vue from 'vue'
import Router from 'vue-router'
import App from 'components/app'

Vue.use(Router)

export default new Router({
  // mode: 'history',
  routes: [
    {
      path: '/',
      name: 'App',
      component: App
    },
    {
      path: '/hello',
      name: 'App',
      component: App
    }
  ]
})
