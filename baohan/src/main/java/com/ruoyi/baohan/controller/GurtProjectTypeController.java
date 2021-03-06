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
import com.ruoyi.baohan.domain.GurtProjectType;
import com.ruoyi.baohan.service.IGurtProjectTypeService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 项目名称 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
@Controller
@RequestMapping("/baohan/gurtProjectType")
public class GurtProjectTypeController extends BaseController
{
    private String prefix = "baohan/gurtProjectType";
	
	@Autowired
	private IGurtProjectTypeService gurtProjectTypeService;




	@RequiresPermissions("baohan:gurtProjectType:view")
	@GetMapping()
	public String gurtProjectType()
	{
	    return prefix + "/gurtProjectType";
	}
	
	/**
	 * 查询项目名称列表
	 */
	@RequiresPermissions("baohan:gurtProjectType:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtProjectType gurtProjectType)
	{
		startPage();
        List<GurtProjectType> list = gurtProjectTypeService.selectGurtProjectTypeList(gurtProjectType);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出项目名称列表
	 */
	@RequiresPermissions("baohan:gurtProjectType:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtProjectType gurtProjectType)
    {
    	List<GurtProjectType> list = gurtProjectTypeService.selectGurtProjectTypeList(gurtProjectType);
        ExcelUtil<GurtProjectType> util = new ExcelUtil<GurtProjectType>(GurtProjectType.class);
        return util.exportExcel(list, "gurtProjectType");
    }
	
	/**
	 * 新增项目名称
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存项目名称
	 */
	@RequiresPermissions("baohan:gurtProjectType:add")
	@Log(title = "项目名称", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtProjectType gurtProjectType)
	{		
		return toAjax(gurtProjectTypeService.insertGurtProjectType(gurtProjectType));
	}

	/**
	 * 修改项目名称
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtProjectType gurtProjectType = gurtProjectTypeService.selectGurtProjectTypeById(id);
		mmap.put("gurtProjectType", gurtProjectType);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存项目名称
	 */
	@RequiresPermissions("baohan:gurtProjectType:edit")
	@Log(title = "项目名称", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtProjectType gurtProjectType)
	{		
		return toAjax(gurtProjectTypeService.updateGurtProjectType(gurtProjectType));
	}
	
	/**
	 * 删除项目名称
	 */
	@RequiresPermissions("baohan:gurtProjectType:remove")
	@Log(title = "项目名称", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		return toAjax(gurtProjectTypeService.deleteGurtProjectTypeByIds(ids));
	}
	
}
