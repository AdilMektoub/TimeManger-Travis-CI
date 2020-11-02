<template>
    <div class="workingtimes">
        <input type="date" :value="start && start.toISOString().split('T')[0]" @input="start = $event.target.valueAsDate" />
        <br />
        <input type="date" :value="end && end.toISOString().split('T')[0]" @input="end = $event.target.valueAsDate" />
        <h1 @click="getWorkingTimes()">WorkingTimes</h1>
        <h2>Starting date : {{start}}</h2>
        <h2>Ending date : {{end}}</h2>
        <vue-bootstrap4-table :rows="workingTimes" :columns="columns" :config="config">
        </vue-bootstrap4-table>
    </div>
</template>

<script>
    import axios from 'axios'
    import config from '../config'
    import VueBootstrap4Table from 'vue-bootstrap4-table'

    export default {
        name: 'WorkingTimes',
        components: {
            VueBootstrap4Table
        },
        props: {
            start: Date,
            end: Date,
        },
        data() {
            return {
                userId: this.$route.params.userid,
                workingTimes: [],
                columns: [
                    {
                        label: "id",
                        name: "id",
                        filter: {
                            type: "simple",
                            placeholder: "id"
                        },
                        sort: true,
                    },
                    {
                        label: "Nom d'utilisateur",
                        name: "user.username",
                        filter: {
                            type: "simple",
                            placeholder: "Enter first name"
                        },
                        sort: true,
                    },
                    {
                        label: "Start",
                        name: "start",
                        filter: {
                            type: "simple",
                            placeholder: "Enter country"
                        },
                    },
                    {
                        label: "End",
                        name: "end",
                        sort: true
                    }
                ],
                config: {
                    checkbox_rows: true,
                    rows_selectable: true,
                    card_title: "Vue Bootsrap 4 advanced table"
                }
            }
        },
        methods: {
            getWorkingTimes: async function () {
                this.userId = this.$route.params.userid;

                let start_date = 'start=' + this.getDateForURL(this.start);
                let end_date = 'end=' + this.getDateForURL(this.end);

                console.log("URL : " + config.API_ROOT + "api/workingtimes/" + this.userId + "?" + start_date + '&' + end_date);
                const response = await axios({
                    url: config.API_ROOT + "api/workingtimes/" + this.userId + "?" + start_date + '&' + end_date,
                    method: "GET"
                });
                this.workingTimes = response.data.data;
                console.log(this.workingTimes);
            },
            getDateForURL: function (date) {
                return date.toISOString().split('.')[0];  
            }
        },
        computed: {
            data() {
                return this.workingTimes;
            }
        }
    }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
</style>
