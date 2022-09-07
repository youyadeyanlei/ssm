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
        <el-button type="primary" @click="add">新增考勤</el-button>
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
                    prop="starttime"
                    label="上班时间">
            </el-table-column>
            <el-table-column
                    prop="endtime"
                    label="下班时间">
            </el-table-column>
            <el-table-column
                    prop="remark"
                    label="备注"> 
            </el-table-column>
            <el-table-column label="操作">
                <template slot-scope="scope">
<!--                     <el-button -->
<!--                             size="mini" -->
<!--                             @click="edit(scope.$index, scope.row.pkid,scope.row.id)">编辑 -->
<!--                     </el-button> -->
                    <el-button
                            size="mini"
                            type="danger"
                            @click="deleteattend(scope.row.pkid)">删除
                    </el-button>
                </template>
            </el-table-column>
        </el-table>

    </div>

    <el-dialog
            title="新增签到"
            :visible.sync="dialogVisible"
            width="500px"
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
                            
              <el-form-item label="上班时间">
                  <el-col :span="11">
                    <el-date-picker type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择日期" v-model="form.starttime" style="width: 100%;"></el-date-picker>
                  </el-col>
              </el-form-item>
              <el-form-item label="下班时间">
                  <el-col :span="11">
                    <el-date-picker type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="选择日期" v-model="form.endtime" style="width: 100%;"></el-date-picker>
                  </el-col>
              </el-form-item>
              <el-form-item label="备注">
                <el-input v-model="form.remark"></el-input>
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
                starttime: '',
                endtime: '',
                remark: ''
            },
            employees:[],
            tableData: []
        },
        mounted: function () {
            var that = this;
            that.queryAllEmployee();
            that.queryAll();
        },
        filters: {},
        watch: {},
        computed: {},
        methods: {
            say: function () {
                this.$message.success("成功了");
            },
            queryAllEmployee: function () {
                var that = this;
                
                axios.post("EmployeeServlet",JSON.stringify({
                	method: 'queryAll'
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
            add: function () {
                this.dialogVisible = true;
            },
            handleClose: function () {
                this.dialogVisible = false;
            },
            save: function () {
                var that = this;
                
                if(	that.form.username == '' ||
                    	that.form.starttime == '' ||	
                    	that.form.id == '' ||	
                    	that.form.endtime == ''
                    ){
                    	that.$message.warning("请完整填写信息");
                    	return false;
               	}
                
                that.form['method'] = 'save';
                
                axios.post("AttendServlet",JSON.stringify(
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
            deleteattend: function(arg1){
            	var that = this;
                axios.post("AttendServlet",JSON.stringify({
                	method: 'delete',
                	pkid: arg1
                }))
                .then(res=>{
					var data = res.data;
					if(data.success){
						that.$message.success("删除成功");
						that.queryAll();
					}else{
						that.$message.warning("删除失败");
					}
                }).catch(error=>{

                });
            	
            },
            queryAll: function(){
                var that = this;
                
                axios.post("AttendServlet",JSON.stringify({
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
            resetForm: function(){
            	this.form = {
                        id: '',
                        starttime: '',
                        endtime: '',
                        remark: ''
                    };
            },
            handleClose: function(){
            	this.dialogVisible = false;
            }
        }
    })

</script>
</html>
