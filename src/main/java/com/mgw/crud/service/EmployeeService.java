package com.mgw.crud.service;

import com.mgw.crud.bean.Employee;
import com.mgw.crud.bean.EmployeeExample;
import com.mgw.crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author maguowei
 * @create 2022-01-06 14:53
 */
@Service
public class EmployeeService {

    @Autowired
    private EmployeeMapper employeeMapper;

    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }

    public int addEmployee(Employee employee){
        return employeeMapper.insertSelective(employee);
    }

    //校验用户名是否可用(true可用 false不可用)
    public boolean checkName(String empName){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(example);
        return count == 0;
    }

    //按id查询员工信息
    public Employee getEmpById(Integer empId){
        return employeeMapper.selectByPrimaryKeyWithDept(empId);
    }

    //修改员工信息
    public int updateEmp(Employee employee){
        return employeeMapper.updateByPrimaryKeySelective(employee);
    }

    //删除员工信息
    public int deleteEmp(Integer empId){
        return employeeMapper.deleteByPrimaryKey(empId);
    }

    //批量删除员工
    public int delBatch(List<Integer> ids){
        EmployeeExample example = new EmployeeExample();
        EmployeeExample.Criteria criteria = example.createCriteria();
        criteria.andEmpIdIn(ids);
        return employeeMapper.deleteByExample(example);
    }
}
