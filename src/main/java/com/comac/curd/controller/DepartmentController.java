package com.comac.curd.controller;

import com.comac.curd.bean.Department;
import com.comac.curd.bean.Msg;
import com.comac.curd.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * 处理有关部门的所有请求
 */
@Controller
public class DepartmentController {
    @Autowired
    DepartmentService departmentService;

    /**
     * 返回所以部门信息
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> list = departmentService.getDepts();

        return Msg.success().add("depths",list);
    }
}
