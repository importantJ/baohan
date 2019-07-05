package com.ruoyi.baohan.controller;

import com.ruoyi.baohan.domain.Gurtshezhi;
import com.ruoyi.baohan.mapper.GurtOrderMapper;
import com.ruoyi.baohan.service.IGurtCategoryService;
import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.baohan.service.IGurtProjectTypeCostConfigService;
import com.ruoyi.baohan.service.IGurtProjectTypeService;
import com.ruoyi.common.core.controller.BaseController;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/baohan/gurtshezhi")
public class GurtShezhiController extends BaseController {
    private String prefix = "baohan/gurtShezhi";
    @Autowired
    GurtOrderMapper gurtOrderMapper;
    @RequiresPermissions("baohan:gurtshezhi:view")
    @GetMapping()
    public String gurtCategory(ModelMap modelMap) {
        List<Gurtshezhi> gurtshezhiList=gurtOrderMapper.getAllShezhi();
        modelMap.put("getAllShezhi",gurtshezhiList);
        modelMap.put("cb",gurtshezhiList.get(0).getCb());
        return prefix + "/view";
    }
}