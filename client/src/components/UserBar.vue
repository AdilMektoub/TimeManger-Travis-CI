<template>
  <div class="userbar">
    <b-navbar toggleable="lg" type="dark" variant="info">
      <Slide id="slide-menu" v-if="isUserSignIn">
        <a id="home" href="#">
          <span>Home</span>
        </a>
      </Slide>
      <b-navbar-nav class="ml-auto">
        <b-nav-item-dropdown right>
          <!-- Using 'button-content' slot -->
          <template #button-content>
            <i class="fa fa-user fa-lg"></i>
          </template>
          <div v-if="isUserSignIn">
            <b-dropdown-item href="#">Mon compte</b-dropdown-item>
            <b-dropdown-item @click="signOutButton"
              >Se déconnecter</b-dropdown-item
            >
          </div>
          <div v-else>
              <b-dropdown-item href="/sign_in">Se connecter</b-dropdown-item>
              <b-dropdown-item href="/sign_up">S'inscrire</b-dropdown-item>
            </div>
        </b-nav-item-dropdown>
      </b-navbar-nav>
    </b-navbar>
  </div>
</template>


<script>
import Authentication from "./Authentication";
import { Slide } from "vue-burger-menu";

export default {
  name: "UserBar",
  components: {
    Slide,
  },
  data() {
    return {
      isUserSignIn: (localStorage.bearer !== undefined && localStorage.bearer !== ""),
    };
  },
  methods: {
    // Sign out by user action
    signOutButton: function () {
      if (Authentication.methods.signOut()) {
        this.$router.push("sign_in");
        this.$notify({
          group: "result",
          type: "success",
          position: "top center",
          duration: 5000,
          title: "Succès",
          text: "A bientôt !",
        });
        this.isUserSignIn = false;
      }
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style>
.userbar {
  font-size: 1rem;
  width: 100%;
  position: fixed;
  top: 0;
  left: 0;
}

.bm-burger-button {
  position: fixed;
  left: 2rem;
  top: 1rem;
}
</style>