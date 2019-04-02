<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/2/9
  Time: 22:04
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="lib/icheck/icheck.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>
    <%--引入zTree的css--%>
    <link rel="stylesheet" href="lib/zTree/v3/css/zTreeStyle/zTreeStyle.css" type="text/css">
</head>
<body>
<div class="pd-20">
    <form action="" method="post" class="form form-horizontal" id="form-role-update">
        <input type="hidden" name="roleId" value="${sysRole.roleId}"/>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>角色名称：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text" value="${sysRole.roleName}" placeholder="" id="roleName" name="roleName"
                       datatype="*2-8" nullmsg="角色名不能为空">
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3"><span class="c-red">*</span>创建时间：</label>
            <div class="formControls col-5">
                <input type="text" class="input-text Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" value="<fmt:formatDate value="${sysRole.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" placeholder="" id="createTime" name="createTime">

            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">是否有效：</label>
            <div class="formControls col-5"> <span class="select-box" style="width:150px;">
				<select class="select" name="flag" size="1" id="flag">
                    <c:choose>
                        <c:when test="${sysRole.flag}">
                            <option value="1" selected="selected">是</option>
                            <option value="0">否</option>
                         </c:when>
                        <c:otherwise>
                            <option value="1">是</option>
                            <option value="0"  selected="selected">否</option>
                        </c:otherwise>
                    </c:choose>
				</select>
				</span></div>
        </div>
        <div class="row cl">
            <label class="form-label col-3">描述：</label>
            <div class="formControls col-5">
                <textarea name="roleDesc" cols="" rows="" id="roleDesc" class="textarea" placeholder="说点什么...100个字符以内"
                          dragonfly="true" onKeyUp="textarealength(this,100)">${sysRole.roleDesc}</textarea>
                <p class="textarea-numberbar"><em class="textarea-length">0</em>/100</p>
            </div>
            <div class="col-4"></div>
        </div>
        <div class="row cl">
            <div class="col-9 col-offset-3">
                <input class="btn btn-primary radius" type="submit" value="&nbsp;&nbsp;提交&nbsp;&nbsp;">
            </div>
        </div>
    </form>
</div>

<%--装载树的DIV--%>
<div id="menuParent" style="display: none">
    <div id="zTree" class="zTree"></div>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/icheck/jquery.icheck.min.js"></script>
<script type="text/javascript" src="lib/Validform/5.3.2/Validform.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<%--引入zTree的js--%>
<script type="text/javascript" src="lib/zTree/v3/js/jquery.ztree.core-3.5.js"></script>
<%--引入日期插件--%>
<script type="text/javascript" src="/lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript">
    $(function () {
        $('.skin-minimal input').iCheck({
            checkboxClass: 'icheckbox-blue',
            radioClass: 'iradio-blue',
            increaseArea: '20%'
        });

        $("#form-role-update").Validform({
            tiptype: 2,
            callback: function (form) {
                /*
                * 在表单检验成功之后会提交表单
                * */
                $.ajax({
                    url: "sysRole/update",
                    type: "POST",
                    data: $("#form-role-update").serialize(),
                    success: function (data) {
                        var icon;
                        if (data.result) {
                            icon = 6;
                        } else {
                            icon = 5;
                        }
                        //弹出操作提示框
                        layer.alert(data.data, {icon: icon}, function () {
                            //关闭弹出层
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.$('.btn-refresh').click();
                            parent.layer.close(index);

                            //刷新
                            parent.location.reload();
                        });
                    }
                })
                //取消默认的提交方法
                return false;
            }
        });
    });

</script>
</body>
</html>
