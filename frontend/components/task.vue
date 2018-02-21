<template>
  <div class="task-box">
    <input class="status-checkbox" type="checkbox" v-model="task.status" v-bind:id="task.id" @change="toggleStatus">
    <div class="task-name">
      <span v-if="task.status" style="text-decoration: line-through">{{ task.name }}</span>
      <span v-if="!task.status">{{ task.name }}</span>
    </div>
    <div v-if="taskEditing" v-click-outside="updateTask">
      <input id="edit-task-input" type="text" :value="task.name" @keyup.enter="updateTask" @keyup.esc="cancelUpdating" ref="editTaskField">
      <button class="btn btn-close-editing" @click="cancelUpdating"><icon name="times" scale="1"></icon></button>
    </div>
    <button class="btn btn-task-up" @click="increasePriority" data-toggle="tooltip" data-placement="top" :title="'Priority: ' + task.priority + '. Up ↑'"><icon name="caret-up" scale="1"></icon></button>
    <button class="btn btn-task-down" @click="decreasePriority" data-toggle="tooltip" data-placement="top" :title="'Priority: ' + task.priority + '. Down ↓'"><icon name="caret-up" scale="1"></icon></button>
    <button class="btn btn-task-edit" @click="editTask" data-toggle="tooltip" data-placement="top" title="Edit"><icon name="pencil" scale="1"></icon></button>
    <button class="btn btn-task-trash" @click="removeTask" data-toggle="tooltip" data-placement="top" title="Delete"><icon name="trash" scale="1"></icon></button>
  </div>
</template>

<script>
import { apiUrls } from '../global_variables'
import vClickOutside from 'v-click-outside'

    export default {
      name: 'Task',
      props: ['task'],
      directives: {
        clickOutside: vClickOutside.directive
      },
      data () {
        return {
          project: this.$parent.$data,
          taskEditing: false
        }
      },
      methods: {
        removeTask () {
          const removeTaskUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id + apiUrls.tasksAffix + "/" + this.task.id
          fetch(removeTaskUrl, {
                method: "DELETE",
                headers: {
                  'Accept': 'application/json',
                  'Content-Type': 'application/json',
                  'Authorization': "Bearer " + localStorage.token
                }
          }).then(response => response.json())
            .then(json => this.$parent.$data.tasks = json)
        },

        editTask() {
          this.taskEditing = true
          this.$nextTick(() => {
            this.$refs.editTaskField.focus()
          })
        },

        updateTask() {
          const editTaskUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id + apiUrls.tasksAffix + "/" + this.task.id
          const editTaskInput = this.$refs.editTaskField.value
          fetch(editTaskUrl, {
            method: "PUT",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': "Bearer " + localStorage.token
            },
            body: JSON.stringify({
              name: editTaskInput
            })
          }).then(response => response.json())
            // .then(json => console.log(json))
            .catch(error => console.log(error))
          this.task.name = editTaskInput
          this.taskEditing = false
        },

        cancelUpdating() {
          this.taskEditing = false
        },

        toggleStatus() {
          const editTaskUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id + apiUrls.tasksAffix + "/" + this.task.id
          fetch(editTaskUrl, {
            method: "PUT",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': "Bearer " + localStorage.token
            },
            body: JSON.stringify({
              status: this.task.status
            })
          }).then(response => response.json())
            // .then(json => console.log(json))
            .catch(error => console.log(error))
        },

        increasePriority() {
          this.task.priority = parseInt(this.task.priority) + 1
          this.updatePriority()
        },

        decreasePriority() {
          if (this.task.priority == 0) {
            return
          }
          this.task.priority = parseInt(this.task.priority) - 1
          this.updatePriority()
        },

        updatePriority() {
          const editTaskUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id + apiUrls.tasksAffix + "/" + this.task.id
          fetch(editTaskUrl, {
            method: "PUT",
            headers: {
              'Accept': 'application/json',
              'Content-Type': 'application/json',
              'Authorization': "Bearer " + localStorage.token
            },
            body: JSON.stringify({
              priority: this.task.priority
            })
          }).then(response => response.json())
            // .then(json => console.log(json))
            .catch(error => console.log(error))
        }
      }
    }
</script>

<style>
.task-box {
  background: #fff;
  border-bottom: 1px solid #ddd;
  border-right: 1px solid #aaa;
  border-left: 1px solid #aaa;
  position: relative;
}

.task-box:hover {
  background-color: #FAFCD3;
}

.status-checkbox {
  margin: 0 13px 0 18px;
}

.task-box .task-name {
  font-size: 14px;
  color: #666;
  display: inline-block;
  line-height: 45px;
  padding-left: 20px;
  border-left: 1px solid #ddd;
  width: calc(100% - 180px);
}

.task-box .task-name:before,
.task-box .task-name:after {
  content: '';
  height: 45px;
  width: 1px;
  border-right: 1px solid #ddd;
  position: absolute;
}

.task-box .task-name:before {
  left: 53px;
}

.task-box .task-name:after {
  right: 115px;
}

#edit-task-input {
  position: absolute;
  left: 60px;
  top: 2px;
  width: calc(100% - 183px);
}

.btn-close-editing {
  position: absolute;
  right: 120px;
  top: 5px;
  background-color: transparent;
  color: #888;
}

.task-box:hover .btn-task-edit,
.task-box:hover .btn-task-trash,
.task-box:hover .btn-task-up,
.task-box:hover .btn-task-down {
  display: inline-block;
}

.btn-task-edit,
.btn-task-trash,
.btn-task-up,
.btn-task-down {
  display: none;
  background-color: transparent;
  color: #888;
  position: absolute;
}

.btn-task-up,
.btn-task-down {
  right: 75px;
  height: 22px;
}

.btn-task-up {
  top: 2;
}

.btn-task-down {
  bottom: 0px;
  transform: rotate(180deg);
}

.btn-task-edit {
  right: 40px;
  top: 5px;
}

.btn-task-trash {
  right: 5px;
  top: 5px;
}

.btn-task-up:after {
  content: "—";
  position: absolute;
  right: 9px;
  bottom: -13px;
}

.btn-task-edit:before {
  content: "|";
  position: absolute;
  left: 0;
  top: 3px;
}

.btn-task-edit:after {
  content: "|";
  position: absolute;
  right: 0;
  top: 3px;
}

.task-box:last-child {
  border-bottom-right-radius: 20px;
  border-bottom-left-radius: 20px;
  border-bottom: 1px solid #aaa;
}
</style>
