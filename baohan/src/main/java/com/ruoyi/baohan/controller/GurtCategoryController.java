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
import com.ruoyi.baohan.domain.GurtCategory;
import com.ruoyi.baohan.service.IGurtCategoryService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

/**
 * 项目基础资料 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Controller
@RequestMapping("/baohan/gurtCategory")
public class GurtCategoryController extends BaseController
{
    private String prefix = "baohan/gurtCategory";
	
	@Autowired
	private IGurtCategoryService gurtCategoryService;
	
	@RequiresPermissions("baohan:gurtCategory:view")
	@GetMapping()
	public String gurtCategory()
	{
	    return prefix + "/gurtCategory";
	}
	
	/**
	 * 查询项目基础资料列表
	 */
	@RequiresPermissions("baohan:gurtCategory:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtCategory gurtCategory)
	{
		startPage();
        List<GurtCategory> list = gurtCategoryService.selectGurtCategoryList(gurtCategory);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出项目基础资料列表
	 */
	@RequiresPermissions("baohan:gurtCategory:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtCategory gurtCategory)
    {
    	List<GurtCategory> list = gurtCategoryService.selectGurtCategoryList(gurtCategory);
        ExcelUtil<GurtCategory> util = new ExcelUtil<GurtCategory>(GurtCategory.class);
        return util.exportExcel(list, "gurtCategory");
    }
	
	/**
	 * 新增项目基础资料
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存项目基础资料
	 */
	@RequiresPermissions("baohan:gurtCategory:add")
	@Log(title = "项目基础资料", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtCategory gurtCategory)
	{		
		return toAjax(gurtCategoryService.insertGurtCategory(gurtCategory));
	}

	/**
	 * 修改项目基础资料
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtCategory gurtCategory = gurtCategoryService.selectGurtCategoryById(id);
		mmap.put("gurtCategory", gurtCategory);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存项目基础资料
	 */
	@RequiresPermissions("baohan:gurtCategory:edit")
	@Log(title = "项目基础资料", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtCategory gurtCategory)
	{		
		return toAjax(gurtCategoryService.updateGurtCategory(gurtCategory));
	}
	
	/**
	 * 删除项目基础资料
	 */
	@RequiresPermissions("baohan:gurtCategory:remove")
	@Log(title = "项目基础资料", businessType = BusinessType.DELETE)
	@PostMapping( "/remove")
	@ResponseBody
	public AjaxResult remove(String ids)
	{		
		return toAjax(gurtCategoryService.deleteGurtCategoryByIds(ids));
	}
	
}
