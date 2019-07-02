package com.ruoyi.baohan.controller;

import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysRole;

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
}
