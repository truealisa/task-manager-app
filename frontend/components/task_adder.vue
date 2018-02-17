<template>
    <div class="adder-box">
        <button class="btn btn-plus-task"><icon class="plus-icon" name="plus" scale="1.4"></icon></button>
        <input class="add-task-input form-control-sm" type="text">
        <button class="btn btn-add-task">Add Task</button>
    </div>
</template>

<script>
    export default {
        name: 'TaskAdder'
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

    .add-task-input {
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
</style>
