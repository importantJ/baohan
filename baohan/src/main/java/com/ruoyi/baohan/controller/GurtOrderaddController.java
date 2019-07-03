package com.ruoyi.baohan.controller;

import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.common.core.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/baohan/gurtOrderadd")
public class GurtOrderaddController extends BaseController {
    private String prefix = "baohan/gurtOrder";

    @Autowired
    private IGurtOrderService gurtOrderService;

    @GetMapping()
    public String gurtOrder(ModelMap modelMap) {
        UtilOrder.gurtOrder(modelMap, gurtOrderService);
        return prefix + "/gurtOrderadd";
    }
}