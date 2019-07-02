package com.ruoyi.baohan.controller;

import com.ruoyi.baohan.service.IGurtCategoryService;
import com.ruoyi.baohan.service.IGurtProjectTypeCostConfigService;
import com.ruoyi.baohan.service.IGurtProjectTypeService;
import com.ruoyi.common.core.controller.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/baohan/gurtshezhi")
public class GurtShezhiController extends BaseController {
    private String prefix = "baohan/gurtShezhi";

    @RequiresPermissions("baohan:gurtshezhi:view")
    @GetMapping()
    public String gurtCategory() {
        return prefix + "/view";
    }
}