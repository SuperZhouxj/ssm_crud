package com.comac.curd.controller;

import com.comac.curd.bean.Employee;
import com.comac.curd.bean.Msg;
import com.comac.curd.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
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
import java.util.Map;

/**
 * 获取所以的员工
 */
@Controller
public class EmployeeController {
    /**
     * 查询员工数据（分页）
     * @return
     */

    @Autowired
    EmployeeService employeeService;

    /**
     * 批量删除
     * @param ids
     * @return
     */
    @ResponseBody
    @RequestMapping(value = "emps/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmps(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] str_ids = ids.split("-");
            for (String string_ids : str_ids){
                del_ids.add(Integer.parseInt(string_ids));
            }
            employeeService.deleteEmps(del_ids);
        }else{
            Integer id = Integer.valueOf(ids);
            employeeService.deleteEmp(id);
        }
        return Msg.success();
    }

    /**
     * 删除单个
     * @param id Id
     * @return Msg
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.DELETE)
    public Msg deleteEmp(@PathVariable("id") Integer id){
        employeeService.deleteEmp(id);
        return Msg.success();
    }

    /**
     * 更新员工信息
     * @param employee
     * @return
     *
     * ajax中不能直接使用方法PUT,因为tomcat中只支持POST，如果是POST，tomcat才能完成将请求体中的数据
     * 封装成map
     * tomact源码中的这个方法的位置：org.apache.catalina.connector.Request--parseParameters()(3111行)
     *
     * 解决方案：
     * 我们要能支持直接发送PUT之类的请求还要封装请求体中的数据
     * 1.配置上HttpPutFormContentFilter；
     * 2.他的作用：将请求体中的数据解析包装成一个map;
     * 3.request被重新包装：request.getParameter（）被重写，就会从自己封装的map中取值
     */
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg updateEmp(Employee employee){
      //  System.out.println("员工:"+employee.toString());
        employeeService.updataEmp(employee);
        return Msg.success();
    }

    /**
     * 查询编辑模态框所需的员工信息
     * @param
     * @return
     */
    @RequestMapping("/emp/{id}")
    @ResponseBody
    public Msg getEmp(@PathVariable Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    @RequestMapping("/checkUser")
    @ResponseBody
    public Msg checkUser(@RequestParam("empName") String empName){
        //先对用户名进行校验是否合法
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]+$)";
        if (!empName.matches(regex)){
            return  Msg.fail().add("va_msg","用户名必须是6-16位字母数字");
        }
        boolean result = employeeService.checkUser(empName);
        if (result){
            return Msg.success();
        }else {
            return Msg.fail().add("va_msg","用户名不可用");
        }

    }

    @RequestMapping(value = "/emps",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败，返回失败信息，并在模态框中显示（用JRS303）
            Map<String,Object> map = new HashMap<>();
            List<FieldError> error  = result.getFieldErrors();
            for (FieldError fieldError : error){
                map.put(fieldError.getField(),fieldError.getDefaultMessage());

            }
            return Msg.fail().add("errorFiled",map);
        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        //引入PageHelp插件分页查询，在查询之前只需求调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
        //封装分页的信息
        PageInfo page = new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          Model model){

        //引入PageHelp插件分页查询，在查询之前只需求调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
       List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行
        //封装分页的信息
        PageInfo page = new PageInfo(emps,5);

        model.addAttribute("pageInfo",page);
        model.addAttribute("emps",emps);

        return "list";
    }
}
