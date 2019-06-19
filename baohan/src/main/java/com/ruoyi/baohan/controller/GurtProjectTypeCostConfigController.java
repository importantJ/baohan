package com.ruoyi.baohan.controller;

import java.util.List;

import com.ruoyi.baohan.domain.GurtProjectType;
import com.ruoyi.baohan.mapper.GurtProjectTypeMapper;
import com.ruoyi.baohan.service.IGurtProjectTypeService;
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
import com.ruoyi.baohan.domain.GurtProjectTypeCostConfig;
import com.ruoyi.baohan.service.IGurtProjectTypeCostConfigService;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;

import javax.annotation.Resource;

/**
 * 项目分类 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
@Controller
@RequestMapping("/baohan/gurtProjectTypeCostConfig")
public class GurtProjectTypeCostConfigController extends BaseController
{
    private String prefix = "baohan/gurtProjectTypeCostConfig";
	
	@Autowired
	private IGurtProjectTypeCostConfigService gurtProjectTypeCostConfigService;
	@Resource
	private IGurtProjectTypeService gurtProjectTypeService;

	/**
	 * 新增项目基础资料
	 */
	@GetMapping("/addProjectType/{id}")
	public String addProjectType(@PathVariable("id")Long id,ModelMap modelMap) {
		GurtProjectTypeCostConfig gurtProjectTypeCostConfig=new GurtProjectTypeCostConfig();
		gurtProjectTypeCostConfig.setProjectTypeId(id);
		List<GurtProjectTypeCostConfig> gurtProjectTypeList=gurtProjectTypeCostConfigService.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
		modelMap.put("gurtProjectTypeList",gurtProjectTypeList);
		GurtProjectType gurtProjectType=gurtProjectTypeService.selectGurtProjectTypeById(id);
		modelMap.put("gurtProjectType",gurtProjectType);
		return prefix + "/addProjectType";
	}

	/**
	 * 新增保存项目基础资料
	 */
	@RequiresPermissions("baohan:gurtCategory:add")
	@Log(title = "项目基础资料", businessType = BusinessType.INSERT)
	@PostMapping("/modifyConf")
	@ResponseBody
	public AjaxResult modifyConf(
			Long[] id,
			String[] starting_amount,
			String[] ending_amount,
			String[] single_payment_cost,
			String[] multiple_payment_cost,
			String type,
			GurtProjectType gurtProjectType,
			Long gurtProjectTypeid
	) {
		String[] result1 = type.split(",");
		gurtProjectType.setId(gurtProjectTypeid);
		gurtProjectTypeService.updateGurtProjectType(gurtProjectType);
		gurtProjectTypeCostConfigService.insertAndUpdateGurtProjectTypeCostConfig(
				id,
				starting_amount,
				ending_amount,
				single_payment_cost,
				multiple_payment_cost,
				result1,
				gurtProjectType
		);
		return toAjax(1);
	}

	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:view")
	@GetMapping()
	public String gurtProjectTypeCostConfig()
	{
	    return prefix + "/gurtProjectTypeCostConfig";
	}
	
	/**
	 * 查询项目分类列表
	 */
	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
	{
		startPage();
        List<GurtProjectTypeCostConfig> list = gurtProjectTypeCostConfigService.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
		return getDataTable(list);
	}
	
	
	/**
	 * 导出项目分类列表
	 */
	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:export")
    @PostMapping("/export")
    @ResponseBody
    public AjaxResult export(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
    {
    	List<GurtProjectTypeCostConfig> list = gurtProjectTypeCostConfigService.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
        ExcelUtil<GurtProjectTypeCostConfig> util = new ExcelUtil<GurtProjectTypeCostConfig>(GurtProjectTypeCostConfig.class);
        return util.exportExcel(list, "gurtProjectTypeCostConfig");
    }
	
	/**
	 * 新增项目分类
	 */
	@GetMapping("/add")
	public String add()
	{
	    return prefix + "/add";
	}
	
	/**
	 * 新增保存项目分类
	 */
	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:add")
	@Log(title = "项目分类", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
	{		
		return toAjax(gurtProjectTypeCostConfigService.insertGurtProjectTypeCostConfig1(gurtProjectTypeCostConfig));
	}

	/**
	 * 修改项目分类
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		GurtProjectTypeCostConfig gurtProjectTypeCostConfig = gurtProjectTypeCostConfigService.selectGurtProjectTypeCostConfigById(id);
		mmap.put("gurtProjectTypeCostConfig", gurtProjectTypeCostConfig);
	    return prefix + "/edit";
	}
	
	/**
	 * 修改保存项目分类
	 */
	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:edit")
	@Log(title = "项目分类", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
	{		
		return toAjax(gurtProjectTypeCostConfigService.updateGurtProjectTypeCostConfig(gurtProjectTypeCostConfig));
	}

	/**
	 * 删除项目分类
	 */
	@RequiresPermissions("baohan:gurtProjectTypeCostConfig:remove")
	@Log(title = "项目分类", businessType = BusinessType.DELETE)
	@GetMapping( "/del/{id}")
	public String remove(@PathVariable("id") Integer id)
	{
		gurtProjectTypeCostConfigService.deleteGurtProjectTypeCostConfigByIds(String.valueOf(id));
		gurtProjectTypeService.deleteGurtProjectTypeByIds(String.valueOf(id));

		return "redirect:/baohan/gurtCategory";
	}
	
}
