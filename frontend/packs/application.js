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

Vue.directive('click-outside', {
  bind: function (el, binding, vnode) {
    this.event = function (event) {
      if (!(el == event.target || el.contains(event.target))) {
        vnode.context[binding.expression](event);
      }
    };
    document.body.addEventListener('click', this.event)
  },
  unbind: function (el) {
    document.body.removeEventListener('click', this.event)
  },
});

document.addEventListener('DOMContentLoaded', () => {
  const el = document.body.appendChild(document.createElement('application'))
  const app = new Vue({
    el,
    router,
    store,
    render: h => h(App)
  })
})
