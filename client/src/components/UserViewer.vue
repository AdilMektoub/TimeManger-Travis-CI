<template>
    <div class="userviewer">
        <div class="row ml-0 mr-0">
            <div class="col-md-8 offset-md-2 ">
                <div class="card user-card">
                    <div class="card-body">
                        <!-- Titre Utilisateur -->
                        <h3 class="card-title"> <i class="fa fa-users pr-3" aria-hidden="true"></i>Gestion des utilisateurs</h3>
                        
                        <!-- S�lection d'un utilisateur -->
                        <div class="row">
                            <div class="col-md-9">
                                <div class="col-md-12">
                                    <select class="form-control" placeholder="Choisir un utilisateur" @change="change">
                                        <option value=""></option>
                                        <option v-for="(user, index) in users" :value="user.username" :key="index" :selected="selectedUser(user.username)">
                                            {{ user.username }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <!-- Affichage des informations de l'utilisateur -->
                        <div class="user-data">
                            <div class="row">
                                <div class="col-md-9 pt-4">
                                    <div class="col-md-12 user-field">
                                        <label class="sr-only" for="user-username">Nom d'utilisateur</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text"><i class="fa fa-user pr-1" aria-hidden="true"></i></div>
                                            </div>
                                            <input type="text" class="form-control" placeholder="Nom d'utilisateur" id="user-username" v-model="user.username" />
                                        </div>
                                    </div>

                                    <div class="col-md-12 user-field">
                                        <label class="sr-only" for="user-email">Email</label>
                                        <div class="input-group mb-2">
                                            <div class="input-group-prepend">
                                                <div class="input-group-text">@</div>
                                            </div>
                                            <input id="user-email" class="form-control" placeholder="Email" v-model="user.email" />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3 user-action">
                                    <button v-on:click="createUser('test', 'test@gmail.com')" class="btn"><i class="fa fa-plus" aria-hidden="true"></i></button>
                                    <button v-on:click="updateUser()" class="btn"><i class="fa fa-pencil" aria-hidden="true"></i></button>
                                    <button v-on:click="deleteUser()" class="btn"><i class="fa fa-trash-o" aria-hidden="true"></i></button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script>
    import axios from 'axios'   

    import config from '../config';

    export default {
        name: 'UserViewer',
        data() {
            return {
                users: null,
                user: { username: "", email: "" }
            }
        },
        props: {
            username: String,
            email: String
        },
        methods: {
            selectedUser: function (username) {
                if (this.username) {
                    return username === this.username;
                }
                return false;
            },
            rand (limit) {
                return Math.round(Math.random() * limit)
            },
            change(e) {
                const selectedUser = e.target.value;
                const user = this.users.find(user => selectedUser === user.username);
                if (user)
                    this.user = user;
                else
                    this.user = {username: "", email: ""}
            },
            getUsers: async function () {
                this.users = (await axios.get(config.API_ROOT + "api/users/all")).data.data;
                console.log(this.users);
            },
            /*change(e) {
                  const selectedUser = e.target.value;
                  const user = this.users.find(user => selectedUser === user.username);
                  if (user) {
                    this.user = user;
                    this.$router.push({ path: `/currentWeather/${this.weather.town}` });
                  }
            },*/


            /*********** API CALLS ***********/
            createUser: function (username, email) {
                axios
                    .post(
                      config.API_ROOT + "api/users",
                      {email: email, username: username}
                  )
                  .then(response => {
                    console.log(response)
                  })
                  .catch(error => {
                    console.log(error);
                  });
            },
            updateUser: function (id, username = "", email = "") {
                axios
                  .put(
                      config.API_ROOT + "api/users/" + id,
                      {"email": email, "username": username}
                  )
                  .then(response => {
                    console.log(response)
                  })
                  .catch(error => {
                    console.log(error);
                  });

                   //console.log(id + username + email);

            },
            getUser: async function (id) {
                const response = await axios({
                    url: config.API_ROOT + "api/users/" + id,
                    method: "GET"
                });

                console.log(response.data.data);
            },
            deleteUser: function (id) {
                axios
                    .delete(
                        config.API_ROOT + "api/users/" + id, {}
                  )
                  .then(response => {
                    console.log(response)
                  })
                  .catch(error => {
                    console.log(error);
                  });
            }
        },
        mounted() {
            this.getUsers();

            setInterval(() => {
                this.lineData = [
                    { year: '2013', a: this.rand(100), b: this.rand(100) },
                    { year: '2014', a: this.rand(100), b: this.rand(100) },
                    { year: '2015', a: this.rand(100), b: this.rand(100) },
                    { year: '2016', a: this.rand(100), b: this.rand(100) }
                ]
            }, 5000)
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h1, h2 {
  font-weight: normal;
}
.card {
    border-radius: 20px;
}

.user-card {
    background-color: #17A2B8;
}

.user-data .btn {
    margin-top: 0.2rem;
    margin-bottom: 0.2rem;
}

.user-action {
    text-align: -webkit-right;
}

.user-action button{
    display: block;
    width: 2.3rem;
    /*float: right;*/
}
</style>
