package com.ruoyi.baohan.controller;

import com.ruoyi.baohan.domain.GurtStatus;
import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.baohan.service.impl.GurtOrderServiceImpl;
import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysRole;
import org.springframework.ui.ModelMap;

import java.util.List;

public class UtilOrder {
    public static int getRole(){
        int role=0;
        List<SysRole> user= ShiroUtils.getSysUser().getRoles();
        for (int i=0;i<user.size();i++){
            if(user.get(i).getRoleName().equals("管理员")||user.get(i).getRoleName().equals("客户经理"))
                role=1;
        }
        return role;
    }
    public static void gurtOrder(ModelMap modelMap, IGurtOrderService gurtOrderService) {
        List<GurtStatus> statusList = gurtOrderService.getStatus();
        modelMap.put("statusList", statusList);
        int role = UtilOrder.getRole();
        modelMap.put("role", role);
    }
}
