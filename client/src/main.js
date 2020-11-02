import Vue from 'vue'
import VueRouter from 'vue-router'
import App from './App.vue'

// Functional component
import User from './components/User'

// Graphical component
import Registration from './components/Register'
import Authentication from './components/Authentication'
import WorkingTimes from './components/WorkingTimes'
import WorkingTime from './components/WorkingTime'
import ClockManager from './components/ClockManager'
import ChartManager from './components/ChartManager'
import UserViewer from './components/UserViewer'

import Notifications from 'vue-notification'
Vue.use(Notifications)

import { BootstrapVue, IconsPlugin } from 'bootstrap-vue'
Vue.use(BootstrapVue)
Vue.use(IconsPlugin)

Vue.config.productionTip = false
Vue.use(VueRouter);

const router = new VueRouter({
    mode: 'history',
    routes: [
        {
            path: '/sign_up',
            name: 'signUp',
            component: Registration
        },
        // Sign_in (Authentication) route
        {
            path: '/sign_in',
            name: 'signIn',
            component: Authentication
        },
        // WorkingTimes route
        {
            path: '/workingTimes/:userid',
            name: 'workingTimes',
            component: WorkingTimes
        },
        // WorkingTime (creation) route
        {
            path: '/workingTime/:userid',
            name: 'workingTime_creation',
            component: WorkingTime
        },
        // WorkingTime (update & delete) route
        {
            path: '/workingTime/:userid/:workingtimeid',
            name: 'workingTime_update_delete',
            component: WorkingTime
        },
        // ClockManager route
        {
            path: '/clock/:username',
            name: 'clock',
            component: ClockManager
        },
        // ChartManager route
        {
            path: '/chartManager/:userid',
            name: 'chartManager',
            component: ChartManager
        },
        // UserViewer route
        {
            path: '/userViewer',
            name: 'userViewer',
            component: UserViewer
        }
    ]
})  

/*const store = new Vuex.Store({
    state: {
        count: 0
    },
    mutations: {
        increment(state) {
            state.count++
        }
    }
})*/

Vue.component('User', User);

new Vue({
    router,
    //store,
    render: h => h(App)
}).$mount('#app')