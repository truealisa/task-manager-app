<template>
  <div class="project-box">
    <div class="project-title">
      <icon class="calendar-icon" name="calendar-o" scale="1.4"></icon>
      <h5>{{ project.title }}</h5>
      <button class="btn btn-project-edit" data-toggle="tooltip" data-placement="top" title="Edit"><icon name="pencil" scale="1.1"></icon></button>
      <button class="btn btn-project-trash" data-toggle="tooltip" data-placement="top" title="Delete"><icon name="trash" scale="1.1"></icon></button>
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

export default {
  name: 'Project',
  props: ['project'],
  data () {
    return {
      tasks: this.project.tasks,
      id: this.project.id
    }
  },
  created () {
  },
  methods: {
  },
  computed: {
    sortedTasks: function () {
      return this.tasks.sort((a, b) => b.priority - a.priority).sort((a, b) => a.status - b.status)
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
  }

  .btn-project-edit:after {
    content: "|";
    position: absolute;
    right: -7px;
    top: 1px;
  }
</style>
