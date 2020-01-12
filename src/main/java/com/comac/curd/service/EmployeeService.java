package com.comac.curd.service;

import com.comac.curd.bean.Employee;
import com.comac.curd.bean.EmployeeExample;
import com.comac.curd.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class EmployeeService {
    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * 查询所以员工
     * @return   所以员工
     */
    public List<Employee> getAll() {
        return employeeMapper.selectByExampleWithDept(null);
    }

    /**
     * 插入员工
     * @param employee 员工
     * @return 是否成功
     */
    public int saveEmp(Employee employee) {
        return employeeMapper.insertSelective(employee);
    }

    /**
     * 校验用户名是否可以用
     * @param empName 用户名
     * @return true：可以  false:不可以
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long a = employeeMapper.countByExample(employeeExample);
        return  a == 0;
    }

    /**
     * 查询编辑模态框所需的员工信息
     * @param id 用户id
     * @return employee
     */
    public Employee getEmp(Integer id) {
        Employee employee = employeeMapper.selectByPrimaryKey(id);
        return employee;
    }

    /**
     * 更新员工的信息
     * @param employee
     */
    public void updataEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }

    /**
     * 删除单个员工
     * @param id
     */
    public void deleteEmp(Integer id) {
        employeeMapper.deleteByPrimaryKey(id);
    }

    /**
     * 批量删除员工
     * @param ids
     */
    public void deleteEmps(List<Integer> ids){
        EmployeeExample employeeExample = new EmployeeExample();
        EmployeeExample.Criteria criteria = employeeExample.createCriteria();
        //delete   from emp_tld where emp_id in(1,2,3)
        criteria.andEmpIdIn(ids);
        employeeMapper.deleteByExample(employeeExample);
    }
}
