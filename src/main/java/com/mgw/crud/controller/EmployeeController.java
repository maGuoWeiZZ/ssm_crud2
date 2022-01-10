package com.mgw.crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mgw.crud.bean.Employee;
import com.mgw.crud.bean.Msg;
import com.mgw.crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

/**
 * @author maguowei
 * @create 2022-01-06 14:51
 */
@Controller
public class EmployeeController {

    @Autowired
    private EmployeeService employeeService;

    /**查询所有员工信息
     * @param pn
     * @param model
     * @return
     */
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){

//        查询之前传入页码和每页个数
        PageHelper.startPage(pn,5);
//        startPage后紧跟的就是分页查询
        List<Employee> employeeList = employeeService.getAll();
//        使用pageInfo包装查询的结果，封装了详细的分页信息和查出的数据，传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<>(employeeList,5);
        model.addAttribute("pageInfo",pageInfo);
        return "list";
    }

    //分页查询所有员工信息
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn){

//        查询之前传入页码和每页个数
        PageHelper.startPage(pn,5);
//        startPage后紧跟的就是分页查询
        List<Employee> employeeList = employeeService.getAll();
//        使用pageInfo包装查询的结果，封装了详细的分页信息和查出的数据，传入连续显示的页数
        PageInfo<Employee> pageInfo = new PageInfo<>(employeeList,5);
        return Msg.success().add("pageInfo",pageInfo);
    }

    //添加员工
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg addEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()) {
            HashMap<String, Object> map = new HashMap<>();
            List<FieldError> fieldErrors = result.getFieldErrors();
            for (FieldError fieldError : fieldErrors) {
                System.out.println("错误字段"+fieldError.getField());
                System.out.println("错误信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }else {
            employeeService.addEmployee(employee);
            return Msg.success();
        }
    }

    //校验用户名是否存在
    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(String empName){
        //检测用户名是否符合规范
        String reg = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(reg)) {
            return Msg.fail().add("va_msg","用户名必须是6-16位字母数字组合或2-5位中文！");
        }
        //检验用户名是否存在
        boolean b = employeeService.checkName(empName);
        if (b) {
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名已存在！");
        }
    }

    //根据id查询员工信息
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("empId") Integer empId){
        Employee employee = employeeService.getEmpById(empId);
        if (employee != null) {
            return Msg.success().add("emp",employee);
        }else {
            return Msg.fail();
        }
    }

    //修改员工信息
    @RequestMapping(value = "/emp",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /***
      ** 批量单个二合一
      ** 批量 1-2-3
      ** 单个 1
      ** @author maguowei
      ** @date 2022/1/7 19:24
    **/
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delEmp(@PathVariable("empId") String ids){
        System.out.println(ids);

        if (ids.contains("-")) {
            //批量删除
            ArrayList<Integer> list = new ArrayList<>();
            String[] ids_string = ids.split("-");
            for (String id : ids_string) {
                list.add(Integer.parseInt(id));
            }
            employeeService.delBatch(list);
        }else {
            //单个删除
            employeeService.deleteEmp(Integer.parseInt(ids));

        }

        return Msg.success();
    }

}
