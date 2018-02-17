<template>
  <div class="row justify-content-center">
    <div class="projects-wrapper col-md-8">
      <Project v-for="project in projects" :key="project.id" :project="project"></Project>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'
import { apiUrls } from '../global_variables'
import Project from './project'

export default {
  name: 'home',
  computed: {
    ...mapGetters({ currentUser: 'currentUser' })
  },
  data () {
    return {
      error: false,
      projects: []
    }
  },
  created () {
    this.getUserData()
  },
  methods : {
    getUserData() {
      fetch(apiUrls.baseURL + apiUrls.projectsAffix, {
              method: "GET",
              headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json',
                'Authorization': "Bearer " + localStorage.token
              }
      }).then(response => response.json())
        .then(json => {
          console.log(json)
          this.projects = json
        })
        .catch(error => {
          this.error = error
          console.log(error)
        })
    }
  },
  components: {
    Project
  }
}
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .projects-wrapper {
    width: 100%;
    padding: 0;
  }
</style>
