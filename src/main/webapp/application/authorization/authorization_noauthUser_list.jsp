<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/18
  Time: 17:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css"/>
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css"/>
    <link href="css/style.css" rel="stylesheet" type="text/css"/>
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css"/>

</head>
<body id="userBody">
<div class="pd-20">

    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-4">
                用户名称: <input type="text" class="input-text" style="width: 250px" id="userName" value="${userName}">
            </div>

        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" id="" name="" onclick="selectByCondition()">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>

    <div class="cl pd-5 bg-1 bk-gray">
        <a href="javascript:;" onclick="batchAdd()" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 批量授权</a>
    </div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="9">用户管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">用户ID</th>
            <th width="100">用户名称</th>
            <th width="100">电话</th>
            <th width="100">邮箱</th>
            <th width="100">生日</th>
            <th width="100">是否有效</th>
            <th width="200">个人简介</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach items="${pageInfo.list}" var="sysUser">
            <tr class="text-c">
                <td><input type="checkbox" class="addBox" value="${sysUser.userId}" name=""></td>
                <td>${sysUser.userId}</td>
                <td>${sysUser.userName}</td>
                <td>${sysUser.phone}</td>
                <td>${sysUser.email}</td>
                <td>
                    <fmt:formatDate value="${sysUser.birthday}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                </td>
                <td>
                    <c:if test="${sysUser.flag}">
                        是
                    </c:if>
                    <c:if test="${!sysUser.flag}">
                        否
                    </c:if>
                </td>
                <td>${sysUser.introduce}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <%--装展示分页导航的容器--%>
    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="userBody"></jsp:param>
    </jsp:include>

</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>

<script type="text/javascript">

    /*批量授权*/
    function batchAdd() {

        layer.confirm('确定要授权这些用户吗？', function (index) {
            var checkes = $(".addBox:checked");
            if (checkes.length == 0) {
                layer.msg('您没有选择要授权用户！', {icon: 2, time: 2000});
                return;
            }
            //得到一堆的ID，把它们装起来
            var ids = [];
            for (var i = 0; i < checkes.length; i++) {
                ids.push(checkes[i].value);
            }
            //发送ajaxj请求去后端做一个批量修改的操作
            $.ajax({
                url: "authorization/batchAddUserToRole",
                type: "POST",
                data: "idList=" + ids+"&roleId="+${roleId},
                success: function (data) {
                    //根据返回标识给出相应的提示
                    if (data.result) {
                        layer.msg('授权用户成功!', {icon: 1, time: 2000},function () {
                            location.reload();
                        });
                    } else {
                        layer.msg('授权用户失败!', {icon: 2, time: 2000});
                    }
                }
            })
        });
    }

    /*
    通过条件查询分页信息
     */
    function selectByCondition() {
        var userName = $("#userName").val();

        //加载分页的集合数据，在body中展示
        $("#userBody").load("authorization/queryNoAuthUserByRoleId",{"userName":userName,"roleId":"${roleId}"});
    }
</script>
</body>
</html>
