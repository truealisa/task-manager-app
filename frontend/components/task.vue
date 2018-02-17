<template>
  <div class="task-box">
    <input class="status-checkbox" type="checkbox">
    <div class="task-name">{{ task.name }}</div>
    <button class="btn btn-task-up"><icon name="caret-up" scale="1"></icon></button>
    <button class="btn btn-task-down"><icon name="caret-up" scale="1"></icon></button>
    <button class="btn btn-task-edit"><icon name="pencil" scale="1"></icon></button>
    <button class="btn btn-task-trash"><icon name="trash" scale="1"></icon></button>
  </div>
</template>

<script>
    export default {
      name: 'Task',
      props: ['task'],
      data () {
        return {
        }
      },
      methods: {
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
