<template>
    <div class="chartmanager">
        <div class="container-fluid" id="main">
            <div class="row row-offcanvas row-offcanvas-left">
                <!--/col-->

                <div class="col main">
                    <h1 class="display-4 d-none d-sm-block">
                        Tableau de bord
                    </h1>
                    <div class="row mb-3">
                        <div class="col-xl-3 col-sm-6 py-2">
                            <div class="card text-white h-100">
                                <div class="card-body">
                                    <bar-chart id="bar"
                                               :data="datas.bar"
                                               xkey="year"
                                               ykeys='[ "and", "ios", "win" ]'
                                               bar-colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
                                               grid="true"
                                               grid-text-weight="bold"
                                               resize="true">
                                    </bar-chart>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 py-2">
                            <div class="card text-white h-100">
                                <div class="card-body">
                                    <line-chart id="line"
                                                :data="lineData"
                                                xkey="year"
                                                ykeys='[ "a", "b" ]'
                                                labels='[ "Serie A", "Serie B" ]'
                                                line-colors='[ "#FF6384", "#36A2EB" ]'
                                                grid="true"
                                                grid-text-weight="bold"
                                                resize="true">
                                    </line-chart>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 py-2">
                            <div class="card text-white h-100">
                                <div class="card-body">
                                    <donut-chart id="donut"
                                                 :data="donutData"
                                                 colors='[ "#FF6384", "#36A2EB", "#FFCE56" ]'
                                                 resize="true">
                                    </donut-chart>
                                </div>
                            </div>
                        </div>
                        <div class="col-xl-3 col-sm-6 py-2">
                            <div class="card text-white h-100">
                                <div class="card-body">
                                    <area-chart id="area_2"
                                                data='[
                                { "key": "2013", "value": 30 },
                                { "key": "2014", "value": 25 },
                                { "key": "2015", "value": 29 },
                                { "key": "2016", "value": 50 }
                                ]'
                                                resize="true"
                                                line-colors='[ "#FF6384", "#36A2EB" ]'
                                                grid="true"
                                                grid-text-weight="bold">
                                    </area-chart>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!--/main col-->
            </div>
        </div>
    </div>
</template>

<script>
    import User from './User.vue'

    // Charts import
    import Raphael from 'raphael/raphael'
    import { DonutChart, BarChart, LineChart, AreaChart } from 'vue-morris'
    global.Raphael = Raphael

    export default {
        name: 'ChartManager',
        components: {
            DonutChart, BarChart, LineChart, AreaChart
        },
        data() {
            return {
                datas: {
                    bar: [
                        { "year": "2013", "and": 10, "ios": 5, "win": 2 },
                        { "year": "2014", "and": 10, "ios": 15, "win": 3 },
                        { "year": "2015", "and": 55, "ios": 55, "win": 55 },
                        { "year": "2016", "and": 30, "ios": 20, "win": 1 }
                    ]
                },
                user: null,
                user_datas: null,
                donutData: [
                    { label: 'Identifiant', value: 300 },
                    { label: 'Blue', value: 50 },
                    { label: 'Yellow', value: 100 }
                ],
                lineData: []
            }
        },
        async beforeMounted() {
            this.user = await User.methods.getUser(this.$route.params.userid);
            console.log(this.user);
        },
        mounted() {
            this.lineData = [
                { year: '2013', a: 25, b: 55 },
                { year: '2014', a: 94, b: 41 },
                { year: '2015', a: 12, b: 78 },
                { year: '2016', a: 59, b: 13 }
            ];
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
