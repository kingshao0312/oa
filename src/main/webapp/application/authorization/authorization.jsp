<%--
  Created by IntelliJ IDEA.
  User: asus
  Date: 2019/3/22
  Time: 9:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <base href="<%=request.getContextPath()+"/"%>">
    <link href="css/H-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="css/H-ui.admin.css" rel="stylesheet" type="text/css" />
    <link href="css/style.css" rel="stylesheet" type="text/css" />
    <link href="lib/Hui-iconfont/1.0.1/iconfont.css" rel="stylesheet" type="text/css" />
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 管理员管理 <span class="c-gray en">&gt;</span> 管理员列表 <a class="btn btn-success radius r mr-20" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="pd-20">
    <div class="text-c">
        <div class="row cl ">
            <div class="formControls col-6">
                角色:
               <select id="role">
                   <option value="-1">请选择</option>
                   <c:forEach items="${sysRoleList}" var="role">
                       <option value="${role.roleId}">${role.roleName}</option>
                   </c:forEach>
               </select>
            </div>
            <div class="formControls col-6">
                类型:
                <select id="type">
                        <option value="-1">请选择</option>
                        <option value="1">用户</option>
                        <option value="2">菜单</option>
                </select>
            </div>
        </div>
        <div class="row cl">
            <div class="cl pd-5">
                <button type="button"
                        class="btn btn-success radius" id="query" name="">
                    <i class="Hui-iconfont">&#xe665;</i> 搜索
                </button>
            </div>
        </div>
    </div>
    <div class="cl pd-5 bg-1 bk-gray mt-20">
        <span class="l">
            <a href="javascript:;" onclick="add_role_user('授权新用户','authorization/queryNoAuthUserByRoleId','1000','500')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 授权新用户</a>
            <a href="javascript:;" onclick="add_role_menu('授权新菜单','authorization/queryNoAuthMenuByRoleId','1000','500')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 授权新菜单</a>
        </span>
    </div>

    <%--动态填充用户，菜单的列表信息--%>
    <table class="table table-border table-bordered table-bg" id="authorization">

    </table>
</div>
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="lib/layer/1.9.3/layer.js"></script>
<script type="text/javascript" src="lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript" src="lib/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="js/H-ui.js"></script>
<script type="text/javascript" src="js/H-ui.admin.js"></script>
<script type="text/javascript">

    /*实现搜索功能 */
    $(function(){
        $("#query").click(function(){
            //判断用户和类型是否有选择
            var role = $("#role").val();
            var type = $("#type").val();

            if(role==-1){
                layer.msg("请选择角色!",{icon:2,time:2000})
                return;
            }else if(type==-1){
                layer.msg("请选择类型!",{icon:2,time:2000})
                return;
            }

            //判断选择的类型
            if(type==1){
                //查询这个角色下面的用户信息
                $("#authorization").load("authorization/qyAuthUserByRoleIuerd",{"roleId":role});
            }else{
                //查询这个角色下面的菜单信息
                $("#authorization").load("authorization/queryAuthMenuByRoleId",{"roleId":role});
            }
        })
    })


    /*给角色授权新用户*/
    function add_role_user(title,url,w,h){
        //判断用户和类型是否有选择
        var role = $("#role").val();
        var type = $("#type").val();

        if(role==-1){
            layer.msg("请选择角色!",{icon:2,time:2000})
            return;
        }else if(type==-1){
            layer.msg("请选择类型!",{icon:2,time:2000})
            return;
        }

        //判断是否选择的类型是用户
        if(type==1){
            //authorization/queryNoAuthUserByRoleId?roleId=1
            url = url+"?roleId="+role;
            layer_show(title,url,w,h);
        }else{
            layer.msg("请选择用户!",{icon:2,time:2000})
        }


    }

    /*给角色授权新菜单*/
    function add_role_menu(title,url,w,h){
        layer_show(title,url,w,h);
    }

</script>
</body>
</html>
