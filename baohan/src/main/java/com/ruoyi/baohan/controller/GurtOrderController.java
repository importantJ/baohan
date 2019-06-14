package com.ruoyi.baohan.controller;

import java.util.List;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.baohan.domain.GurtOrder;
import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 订单 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Controller
@RequestMapping("/baohan/gurtOrder")
public class GurtOrderController extends BaseController
{
    private String prefix = "baohan/gurtOrder";
	
	@Autowired
	private IGurtOrderService gurtOrderService;
	
	@RequiresPermissions("baohan:gurtOrder:view")
	@GetMapping()
	public String gurtOrder()
	{
	    return prefix + "/gurtOrder";
	}
	
	/**
	 * 查询订单列表
	 */
	@RequiresPermissions("baohan:gurtOrder:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtOrder gurtOrder)
	{
		startPage();
        List<GurtOrder> list = gurtOrderService.selectGurtOrderList(gurtOrder);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出订单列表
	 */
	@RequiresPermissions("baohan:gurtOrder:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtOrder gurtOrder)
    {
    	List<GurtOrder> list = gurtOrderService.selectGurtOrderList(gurtOrder);
        ExcelUtil<GurtOrder> util = new ExcelUtil<GurtOrder>(GurtOrder.class);
        return util.exportExcel(list, "gurtOrder");
    }
	
	/**
	 * 新增订单
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存订单
	 */
	@RequiresPermissions("baohan:gurtOrder:add")
	@Log(title = "订单", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtOrder gurtOrder)
	{		
		return toAjax(gurtOrderService.insertGurtOrder(gurtOrder));
	}

	/**
	 * 修改订单
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtOrder gurtOrder = gurtOrderService.selectGurtOrderById(id);
		mmap.put("gurtOrder", gurtOrder);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存订单
	 */
	@RequiresPermissions("baohan:gurtOrder:edit")
	@Log(title = "订单", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtOrder gurtOrder)
	{		
		return toAjax(gurtOrderService.updateGurtOrder(gurtOrder));
	}
	
	/**
	 * 删除订单
	 */
	@RequiresPermissions("baohan:gurtOrder:remove")
	@Log(title = "订单", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		return toAjax(gurtOrderService.deleteGurtOrderByIds(ids));
	}
	
}
