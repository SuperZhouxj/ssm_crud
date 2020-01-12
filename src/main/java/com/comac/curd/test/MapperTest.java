package com.comac.curd.test;

import com.comac.curd.bean.Department;
import com.comac.curd.bean.Employee;
import com.comac.curd.dao.DepartmentMapper;


import com.comac.curd.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 推荐spring的项目就可以使用spring的单元测试，可以自动注入我们需要的组件
 * 1.导入springtest模块
 * 2.@ContextConfiguration指定spring配置文件的位置
 * 3.直接
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCURD(){
        System.out.println(departmentMapper);
        //插入部门
//        departmentMapper.insertSelective(new Department(null,"开发部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));
        //测试员工插入
        //employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@comac.cc",1));
        //批量插入多个员工，批量：使用可以执行批量操作的sqlsession
        EmployeeMapper employeeMapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i = 0; i<1000; i++){
            String uid = UUID.randomUUID().toString().substring(0,5)+i;
            employeeMapper.insertSelective(new Employee(null,uid,"M",uid+"@comac.cc",1));

        }
        System.out.println("插入成功");
    }
}
