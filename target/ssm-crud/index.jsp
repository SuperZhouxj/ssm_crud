<%--
  Created by IntelliJ IDEA.
  User: zxj
  Date: 2019/9/17
  Time: 8:45
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>员工</title>
    <%
        pageContext.setAttribute("APP_PATH",request.getContextPath());
    %>
    <script src="${APP_PATH}/static/js/jquery-3.4.1.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7/js/bootstrap.min.js"></script>

</head>
<body>

<!-- 员工修改的静态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >修改员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10 ">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@comac.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">
                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_save">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的静态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">添加员工</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10 ">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@comac.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default " data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary " id="emp_add_save">保存</button>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!--标题 -->
    <div class="row">
        <div class="col-md-12">
            <h1>SSM_CURD</h1>
        </div>
    </div>
    <!-- 按钮 -->
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_btn">删除</button>
        </div>
    </div>
    <!-- 显示表格数据 -->
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th><input type="checkbox" id="check_all"/></th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
               <tbody>

               </tbody>

            </table>
        </div>
    </div>
    <!-- 分页信息 -->

    <div class="row">
        <div class="col-md-6" id="page_info_area">
        </div>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>

</div>
<script type="text/javascript">
    //1.分页加载完成以后，直接去发送ajax请求，要到分页数据
    var totalRecord,currentPage;
    $(function () {
        to_page(1);
    });

   function to_page(pn) {
       $.ajax({
           url:"${APP_PATH}/emps",
           data:"pn="+pn,
           type:"GET",
           success:function (result) {
               // console.log(result);
               //解析并显示员工数据
               build_emp_table(result);
               //解析显示分页信息
               build_page_info(result);
               //解析并显示分页信息
               build_page_nav(result);
           }
       });
   };

    function build_emp_table(result) {
        //清空表格
        $("#emps_table tbody").empty();
        var emps = result.entend.pageInfo.list;
        $.each(emps,function (index,item) {
            //alert(item.empName);
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>")
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            var editButtonTd = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            editButtonTd.attr("edit_id",item.empId);
            var delButtonTd = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delButtonTd.attr("delete_id",item.empId);
            var buttonTd = $("<td></td>").append(editButtonTd).append(" ").append(delButtonTd);
            //append方法执行完成以后还是返回原来的元素
            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(buttonTd)
                .appendTo("#emps_table tbody");
        });
    }
    function build_page_info(result) {
        $("#page_info_area").empty();

        var emps = result.entend.pageInfo;
        $("#page_info_area").append("当前 " + emps.pageNum + " 页 / 总 " + emps.pages +
            " 页 / 总 " + emps.total + " 记录");
        totalRecord =emps.total;
        currentPage= emps.pageNum;
    }
    function build_page_nav(result) {
        $("#page_nav_area").empty();

        var ul = $("<ul></ul>").addClass("pagination");
        var pageInfo = result.entend.pageInfo;
        var firstPage = $("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePage = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#}"));
        if(pageInfo.hasPreviousPage == false){
            firstPage.addClass("disabled");
            prePage.addClass("disabled");
        }else{
            firstPage.click(function () {
                to_page(1);
            });
            prePage.click(function () {
                to_page(pageInfo.pageNum-1);
            });
        }
        ul.append(firstPage).append(prePage);

        var num = pageInfo.navigatepageNums;
        $.each(num,function (index,item) {
            var numPage = $("<li></li>").append($("<a></a>").append(item));
            if (pageInfo.pageNum == item){
                numPage.addClass("active");
            }
            numPage.click(function () {
                to_page(item);
            });
            ul.append(numPage);
        });

        var nextPage = $("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPage = $("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        if(pageInfo.hasNextPage == false){
            nextPage.addClass("disabled");
            lastPage.addClass("disabled");
        }else{
            nextPage.click(function () {
                to_page(pageInfo.pageNum+1);
            });
            lastPage.click(function () {
                to_page(pageInfo.pages);
            });
        }
        ul.append(nextPage).append(lastPage);
        $("<nav></nav>").append(ul).appendTo("#page_nav_area");
    }
    
    $("#emp_add_modal_btn").click(function () {
        //清空模态框
        empty_form("#empAddModal form")
        //$("#empAddModal form")[0].reset();
        //发送ajax请求，查出所有的部门信息并显示在下拉框中
        getDepts("#empAddModal select");
        //弹出模态框
        $("#empAddModal").modal({backdrop:"static"});
    });

    //清空表单的数据和样式
    function empty_form(els) {
        //清空数据
        $(els)[0].reset();
        //清空样式
        $(els).find("*").removeClass("has-error has-success");
        $(els).find("span").text("");
    };

    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
               // console.log(result);

                $.each(result.entend.depths,function (index,item) {
                    var optionEle = $("<option></option>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo(ele);
                });
            }

        });
    };

    //对输入的模态框内容进行校验
    function check_modal_form(){
        var empName = $("#empName_add_input").val();
        var checkName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]+$)/;

        var email = $("#email_add_input").val();
        var checkEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!checkName.test(empName)){
             //alert("请输入正确的用户名");
            check_name_email("#empName_add_input","error","请输入正确的用户名");
            return false;
        }else{
            check_name_email("#empName_add_input","success","");
        }
        if (!checkEmail.test(email)){
           // alert("请输入正确的邮箱");
            check_name_email("#email_add_input","error","请输入正确的邮箱");
            return false;
        }else {
            check_name_email("#email_add_input","success","");
        }
        return true;
    };

    function check_name_email(ele,status,msg){
        $(ele).parent().removeClass("has-success has-error");
        if (status == "success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if (status == "error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //检查用户名是否可以用
    $("#empName_add_input").change(function () {
        var emp = this.value;
        //发送ajax请求校验用户名是否可以
        $.ajax({
            url:"${APP_PATH}/checkUser",
            type:"POST",
            data:"empName=" +emp,
            success:function (result) {
                if (result.code == "100"){
                    check_name_email("#empName_add_input","success","用户名可用");
                    $("#emp_add_save").attr("check_name","success");
                }else{
                    check_name_email("#empName_add_input","error",result.entend.va_msg);
                    $("#emp_add_save").attr("check_name","error");
                }
            }
        })
    });

    //点击保存，保存员工
    $("#emp_add_save").click(function () {
        //先对输入的模态框内容进行校验
        if (!check_modal_form()){
            return false;
        }

        //在保存前先判断校验的用户名是否可以，不可以则不继续执行
        if ($(this).attr("check_name")== "error"){
            return  false;
        }
       //发送Ajax请求保存员工
        $.ajax({
            url:"${APP_PATH}/emps",
            type:"POST",
            data:$("#empAddModal form").serialize(),
            success:function (result) {
                //JRS303校验用户名和邮箱是否合法的前端
                if (result.code == 100){
                    //  alert(result.msg);
                    //关闭模态框
                    $('#empAddModal').modal('hide');
                    //显示最后一页，即增加的行
                    to_page(totalRecord);
                }else{
                    if (undefined!=result.entend.errorFiled.email){
                        check_name_email("#email_add_input","error",result.entend.errorFiled.email);
                    }
                    if (undefined != result.entend.errorFiled.empName){
                        check_name_email("#empName_add_input","error",result.entend.errorFiled.empName);
                    }

                }

            }
        });
    });

    //更新按钮响应
    $(document).on("click",".edit_btn",function () {
        //查询员工的信息并显示
        getEmp($(this).attr("edit_id"));
        //查询部门的信息并显示
        getDepts("#empUpdateModal select");
        $("#emp_update_save").attr("edit_id",$(this).attr("edit_id"));
        $("#empUpdateModal").modal({backdrop:"static"});
    });
    
    function getEmp(id) {
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
           success:function (result) {
              // console.log(result);
               var emptld = result.entend.emp;
               $("#empName_update_static").text(emptld.empName);
               $("#email_update_input").val(emptld.email);
               $("#empUpdateModal input[name=gender]").val([emptld.gender]);
               $("#empUpdateModal select").val([emptld.dId]);
           }
        })
    }

    $("#emp_update_save").click(function () {
        var email = $("#email_update_input").val();
        var checkEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;

        if (!checkEmail.test(email)){
            check_name_email("#email_update_input","error","请输入正确的邮箱");
            return false;
        }else {
            check_name_email("#email_update_input","success","");
        }
        //不设置web.xml的HttpPutFormContentFilter过滤器，使用post请求代替put请求
        <%--$.ajax({--%>
        <%--    url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),--%>
        <%--    type:"POST",--%>
        <%--    data:$("#empUpdateModal form").serialize()+"&_method=PUT",--%>
        <%--    success:function (result) {--%>
        <%--      alert(result.msg);--%>
        <%--    }--%>
        <%--})--%>
        //使用HttpPutFormContentFilter（SpringMvc）过滤器，直接使用put请求
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit_id"),
            type:"POST",
            data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            success:function (result) {
                //alert(result.msg);
                $("#empUpdateModal").modal("hide");
                to_page(currentPage);
            }
        })
    });

    //单个删除
    $(document).on("click",".delete_btn",function () {
        var empName = $(this).parents("tr").find("td:eq(1)").text();
        if (confirm("确定删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("delete_id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            });

        }
    });

    //全选/全不选的复选框按钮
    $("#check_all").click(function () {
       //attr获取checked是undefined（attr获取自定义属性的值，prop修改和读取dom原生属性的值）
       //alert($(this).prop("checked"));
      $(".check_item").prop("checked",$(this).prop("checked"));
    });
    //check_item
    $(document).on("click",".check_item",function () {
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked",flag);
    })

    $("#emp_del_btn").click(function () {
        var empNames = "";
        var del_ids = "";
        $.each($(".check_item:checked"),function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text()+",";
            del_ids +=  $(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames = empNames.substring(0,empNames.length-1);
        del_ids = del_ids.substring(0,del_ids.length-1);
        if (confirm("确认删除【"+empNames+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emps/"+del_ids,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentPage);
                }
            })
        }
    });


</script>
</body>
</html>
