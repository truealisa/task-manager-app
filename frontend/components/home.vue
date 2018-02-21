<template>
  <div class="row justify-content-center">
    <div class="projects-wrapper col-md-8">
      <Project v-for="project in projects" :key="project.id" :project="project"></Project>
      <button class="btn btn-add-project"><icon class="plus-icon" name="plus" scale="1.4"></icon>Add TODO List</button>
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
        .then(json => this.projects = json)
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

  .btn-add-project {
    display: block;
    position: relative;
    left: 50%;
    transform: translateX(-50%);
    bottom: -10px;
    font-weight: bold;
    padding: 10px 25px 10px 48px;
  }

  .plus-icon.fa-icon {
    color: #2C436B;
    filter: drop-shadow( 0px 1px 0px #7D95C1 )
            drop-shadow( 0px -1px 0px #232B38 );
    position: absolute;
    left: 16px;
    top: 11px;
  }
</style>
