<template>
    <div class="adder-box">
        <button id="show-modal" @click="showModal = true" class="btn btn-plus-task"><icon class="plus-icon" name="plus" scale="1.4"></icon></button>

        <div v-if="showModal">
            <transition name="modal">
              <div class="modal-mask">
                <div class="modal-wrapper">
                  <div class="modal-dialog">
                    <div class="modal-content">
                      <div class="modal-header">
                        <button type="button" class="close" @click="showModal=false">
                          <span aria-hidden="true">&times;</span>
                        </button>
                        <h4 class="modal-title">Modal title</h4>
                      </div>
                      <div class="modal-body">
                        modal body
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </transition>
        </div>

        <input id="add-task-input" ref="addTaskInput" @keyup.enter="createTask()" class="form-control-sm" type="text">
        <button class="btn btn-add-task" @click="createTask()">Add Task</button>
    </div>
</template>

<script>
    import { apiUrls } from '../global_variables'

    export default {
        name: 'TaskAdder',
        data () {
            return {
                showModal: false,
                project: this.$parent.$data
            }
        },
        methods: {
            createTask() {
                const taskInput = this.$refs.addTaskInput.value
                const createTaskUrl = apiUrls.baseURL + apiUrls.projectsAffix + "/" + this.project.id + apiUrls.tasksAffix
                if (!taskInput) {
                    return
                }
                fetch(createTaskUrl, {
                      method: "POST",
                      headers: {
                        'Accept': 'application/json',
                        'Content-Type': 'application/json',
                        'Authorization': "Bearer " + localStorage.token
                      },
                      body: JSON.stringify({
                        name: taskInput,
                        priority: 0
                      })
                }).then(response => response.json())
                  .then(json => this.requestSucceed(json))
                  .catch(error => console.log(error))
            },

            requestSucceed (jsonResponse) {
                console.log(jsonResponse)
                this.$parent.$data.tasks = jsonResponse.tasks
                this.$refs.addTaskInput.value = ""
            }
        }
    }
</script>

<style>
    .adder-box {
        width: 100%;
        height: 45px;
        background: linear-gradient(#ddd, #ccc);
        border: 1px solid #aaa;
    }

    .btn-plus-task {
        background-color: transparent;
        padding: 10px 15px;
        color: #589172;
    }

    .plus-icon.fa-icon {
        filter: drop-shadow( 0px -2px 0px #304538 );
    }

    #add-task-input {
        height: 28px;
        position: relative;
        top: -3px;
        width: calc(100% - 170px);
    }

    .btn-add-task {
        text-shadow: 0px 1px 0px #555;
        background: linear-gradient(#88BFA1, #518668);
        border-radius: 5px;
        border-bottom-left-radius: 0;
        border-top-left-radius: 0;
        border: none;
        height: 26px;
        position: relative;
        padding: 0 20px;
        top: -2px;
        left: -4px;
        font-size: 15px;
        font-weight: bold;
        box-shadow: 0px -1px 0px 1px #518668;
        color: #fff;
    }

    .modal-mask {
      position: fixed;
      z-index: 999;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0, .5);
      display: table;
      transition: opacity .3s ease;
    }

    .modal-wrapper {
      display: table-cell;
      vertical-align: middle;
    }

    .modal-header {
        display: block;
    }
</style>
