<template>
  <div class="row justify-content-center">
    <div class="projects-wrapper col-md-8">
      <Project v-for="project in projects" :key="project.id" :project="project"></Project>
      <button class="btn btn-add-project" id="show-project-modal" @click="showProjectModal = true"><icon class="plus-icon" name="plus" scale="1.4"></icon>Add TODO List</button>

      <div v-if="showProjectModal">
        <transition name="modal">
          <div class="modal-mask">
            <div class="modal-wrapper">
              <div class="modal-dialog">
                <div class="modal-content">
                  <div class="modal-header">
                    <button type="button" class="close" @click="cancelAdding">
                      <span aria-hidden="true">&times;</span>
                    </button>
                    <h4 class="modal-title">Add TODO List</h4>
                  </div>
                  <div class="modal-body">
                    <input id="add-project-input" ref="addProjectInput" @keyup.enter="createProject" class="form-control" type="text" placeholder="Give you list a name"><br>
                    <button class="btn btn-primary btn-block btn-create-project" @click="createProject">Create</button>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </transition>
      </div>
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
      projects: [],
      showProjectModal: false
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
    },

    createProject() {
      const projectInput = this.$refs.addProjectInput.value
      const createProjectUrl = apiUrls.baseURL + apiUrls.projectsAffix
      if (!projectInput) {
        return
      }
      fetch(createProjectUrl, {
        method: "POST",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + localStorage.token
        },
        body: JSON.stringify({
          title: projectInput
        })
      }).then(response => response.json())
      .then(json => this.addRequestSucceed(json))
      .catch(error => console.log(error))
    },

    addRequestSucceed (jsonResponse) {
      this.projects.push(jsonResponse)
      this.cancelAdding()
    },

    cancelAdding() {
      this.$refs.addProjectInput.value = ""
      this.showProjectModal = false
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
