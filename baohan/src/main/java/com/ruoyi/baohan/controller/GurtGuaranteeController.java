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
import com.ruoyi.baohan.domain.GurtGuarantee;
import com.ruoyi.baohan.service.IGurtGuaranteeService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 保函 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Controller
@RequestMapping("/baohan/gurtGuarantee")
public class GurtGuaranteeController extends BaseController
{
    private String prefix = "baohan/gurtGuarantee";
	
	@Autowired
	private IGurtGuaranteeService gurtGuaranteeService;
	
	@RequiresPermissions("baohan:gurtGuarantee:view")
	@GetMapping()
	public String gurtGuarantee()
	{
	    return prefix + "/gurtGuarantee";
	}
	
	/**
	 * 查询保函列表
	 */
	@RequiresPermissions("baohan:gurtGuarantee:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtGuarantee gurtGuarantee)
	{
		startPage();
        List<GurtGuarantee> list = gurtGuaranteeService.selectGurtGuaranteeList(gurtGuarantee);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出保函列表
	 */
	@RequiresPermissions("baohan:gurtGuarantee:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtGuarantee gurtGuarantee)
    {
    	List<GurtGuarantee> list = gurtGuaranteeService.selectGurtGuaranteeList(gurtGuarantee);
        ExcelUtil<GurtGuarantee> util = new ExcelUtil<GurtGuarantee>(GurtGuarantee.class);
        return util.exportExcel(list, "gurtGuarantee");
    }
	
	/**
	 * 新增保函
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存保函
	 */
	@RequiresPermissions("baohan:gurtGuarantee:add")
	@Log(title = "保函", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtGuarantee gurtGuarantee)
	{		
		return toAjax(gurtGuaranteeService.insertGurtGuarantee(gurtGuarantee));
	}

	/**
	 * 修改保函
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtGuarantee gurtGuarantee = gurtGuaranteeService.selectGurtGuaranteeById(id);
		mmap.put("gurtGuarantee", gurtGuarantee);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存保函
	 */
	@RequiresPermissions("baohan:gurtGuarantee:edit")
	@Log(title = "保函", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtGuarantee gurtGuarantee)
	{		
		return toAjax(gurtGuaranteeService.updateGurtGuarantee(gurtGuarantee));
	}
	
	/**
	 * 删除保函
	 */
	@RequiresPermissions("baohan:gurtGuarantee:remove")
	@Log(title = "保函", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		return toAjax(gurtGuaranteeService.deleteGurtGuaranteeByIds(ids));
	}
	
}
