<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/2/9
  Time: 15:55
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
<body id="roleBody">
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span
        class="c-gray en">&gt;</span> 角色管理 <a class="btn btn-success radius r mr-20"
                                              style="line-height:1.6em;margin-top:3px"
                                              href="javascript:location.replace(location.href);" title="刷新"><i
        class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
        <%--加入搜索功能--%>
            <div class="text-c">
                <div class="row cl ">
                    <div class="formControls col-4">
                        角色名称: <input type="text" value="${sysRole.roleName}" class="input-text" style="width: 250px" id="roleName" name="roleName"/>
                    </div>
                </div>
                <div class="row cl">
                    <div class="cl pd-5">
                        <button type="button"
                                class="btn btn-success radius" id="" name="" onclick="queryRoleInfo()">
                            <i class="Hui-iconfont">&#xe665;</i> 搜索
                        </button>
                    </div>
                </div>
            </div>

    <div class="cl pd-5 bg-1 bk-gray"> <span class="l">
        <a href="javascript:;" onclick="batchDel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
        <a class="btn btn-primary radius" href="javascript:;" onclick="admin_role_add('添加角色','sysRole/toAdd','800')"><i
                class="Hui-iconfont">&#xe600;</i> 添加角色</a> </span>
        <span class="r">共有数据：<strong>${pageInfo.total}</strong> 条</span></div>
    <table class="table table-border table-bordered table-hover table-bg">
        <thead>
        <tr>
            <th scope="col" colspan="7">角色管理</th>
        </tr>
        <tr class="text-c">
            <th width="25"><input type="checkbox" value="" name=""></th>
            <th width="40">ID</th>
            <th width="100">角色名</th>
            <th width="100">描述</th>
            <th width="100">是否有效</th>
            <th width="100">创建时间</th>
            <th width="10">操作</th>
        </tr>
        </thead>
        <tbody>

        <c:forEach items="${pageInfo.list}" var="role">
            <tr class="text-c">
                <td><input type="checkbox" value="${role.roleId}" name="" class="delBox"></td>
                <td>${role.roleId}</td>
                <td>${role.roleName}</td>
                <td>${role.roleDesc}</td>
                    <c:choose>
                        <c:when test="${role.flag}">
                             <td>是</td>
                        </c:when>
                        <c:otherwise>
                             <td>否</td>
                        </c:otherwise>
                     </c:choose>
                <td><fmt:formatDate value="${role.createTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                <td class="f-14"><a title="编辑" href="javascript:;" onclick="admin_role_edit('角色编辑','sysRole/updateRole/${role.roleId}','600')" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
                    <a title="删除" href="javascript:;" onclick="admin_role_del(this,${role.roleId})" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
                </tr>
        </c:forEach>
        </tbody>
    </table>

    <jsp:include page="/application/common/page.jsp">
        <jsp:param name="bodyId" value="roleBody"/>
    </jsp:include>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>


<script type="text/javascript">
    /*管理员-角色-添加*/
    function admin_role_add(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-角色-编辑*/
    function admin_role_edit(title, url, w, h) {
        layer_show(title, url, w, h);
    }

    /*管理员-角色-删除*/
    function admin_role_del(obj, id) {
        layer.confirm('角色删除须谨慎，确认要删除吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                url: "sysRole/delRole",
                data: "roleId=" + id,
                success: function (data) {
                    if (data.result) {
                        $(obj).parents("tr").remove();
                        layer.msg('删除成功!', {icon: 1, time: 2000},function () {
                            location.reload();
                        });
                    } else {
                        layer.msg('删除失败!', {icon: 2, time: 2000});
                    }
                }
            })


        });
    }

    /*批量删除*/
    function batchDel() {
        var checkedBox = $(".delBox:checked");
        if (checkedBox.length == 0) {
            return;
        }
        //获取到选中的复选框的id值
        var ids = [];
        for (var i = 0; i < checkedBox.length; i++) {
            ids.push(checkedBox[i].value);
        }
        //发送异步请求去删除数据
        layer.confirm('角色删除须谨慎，确认要删除吗？', function (index) {
            //此处请求后台程序，下方是成功后的前台处理……
            $.ajax({
                url: "sysRole/batchDel",
                data: "idList=" + ids,
                success: function (data) {
                    //返回删除成功与否的标识
                    if (data.result) {
                        layer.msg('已删除!', {icon: 1, time: 2000},function () {
                            location.reload();
                        });

                    } else {
                        layer.msg('删除失败!', {icon: 2, time: 2000});
                    }
                }
            })
        });
    }

    /**
     * 查询角色信息
     */
    function queryRoleInfo() {
        var roleName = $("#roleName").val();

        /*加载有查询条件的分页页面数据*/
        $("#roleBody").load("sysRole/queryRolePageByCondition",{"roleName":roleName},function () {});
    }
</script>
</body>
</html>
