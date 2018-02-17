<template>
  <div class="project-box">
    <div class="project-title">
        <icon class="calendar-icon" name="calendar-o" scale="1.4"></icon>
        <h5>{{ project.title }}</h5>
        <button class="btn btn-project-edit"><icon name="pencil" scale="1.1"></icon></button>
        <button class="btn btn-project-trash"><icon name="trash" scale="1.1"></icon></button>
    </div>
    <div class="tasks-list">
      <Task v-for="task in tasks" :key="task.id" :task="task"></Task>
    </div>
  </div>
</template>

<script>
import Task from './task'

export default {
  name: 'Project',
  props: ['project'],
  data () {
    return {
      tasks: this.project.tasks
    }
  },
  created () {
  },
  methods: {
  },
  components: {
    Task
  }
}
</script>

<style>
  .project-box {
    margin: 0;
    padding: 0;
    margin-bottom: 30px;
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
