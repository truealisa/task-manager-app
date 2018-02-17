// import css
import "./application.css";
// import Vue and components
import Vue from 'vue'
import router from '../router'
import store from '../store'
import App from '../components/app'
// import icons
import '../icons'
import Icon from 'vue-awesome/components/Icon'

Vue.component('icon', Icon)

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('application'))
  const app = new Vue({
    el,
    router,
    store,
    render: h => h(App)
  })
})
