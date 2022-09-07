<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>薪资管理</title>
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
        <el-button type="primary" @click="add">添加薪资</el-button>
    </div>

    <div id="tablediv">
        <el-table
                :data="tableData"
                border
                style="width: 100%">
            <el-table-column
                    prop="username"
                    label="员工姓名">
            </el-table-column>
            <el-table-column
                    prop="salary"
                    label="薪资">
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
<!--                     <el-button -->
<!--                             size="mini" -->
<!--                             @click="edit(scope.$index, scope.pkid)">修改 -->
<!--                     </el-button> -->
                    <el-button
                            size="mini"
                            type="danger"
                            @click="deletesalary(scope.row.pkid)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

    </div>

    <el-dialog
            title="新增薪资"
            :visible.sync="dialogVisible"
            width="500px"
            style="min-width: 300px;"
            :before-close="handleClose">
        <span>
            <el-form ref="form" :model="form" label-width="80px">
              <el-form-item label="员工">
				  <el-select v-model="form.id" placeholder="请选择">
				    <el-option
				      v-for="item in employees"
				      :key="item.id"
				      :label="item.username"
				      :value="item.id">
				    </el-option>
				  </el-select>
              </el-form-item>
              <el-form-item label="薪资">
                <el-input v-model="form.salary"></el-input>
              </el-form-item>
              
              <el-form-item>
                <el-button type="primary" @click="save">保存</el-button>
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
                id: '',
                salary: ''
            },
            employees:[],
            tableData: []
        },
        mounted: function () {
            var that = this;
            that.queryAll();
        },
        filters: {},
        watch: {},
        computed: {},
        methods: {
            say: function () {
                this.$message.success("成功了");
            },
            add: function () {
                this.dialogVisible = true;
            },
            handleClose: function () {
                this.dialogVisible = false;
            },
            save: function () {
                var that = this;
                
                if(	that.form.salary == '' ||
                    	that.form.id == ''
                    ){
                    	that.$message.warning("请完整填写信息");
                    	return false;
               	}
                
                that.form['method'] = 'save';
                
                axios.post("SalaryServlet",JSON.stringify(
                	that.form
                ))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.success("保存成功");
						that.queryAll();
						that.dialogVisible = false;
						that.resetForm();
					}else{
						that.$message.warning("保存失败");
					}
                }).catch(error=>{

                });
            },
            queryAllEmployee: function () {
                var that = this;
                
                axios.post("EmployeeServlet",JSON.stringify({
                	method: 'queryAllWithoutSalary'
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.employees = data.list;
					}else{
						that.$message.warning("查询失败");
					}
                }).catch(error=>{

                });
            },
            queryAll: function () {
                var that = this;
                
                axios.post("SalaryServlet",JSON.stringify({
                	method: 'queryAll'
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.tableData = data.list;
			            that.queryAllEmployee();
					}else{
						that.$message.warning("查询失败");
					}
                }).catch(error=>{

                });
            },
            deletesalary: function(id){
            	var that = this;
                axios.post("SalaryServlet",JSON.stringify({
                	method: 'delete',
                	pkid: id
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.success("删除成功");
						that.queryAll();
					}else{
						that.$message.warning("查询失败");
					}
                }).catch(error=>{

                });
            },
            resetForm: function(){
            	this.form = {
                        id: '',
                        salary: ''
                    };
            },
            edit: function(index,pkid){
            	
            },
            handleClose: function(){
            	this.dialogVisible = false;
            }
        }
    })

</script>
</html>
