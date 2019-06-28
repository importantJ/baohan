package com.ruoyi.baohan.controller;

import com.ruoyi.baohan.domain.GurtOrder;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.service.ISysUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/baohan/gurtma")
public class GurtmaController extends BaseController {
    private String prefix = "baohan/gurtma";
    @Autowired
    ISysUserService userService;
    @RequiresPermissions("baohan:gurtma:view")
    @GetMapping()
    public Object list(ModelMap modelMap)
    {
        SysUser user=userService.selectUserById(ShiroUtils.getUserId());
        String lianjie="http://192.168.0.80/login?";
        lianjie= lianjie+user.getInviteurl().substring(user.getInviteurl().lastIndexOf("/"),user.getInviteurl().lastIndexOf("."));
        modelMap.put("user",user);
        modelMap.put("lianjie",lianjie);
        return  prefix+"/view";
    }
}
