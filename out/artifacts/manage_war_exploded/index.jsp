<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <title>员工信息管理系统 - 登录</title>
    <link href="css/bootstrap.min.css" rel="stylesheet">
    <link href="css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="css/animate.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
    <link href="css/login.css" rel="stylesheet">
    <!--[if lt IE 9]>
    <meta http-equiv="refresh" content="0;ie.html" />
    <![endif]-->
    <script>
        if (window.top !== window.self) {
            window.top.location = window.location;
        }
    </script>
    <style>
        .formDiv{
            padding: 30px;
            border-radius: 5px;
            background: rgba(176, 176, 176, 0.2);
        }
    </style>
</head>

<body class="signin">
    <div id="container" class="signinpanel">
        <div class="row">
            <div class="col-sm-7">
                <div class="signin-info">
                    <div class="logopanel m-b">
                        <h1>[ H+ ]</h1>
                    </div>
                    <div class="m-b"></div>
                    <h4>欢迎使用 <strong>员工信息管理系统</strong></h4>
                    <ul class="m-b">
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势一</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势二</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势三</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势四</li>
                        <li><i class="fa fa-arrow-circle-o-right m-r-xs"></i> 优势五</li>
                    </ul>
<!--                     <strong>还没有账号？ <a href="#">立即注册&raquo;</a></strong> -->
                </div>
            </div>
            <div class="col-sm-5">
                <div class="formDiv">
                    <h4 class="no-margins">登录：</h4>
                    <p class="m-t-md">登录到员工信息管理系统</p>
                    <input type="text" v-model="uname" class="form-control uname" placeholder="用户名" />
                    <input type="password" v-model="upass" class="form-control pword m-b" placeholder="密码" />
<!--                     <a href="">忘记密码了？</a> -->
                    <button class="btn btn-success btn-block" @click="login">登录</button>
                </div>
            </div>
        </div>
        <div class="signup-footer">
            <div class="pull-left">
                &copy; 2015 All Rights Reserved. H+
            </div>
        </div>
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
            uname: '',
            upass: ''
        },
        mounted: function () {
            var that = this;
        },
        filters: {},
        watch: {},
        computed: {},
        methods: {
            say: function(){

            },
            login: function () {
                var that = this;
                axios.post("LoginServlet",{
                    uname: that.uname,
                    upass: that.upass
                }).then(res=>{
                	var data = res.data;
                	console.log(data.canlogin);
                	if(data.success){
                		window.location = "main.jsp";
                	}else{
                		that.$message.warning('用户名或密码错误');
                	};
                	
                }).catch(error=>{
                	console.log(error);
					alert("请求出错");
                });


            },
            stopsubmit: function (arg) {
                return false;
            }
        }
    })


</script>

</html>
