<template>
  <div class="workingtime">
  </div>
</template>

<script>
    // Date format ISO 8601

    export default {
        name: 'WorkingTime',
        props: {

        },
        methods: {
            getWorkingtimeByUserID(/*id, workingtimeID*/) {
              /*axios
                .get(
                  ${API_ROOT}api/workingtimes/${id}/${workingtimeID}, {},
                )
                .then((response) => {
                  console.log(response);
                })
                .catch((error) => {
                  console.log(error);
                });*/
            },
            createworkingtime(/*id, start, end*/) {
              /*axios
                .post(
                  ${API_ROOT}api/workingtimes/${id},
                  { start, end },
                )
                .then((response) => {
                  console.log(response);
                })
                .catch((error) => {
                  console.log(error);
                });*/
            },
            updateWorkingtime(/*workingtimeID, start = '', end = ''*/) {
              /*axios
                .put(
                  ${API_ROOT}api/workingtimes/${workingtimeID},
                  { start, end },
                )
                .then((response) => {
                  console.log(response);
                })
                .catch((error) => {
                  console.log(error);
                });
              // console.log(workingtimeID + start + end);*/
            },
            deleteWorkingtime(/*workingtimeID*/) {
              /*axios
                .delete(
                  ${API_ROOT}api/users/${workingtimeID}, {},
                )
                .then((response) => {
                  console.log(response);
                })
                .catch((error) => {
                  console.log(error);
                });*/
            },
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
