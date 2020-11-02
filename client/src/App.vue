<template>
    <div id="app">
        <UserBar/>
        <notifications class="custom-notif" group="result" position="top left" width="100%"></notifications>
        <router-view></router-view>
    </div>
</template>

<script>
import UserBar from './components/UserBar.vue'

export default {
  name: 'App',
  components: {
      UserBar
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  /*color: #2c3e50;*/
  color: white !important;
  /*margin-top: 60px;*/
  height: 100%;
}

body, html {
  background-color: #34495E;
  height: 100%;
}

table {
    color: black !important;
}

.vue-notification {
  font-size: 1rem !important;
}
</style>
