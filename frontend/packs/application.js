import Vue from 'vue'
import router from '../router'
import App from '../components/app.vue'

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('application'))
  const app = new Vue({
    el,
    render: h => h(App)
  })

  console.log(app)
})
