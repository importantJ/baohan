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
import com.ruoyi.baohan.domain.GurtInviteCommission;
import com.ruoyi.baohan.service.IGurtInviteCommissionService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 邀请提成 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Controller
@RequestMapping("/baohan/gurtInviteCommission")
public class GurtInviteCommissionController extends BaseController
{
    private String prefix = "baohan/gurtInviteCommission";
	
	@Autowired
	private IGurtInviteCommissionService gurtInviteCommissionService;
	
	@RequiresPermissions("baohan:gurtInviteCommission:view")
	@GetMapping()
	public String gurtInviteCommission()
	{
	    return prefix + "/gurtInviteCommission";
	}
	
	/**
	 * 查询邀请提成列表
	 */
	@RequiresPermissions("baohan:gurtInviteCommission:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtInviteCommission gurtInviteCommission)
	{
		startPage();
        List<GurtInviteCommission> list = gurtInviteCommissionService.selectGurtInviteCommissionList(gurtInviteCommission);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出邀请提成列表
	 */
	@RequiresPermissions("baohan:gurtInviteCommission:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtInviteCommission gurtInviteCommission)
    {
    	List<GurtInviteCommission> list = gurtInviteCommissionService.selectGurtInviteCommissionList(gurtInviteCommission);
        ExcelUtil<GurtInviteCommission> util = new ExcelUtil<GurtInviteCommission>(GurtInviteCommission.class);
        return util.exportExcel(list, "gurtInviteCommission");
    }
	
	/**
	 * 新增邀请提成
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存邀请提成
	 */
	@RequiresPermissions("baohan:gurtInviteCommission:add")
	@Log(title = "邀请提成", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtInviteCommission gurtInviteCommission)
	{		
		return toAjax(gurtInviteCommissionService.insertGurtInviteCommission(gurtInviteCommission));
	}

	/**
	 * 修改邀请提成
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtInviteCommission gurtInviteCommission = gurtInviteCommissionService.selectGurtInviteCommissionById(id);
		mmap.put("gurtInviteCommission", gurtInviteCommission);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存邀请提成
	 */
	@RequiresPermissions("baohan:gurtInviteCommission:edit")
	@Log(title = "邀请提成", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtInviteCommission gurtInviteCommission)
	{		
		return toAjax(gurtInviteCommissionService.updateGurtInviteCommission(gurtInviteCommission));
	}
	
	/**
	 * 删除邀请提成
	 */
	@RequiresPermissions("baohan:gurtInviteCommission:remove")
	@Log(title = "邀请提成", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		return toAjax(gurtInviteCommissionService.deleteGurtInviteCommissionByIds(ids));
	}
	
}
