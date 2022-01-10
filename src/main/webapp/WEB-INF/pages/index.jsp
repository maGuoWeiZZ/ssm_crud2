<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>员工列表</title>
    <%--引入jquery--%>
    <script type="text/javascript" src="https://s3.pstatp.com/cdn/expire-1-M/jquery/3.3.1/jquery.min.js"></script>
    <%--引入样式--%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/js/bootstrap.js"></script>
</head>
<body>

<!-- 员工添加模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_input_add"
                                   placeholder="empName">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_input_add"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_input_add" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_input_add" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <input type="hidden" name="_method" value="put">
                    <input type="hidden" name="empId" id="empId">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_input_update"
                                   placeholder="email@qq.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_input_update" value="M" checked> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_input_update" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId"></select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">修改</button>
            </div>
        </div>
    </div>
</div>

<%--搭建页面--%>
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_del_modal_btn">删除</button>
        </div>
    </div>
    <%--显示表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all">
                    </th>
                    <th>#</th>
                    <th>empName</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptName</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="emp_table"></tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页信息--%>
        <div class="col-md-6" id="page_info_area"></div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">
        </div>
    </div>
</div>
<script type="text/javascript">

    //总记录数
    var totle_count;
    //当前页码
    var currPageNum;

    //页面加载
    $(function () {
        //首页
        to_page(1);
    })

    //构建员工表
    function build_emps_table(result) {
        //清空emp表
        $('#emp_table').empty();
        //获取员工集合
        var emps = result.extend.pageInfo.list;
        //遍历
        $.each(emps, function (index, item) {
            var checkTd = $("<td><input type='checkbox' class='check_item'></td>");
            var empIdTd = $('<td></td>').append(item.empId);
            var empNameTd = $('<td></td>').append(item.empName);
            var genderTd = $('<td></td>').append(item.gender == 'M' ? '男' : '女');
            var emailTd = $('<td></td>').append(item.email);
            var deptNameTd = $('<td></td>').append(item.department.deptName);
            var editBtn = $('<button></button>').addClass('btn btn-primary btn-sm edit_btn')
                .append($('<span></span>').addClass('glyphicon glyphicon-pencil')).append(' ').append('编辑');
            //为编辑按钮添加id属性
            editBtn.attr("edit-id", item.empId);
            var delBtn = $('<button></button>').addClass('btn btn-danger btn-sm del_btn')
                .append($('<span></span>').addClass('glyphicon glyphicon-trash')).append(' ').append('删除');
            //为删除按钮添加员工id、name属性
            delBtn.attr("del-id", item.empId);
            delBtn.attr("del-name", item.empName);
            var btnTd = $('<td></td>').append(editBtn).append('&nbsp;&nbsp;').append(delBtn);
            var empTr = $('<tr></tr>')
                .append(checkTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo('#emp_table');
        })
    }

    //分页信息
    function build_page_info(result) {
        $('#page_info_area').empty();
        var pageNum = result.extend.pageInfo.pageNum;
        var pages = result.extend.pageInfo.pages;
        var total = result.extend.pageInfo.total;
        totle_count = result.extend.pageInfo.total;
        currPageNum = result.extend.pageInfo.pageNum;
        $('#page_info_area')
            .append("当前" + pageNum + "页，总" + pages + "页，总" + total + "条记录");

    }

    //分页条
    function build_page_nav(result) {
        $('#page_nav_area').empty();
        var ul = $('<ul></ul>').addClass('pagination');
        var firstPageLi = $("<li></li>").append($('<a></a>').append("首页").attr("href", "#"));
        var prePageLi = $("<li></li>").append($('<a></a>').append("&laquo;"));

        //没有前一页
        if (!result.extend.pageInfo.hasPreviousPage) {
            //首页和上一页禁用
            prePageLi.addClass('disabled');
            firstPageLi.addClass('disabled')
        } else {
            //有上一页，首页和上一页绑定单击事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1)
            })
        }
        var nextPageLi = $("<li></li>").append($('<a></a>').append("&raquo;"));
        var lastPageLi = $("<li></li>").append($('<a></a>').append("末页").attr("href", "#"));
        //没有下一页
        if (!result.extend.pageInfo.hasNextPage) {
            //末页和下一页禁用
            nextPageLi.addClass('disabled');
            lastPageLi.addClass('disabled');
        } else {
            //有下一页，末页和下一页绑定单击事件
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1)
            });
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            })
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums, function (index, item) {
            var numLi = $("<li></li>").append($('<a></a>').append(item));
            if (result.extend.pageInfo.pageNum == item) {
                numLi.addClass('active');
            }
            numLi.click(function () {
                to_page(item);
            })
            ul.append(numLi);
        })
        ul.append(nextPageLi).append(lastPageLi);
        var nav = $('<nav></nav>').append(ul);
        $('#page_nav_area').append(nav);
    }

    //发ajax请求跳转页面，翻页并渲染
    function to_page(pn) {
        $.ajax({
            url: '${pageContext.request.contextPath}/emps',
            data: 'pn=' + pn,
            type: 'GET',
            success: function (result) {
                console.log(result);
                //解析并显示员工数据
                build_emps_table(result);
                //解析并显示分页数据
                build_page_info(result);
                //解析并显示分页条信息
                build_page_nav(result);
            }
        })
        $('#check_all').prop("checked", false);
    }

    //校验用户名是否可用
    $('#empName_input_add').blur(function () {
        $.ajax({
            url: '${pageContext.request.contextPath}/checkUser',
            data: 'empName=' + $('#empName_input_add').val(),
            type: 'GET',
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg('#empName_input_add', "success", "用户名可用");
                    $('#empName_input_add').attr("validate-val", "success");
                } else if (result.code == 200) {
                    show_validate_msg('#empName_input_add', "error", result.extend.va_msg);
                    $('#empName_input_add').attr("validate-val", "error");
                }
            }
        })
    })

    //表单重置
    function reset_form(ele) {
        $(ele)[0].reset();
        $(ele).find('*').removeClass('has-error has-success');
        $(ele).find('.help-block').text('');
    }

    //新增按钮点击事件
    $('#emp_add_modal_btn').click(function () {
        //表单重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表中
        getDepts('#empAddModal form select');
        //弹出模态框
        $('#empAddModal').modal({
            backdrop: 'static'
        });
    })

    //查询所有部门信息并显示在下拉列表中
    function getDepts(ele) {
        $.ajax({
            url: '${pageContext.request.contextPath}/getDepts',
            type: 'GET',
            success: function (result) {
                $(ele).empty();
                console.log(result);
                $.each(result.extend.depts, function (index, item) {
                    $(ele).append($('<option></option>')
                        .append(item.deptName).attr("value", item.deptId));
                })

            }
        })
    }

    //对提交给服务器的数据进行校验
    function validate_add_form() {
        //校验用户名
        var empName = $('#empName_input_add').val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5}$)/;
        if (!regName.test(empName)) {
            //alert('用户名必须是2-5位中文或6-16位英文和数字的组合！');
            show_validate_msg('#empName_input_add', "error", "用户名必须是2-5位中文或6-16位英文和数字的组合！");
            return false;
        } else {
            show_validate_msg('#empName_input_add', "success", "");
        }
        //校验邮箱
        var email = $('#email_input_add').val();
        var regEmail = /^[A-Za-zd0-9]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/;
        if (!regEmail.test(email)) {
            show_validate_msg('#email_input_add', "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg('#email_input_add', "success", "");
        }
        return true;
    }

    //显示表单数据错误信息
    function show_validate_msg(ele, states, msg) {
        //清除之前的状态
        $(ele).parent().removeClass('has-error');
        $(ele).parent().removeClass('has-success');
        $(ele).next('span').text('');
        if ("error" == states) {
            $(ele).parent().addClass('has-error');
            $(ele).next('span').text(msg);
        } else if ("success" == states) {
            $(ele).parent().addClass('has-success');
            $(ele).next('span').text(msg);
        }
    }


    //保存员工按钮单击事件
    $('#emp_save_btn').click(function () {
        //首先对提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //判断用户名是否可用
        if ($('#empName_input_add').attr("validate-val") == "error") {
            return false;
        }
        //发送ajax请求添加员工
        $.ajax({
            url: '${pageContext.request.contextPath}/emp',
            //serialize()方法可以将表单数据转换成key=value&key=value形式
            data: $('#empAddModal form').serialize(),
            type: 'POST',
            success: function (result) {
                // alert(result.message);
                //员工保存成功后
                if (result.code == 100) {
                    //1、关闭模态框
                    $('#empAddModal').modal('hide');
                    //2、跳转到最后一页，显示刚才添加的数据
                    //发送ajax请求显示最后一页数据
                    to_page(totle_count);
                } else if (result.code == 200) {
                    //显示错误信息
                    //有哪个字段显示哪个
                    if (undefined != result.extend.errorFields.empName) {
                        show_validate_msg("#empName_input_add", "error", result.extend.errorFields.empName);
                    }
                    if (undefined != result.extend.errorFields.email) {
                        console.log(result);
                        show_validate_msg("#email_input_add", "error", result.extend.errorFields.email);
                    }
                }
            }
        });
    })

    //编辑按钮绑定单击事件，使用on，可以给之后创建的元素也绑定事件
    $(document).on("click", ".edit_btn", function () {
        //查询员工信息回显
        getEmp($(this).attr("edit-id"));
        //查询部门信息显示在下拉列表
        getDepts('#empUpdateModal form select');
        //显示修改员工模态框
        $('#empUpdateModal').modal({
            backdrop: 'static'
        })
    })

    //查询员工信息
    function getEmp(id) {
        $.ajax({
            url: '${pageContext.request.contextPath}/emp/' + id,
            type: 'GET',
            success: function (result) {
                var emp = result.extend.emp;
                $('#empName_update_static').text(emp.empName);
                $('#email_input_update').val(emp.email);
                $('#empUpdateModal input[name=gender]').val([emp.gender]);
                $('#empUpdateModal select').val([emp.dId]);
                $('#empId').val(emp.empId);
            }
        })
    }

    //修改按钮绑定单击事件
    $('#emp_update_btn').click(function () {
        //校验邮箱
        var email = $('#email_input_update').val();
        var regEmail = /^[A-Za-zd0-9]+([-_.][A-Za-zd]+)*@([A-Za-zd]+[-.])+[A-Za-zd]{2,5}$/;
        if (!regEmail.test(email)) {
            show_validate_msg('#email_input_update', "error", "邮箱格式不正确！");
            return false;
        } else {
            show_validate_msg('#email_input_update', "success", "");
        }

        //发送ajax请求保存修改的员工信息
        $.ajax({
            url: '${pageContext.request.contextPath}/emp',
            type: 'POST',
            data: $('#empUpdateModal form').serialize(),
            success: function (result) {
                //关闭模态框
                $('#empUpdateModal').modal('hide');
                //回到当前页面
                to_page(currPageNum);
            }
        })
    })

    //删除按钮单击事件
    $(document).on("click", '.del_btn', function () {
        if (confirm('确定删除员工【' + $(this).attr("del-name") + "】?")) {
            $.ajax({
                url: '${pageContext.request.contextPath}/emp/' + $(this).attr("del-id"),
                type: 'POST',
                data: '_method=delete',
                success: function (result) {
                    //删除成功后，重新到当前页面
                    to_page(currPageNum);
                }
            })
        } else {
            return false;
        }
    })

    //全选&全不选
    $('#check_all').click(function () {
        var isChecked = $(this).prop('checked');
        $('#emp_table input[class=check_item]').prop("checked", isChecked);
    })

    //check_item
    $(document).on("click", ".check_item", function () {
        var flag = $('.check_item:checked').length == $('.check_item').length;
        $('#check_all').prop("checked", flag);
    })

    //批量删除
    $('#emp_del_modal_btn').click(function () {
        var empNames = "";
        var empIds = "";
        $.each($('.check_item:checked'), function () {
            empNames += $(this).parents("tr").find("td:eq(2)").text() + "，";
            empIds += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除字符串后多余的符号
        empIds = empIds.substring(0, empIds.length - 1);
        empNames = empNames.substring(0, empNames.length - 1);
        if (empNames == '') {
            alert("请先选择要删除的员工！")
        }else {
            if (confirm("是否删除【" + empNames + "】？")) {
                $.ajax({
                    url:'${pageContext.request.contextPath}/emp/' + empIds,
                    type:'POST',
                    data:'_method=delete',
                    success:function (result) {
                        to_page(currPageNum);
                    }
                });
            }else {
                return false;
            }
        }

    })
</script>
</body>
</html>
