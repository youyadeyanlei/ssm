<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>员工管理</title>
    <style>

        body {
            padding: 0px;
            margin: 0px;
            width: 100%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-content: center;
        }

        .container {
            margin: 0px;
            padding: 0px;
            margin-left: 2%;
            margin-top: 2%;
            width: 95%;
            height: 90%;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-content: center;
        }

        #opdiv {
            height: 20%;
            width: 100%;
        }

        #tablediv {
            margin-top: 2%;
            height: 70%;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="container" id="container">

    <div id="opdiv">
        <el-button type="primary" @click="add">新增员工</el-button>
    </div>

    <div id="tablediv">
        <el-table
                :data="tableData"
                border
                style="width: 100%">
            <el-table-column
                    prop="username"
                    label="姓名">
            </el-table-column>
            <el-table-column
                    prop="gender"
                    label="性别">
            </el-table-column>
            <el-table-column
                    prop="job"
                    label="职位">
            </el-table-column>
            <el-table-column
                    prop="birthday"
                    label="出生日期">
            </el-table-column>        
            <el-table-column
                    prop="startjob"
                    label="入职时间">
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
                    <el-button
                            size="mini"
                            @click="edit(scope.$index)">修改
                    </el-button>
                    <el-button
                            size="mini"
                            type="danger"
                            @click="deleteEmployee(scope.row.id)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

    </div>

    <el-dialog
            title="编辑员工"
            :visible.sync="dialogVisible"
            width="550px"
            :before-close="handleClose">
        <span>
            <el-form ref="form" :model="form" label-width="80px">
              <el-form-item label="姓名">
                <el-input v-model="form.username"></el-input>
              </el-form-item>
              <el-form-item label="性别">
                <el-select v-model="form.gender" placeholder="请选择员工性别">
                  <el-option label="男" value="男"></el-option>
                  <el-option label="女" value="女"></el-option>
                </el-select>
              </el-form-item>
              <el-form-item label="职位">
                <el-input v-model="form.job"></el-input>
              </el-form-item>
              <el-form-item label="出生日期">
                  <el-col :span="11">
                    <el-date-picker type="date" value-format="yyyy-MM-dd" placeholder="选择日期" v-model="form.birthday" style="width: 100%;"></el-date-picker>
                  </el-col>
              </el-form-item>
              <el-form-item label="入职时间">
                  <el-col :span="11">
                    <el-date-picker type="date" value-format="yyyy-MM-dd" placeholder="选择日期" v-model="form.startjob" style="width: 100%;"></el-date-picker>
                  </el-col>
              </el-form-item>
              <el-form-item>
                <el-button type="primary" @click="save" v-if="(!modify)">保存</el-button>
                <el-button type="primary" @click="update" v-if="modify">保存</el-button>
                <el-button @click="handleClose">取消</el-button>
              </el-form-item>
            </el-form>
        </span>
    </el-dialog>

</div>


</body>

<!-- 引入vue -->
<script src="./js/vue.js"></script>
<!-- 引入Element-ui样式 -->
<link rel="stylesheet" href="./css/elmindex.css">
<!-- 引入Element-ui组件库 -->
<script src="./js/elmindex.js"></script>
<!-- 引入axios插件 -->
<script src="./js/axios.min.js"></script>


<script>

    var app = new Vue({
        el: '#container',
        data: {
            message: 'Hello Vue!',
            dialogVisible: false,
            form: {
            	id: 0,
                username: '',
                job: '',
                gender: '',
                birthday: '',
                startjob: ''
            },
            tableData: [],
            modify: false
        },
        mounted: function () {
            var that = this;
            that.queryAll();
        },
        filters: {},
        watch: {},
        computed: {},
        methods: {
            queryAll: function () {
                var that = this;
                
                axios.post("EmployeeServlet",JSON.stringify({
                	method: 'queryAll'
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.tableData = data.list;
					}else{
						that.$message.warning("查询失败");
					}
                }).catch(error=>{

                });
            },
            add: function () {
            	var that = this;
            	that.modify = false;
            	that.id = 0;
            	that.dialogVisible = true;
            },
            handleClose: function () {
                this.dialogVisible = false;
            },
            save: function () {
                var that = this;
                if(	that.form.username == '' ||
                	that.form.job == '' ||	
                	that.form.gender == '' ||	
                	that.form.birthday == '' ||	
                	that.form.startjob == ''
                ){
                	that.$message.warning("请完整填写信息");
                	return false;
                }
                
                
                that.form['method'] = 'save';
                axios.post("EmployeeServlet",JSON.stringify(that.form))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.success("保存成功");
						that.dialogVisible = false;
						that.resetForm();
						that.queryAll();
					}else{
						that.$message.warning("保存失败");
					}
                }).catch(error=>{

                });
            },
            resetForm: function(){
            	this.form =  {
                        username: '',
                        job: '',
                        gender: '',
                        birthday: '',
                        startjob: ''
                    };
            },
            deleteEmployee: function(arg1){
            	var that = this;
                axios.post("EmployeeServlet",JSON.stringify({
                	method: 'delete',
                	id: arg1
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.warning("删除成功");
						that.queryAll();
					}else{
						that.$message.warning("删除失败");
					}
                }).catch(error=>{

                });
            	
            },
            edit: function(num){
            	var that = this;
            	var employee = that.tableData[num];
            	that.form = {
            		id: employee.id,	
                    username: employee.username,
                    job: employee.job,
                    gender: employee.gender,
                    birthday: employee.birthday,
                    startjob: employee.startjob
                 }
            	that.modify = true;
            	that.dialogVisible = true;
            },
            update: function(){
                var that = this;
                
                if(	that.form.username == '' ||
                    	that.form.job == '' ||	
                    	that.form.gender == '' ||	
                    	that.form.birthday == '' ||	
                    	that.form.startjob == ''
                    ){
                    	that.$message.warning("请完整填写信息");
                    	return false;
                    }
                
                
                that.form['method'] = 'update';
                axios.post("EmployeeServlet",JSON.stringify(that.form))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.success("修改成功");
						that.dialogVisible = false;
						that.resetForm();
						that.queryAll();
					}else{
						that.$message.warning("修改失败");
					}
                }).catch(error=>{

                });
            },
            handleClose: function(){
            	this.dialogVisible = false;
            }
        }
    })

</script>
</html>
