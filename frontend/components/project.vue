<template>
  <div class="project-box">
    <div class="project-title">
      <icon class="calendar-icon" name="calendar-o" scale="1.4"></icon>
      <h5>{{ project.title }}</h5>
      <button class="btn btn-project-edit" @click="editProject" data-toggle="tooltip" data-placement="top" title="Edit"><icon name="pencil" scale="1.1"></icon></button>
      <div v-if="projectEditing" v-click-outside="updateProject">
        <input id="edit-project-input" type="text" :value="project.title" @keyup.enter="updateProject" @keyup.esc="cancelUpdating" ref="editProjectField">
        <button class="btn btn-close-editing" @click="cancelUpdating"><icon name="times" scale="1"></icon></button>
      </div>
      <button class="btn btn-project-trash" @click="removeProject" data-toggle="tooltip" data-placement="top" title="Delete"><icon name="trash" scale="1.1"></icon></button>
    </div>
    <TaskAdder></TaskAdder>
    <div class="tasks-list">
      <Task v-for="task in sortedTasks" :key="task.id" :task="task"></Task>
    </div>
  </div>
</template>

<script>
import Task from './task'
import TaskAdder from './task_adder'
import { apiUrls } from '../global_variables'
import vClickOutside from 'v-click-outside'

export default {
  name: 'Project',
  props: ['project'],
  data () {
    return {
      tasks: this.project.tasks,
      id: this.project.id,
      title: this.project.title,
      projectEditing: false
    }
  },
  directives: {
    clickOutside: vClickOutside.directive
  },
  methods: {
    removeProject () {
      const removeProjectUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id
      fetch(removeProjectUrl, {
        method: "DELETE",
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + localStorage.token
        }
      }).then(response => response.json())
      .then(json => this.$parent.$data.projects = json)
    },

    editProject() {
      this.projectEditing = true
      this.$nextTick(() => {
        this.$refs.editProjectField.focus()
      })
    },

    updateProject() {
      const editProjectUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id
      const editProjectInput = this.$refs.editProjectField.value
      if (editProjectInput) {
        fetch(editProjectUrl, {
          method: "PUT",
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
            'Authorization': "Bearer " + localStorage.token
          },
          body: JSON.stringify({
            title: editProjectInput
          })
        }).then(response => response.json())
        .catch(error => console.log(error))
        this.project.title = editProjectInput
        this.projectEditing = false
      }
    },

    cancelUpdating() {
      this.projectEditing = false
    }
  },
  computed: {
    sortedTasks: function () {
      return this.tasks.sort((a, b) => a.priority - b.priority).sort((a, b) => a.status - b.status)
    }
  },
  components: {
    Task,
    TaskAdder
  }
}
</script>

<style>
.project-box {
  margin: 0;
  padding: 0;
  margin-bottom: 40px;
}

.calendar-icon.fa-icon {
  color: #333;
  margin-right: 10px;
  margin-left: 10px;
  transform: translateY(2px);
  filter: drop-shadow( 1px 1px 0px #aaa );
}

.project-title {
  display: block;
  position: relative;
  width: 100%;
  background: linear-gradient(#4A80B8, #35619E);
  padding: 7px;
  border-radius: 2px;
  border-top-color: #8AAFD4;
  box-shadow: 0px -1px 0px 0px #8AAFD4,
  0px -1px 0px 1px #35619E;
}

.project-title h5 {
  display: inline-block;
  font-size: 21px;
  color: #fff;
  text-shadow: 0px 1px 0px #555;
  margin: 0;
  padding: 0;
}

.project-title:hover .btn-project-edit,
.project-title:hover .btn-project-trash {
  display: inline-block;
}

.btn-project-edit,
.btn-project-trash {
  display: none;
  background-color: transparent;
  padding: 5px 5px 0;
  color: #97AED0;
  position: absolute;
}

.btn-project-edit {
  right: 50px;
}

.btn-project-trash {
  right: 15px;
  top: 7px;
}

.btn-project-edit:after {
  content: "|";
  position: absolute;
  right: -7px;
  top: 1px;
}

#edit-project-input {
  position: absolute;
  left: 52px;
  top: 1px;
  width: calc(100% - 169px);
}

.btn-close-editing {
  position: absolute;
  right: 120px;
  top: 5px;
  background-color: transparent;
  color: #888;
}
</style>
