package com.mgw.crud.controller;

import com.mgw.crud.bean.Department;
import com.mgw.crud.bean.Msg;
import com.mgw.crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * @author maguowei
 * @create 2022-01-06 20:25
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    //查询所有部门信息
    @RequestMapping("/getDepts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> departmentList = departmentService.getAllDepts();
        return Msg.success().add("depts",departmentList);
    }

}
