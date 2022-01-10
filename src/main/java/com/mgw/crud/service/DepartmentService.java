package com.mgw.crud.service;

import com.mgw.crud.bean.Department;
import com.mgw.crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author maguowei
 * @create 2022-01-06 20:24
 */
@Service
public class DepartmentService{

    @Autowired
    private DepartmentMapper departmentMapper;

    public List<Department> getAllDepts(){
        return departmentMapper.selectByExample(null);
    }

}
