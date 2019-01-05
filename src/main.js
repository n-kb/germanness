import Vue from 'vue'
import App from './App.vue'
import VueI18n from 'vue-i18n'
import messages from './assets/texts.js'
import vueHeadful from 'vue-simple-headful';

Vue.config.productionTip = false

Vue.use(VueI18n)
Vue.use(vueHeadful)

const i18n = new VueI18n({
  locale: 'en', // set locale
  messages, // set locale messages
})

new Vue({
  i18n,
  render: h => h(App)
}).$mount('#app')
