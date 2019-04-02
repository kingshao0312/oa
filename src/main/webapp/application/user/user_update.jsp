<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/19
  Time: 11:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<base href="<%=request.getContextPath()+"/"%>">
<link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
<link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
<link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css" />
<link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
<%--引入zTree的css--%>
<link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
<head>
    <title>Title</title>
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-user-add">
        <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>用户名称：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.userName}" placeholder="" id="userName" name="userName" datatype="*2-16" nullmsg="用户名称不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>密码：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.userPassword}" placeholder="" id="userPassword" name="userPassword" datatype="*2-16" nullmsg="用户名称不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>邮箱：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.email}" placeholder="" id="email" name="email" datatype="*2-16" nullmsg="密码不能为空">
        </div>
        <div class="col-4"> </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3"><span class="c-red">*</span>手机：</label>
        <div class="formControls col-5">
            <input type="text" class="input-text" value="${sysUser.phone}" placeholder="" id="phone" name="phone" datatype="m" errormsg="手机号码错误" nullmsg="手机不能为空">
        </div>
        <div class="col-4"> </div>
    </div>

    <div class="row cl">
        <label class="form-label col-3">生日：</label>
        <div class="formControls col-5">
            <input id="d11" class="input-text Wdate" value="<fmt:formatDate value="${sysUser.birthday}" pattern="yyyy-MM-dd"/>" name="birthday" type="text" onClick="WdatePicker({maxDate:'%y-%M-%d'})"/>

        </div>
    </div>
    <div class="row cl">
        <label class="form-label col-3">个人简介：</label>
        <div class="formControls col-5">
            <textarea name="introduce" id="introduce" cols="" rows="" class="textarea"  placeholder="说点什么...100个字符以内" dragonfly="true" onKeyUp="textarealength(this,100)">
                ${sysUser.introduce}
            </textarea>
            <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
        </div>
        <div class="col-4"> </div>
    </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>

<%--装树的一个容器--%>
<div id="orgParentTree" style="display: none">
    <div id="zTree" class="ztree"></div>
</div>

<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<%--日期控制的js--%>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<%--引入zTree的js--%>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript">
    $(function(){
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-user-add").Validform({
            tiptype:2,
            callback:function(form){
                //表单验证通过之后，点击添加才会进入这个方法
                //通过ajax请求提交表单数据
                $.ajax({
                    url:"sysUser/add",
                    type:"POST",
                    data:$("#form-user-add").serialize(),
                    success:function (data) {
                        var icon;
                        if(data.result){
                            icon = 6;
                        }else{
                            icon = 5;
                        }
                        layer.alert(data.data, {icon: icon},function () {
                            //关闭弹出框
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.$('.btn-refresh').click();
                            parent.layer.close(index);

                            //刷新页面
                            parent.location.reload();
                        });

                    }
                })

                return false;
            }
        });
    });

    function selectOrgParent() {
        //弹出一个提示框（有一个树）
        var index = layer.open({
            title:"选择父用户",
            type:1,
            content: $("#orgParentTree"),
            area: ['500px', '300px'],
            btn:"确定"
        });
        //渲染
        //通过ajax请求去查询用户的信息(List)
        $.ajax({
            url:"sysOrg/list",
            type:"POST",
            success:function (data) {
                var zTreeObj;
                var setting = {
                    data: {
                        key: {
                            name: "orgName"
                        },
                        simpleData: {
                            enable: true,
                            idKey: "orgId",
                            pIdKey: "orgParentId",
                        }
                    },
                    callback: {
                        onClick: function (event, treeId, treeNode) {
                            $("#orgParentName").val(treeNode.orgName);
                            $("#orgParentId").val(treeNode.orgId);
                        }
                    }
                    
                };
                var zNodes = data;
                $(document).ready(function(){
                    zTreeObj = $.fn.zTree.init($("#zTree"), setting, zNodes);
                });
            }
        })

    }
</script>
</body>
</html>
