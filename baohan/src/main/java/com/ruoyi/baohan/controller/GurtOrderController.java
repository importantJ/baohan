package com.ruoyi.baohan.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

import com.ruoyi.baohan.domain.*;
import com.ruoyi.baohan.service.*;
import com.ruoyi.common.config.Global;
import com.ruoyi.common.config.ServerConfig;
import com.ruoyi.common.utils.file.FileUtils;
import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysRole;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.service.ISysUserService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import com.ruoyi.common.annotation.Log;
import com.ruoyi.common.enums.BusinessType;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.page.TableDataInfo;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.poi.ExcelUtil;
import org.springframework.web.multipart.MultipartFile;

import javax.rmi.CORBA.Util;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * 订单 信息操作处理
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Controller
@RequestMapping("/baohan/gurtOrder")
public class 	GurtOrderController extends BaseController
{
    private String prefix = "baohan/gurtOrder";
	
	@Autowired
	private IGurtOrderService gurtOrderService;
	@Autowired
    private IGurtGuaranteeService iGurtGuaranteeService;
    @Autowired
    private ISysUserService iUserService;
    @Autowired
    private IGurtProjectTypeService iGurtProjectTypeService;
	@Autowired
	private IGurtProjectTypeCostConfigService iGurtProjectTypeCostConfigService;


	@GetMapping()
	public String gurtOrder(ModelMap modelMap)
	{
		UtilOrder.gurtOrder(modelMap,gurtOrderService);
	    return prefix + "/gurtOrder";
	}

	@GetMapping("/modifystatus/{id}")
	public Object status(@PathVariable("id") Long id,ModelMap modelMap)throws Exception{
		GurtOrder gurtOrder=gurtOrderService.selectGurtOrderById(id);
		if(gurtOrder.getStatus()<4){
			gurtOrder.setStatus(gurtOrder.getStatus()+1);
		}else if(gurtOrder.getStatus()==4){
			gurtOrder.setStatus(Long.valueOf(1));
		}
		if(gurtOrder.getStatus()==3){
			//提交
			gurtOrderService.insertinviteCommission(gurtOrder);
		}
		gurtOrderService.updateOrderstatus(gurtOrder);
		UtilOrder.gurtOrder(modelMap,gurtOrderService);
		return prefix + "/gurtOrder";
	}

	@GetMapping("/modifytijiao")
	@ResponseBody
	public Object modifytijiao(Long[] ids){
		for(int i=0;i<ids.length;i++){
			GurtOrder gurtOrder=new GurtOrder();
			gurtOrder.setId(ids[i]);
			gurtOrder.setStatus(Long.valueOf(1));
			gurtOrderService.updateOrderstatus(gurtOrder);
		}
		return "提交成功";
	}

	@GetMapping("/modifystatusche/{id}")
	public Object statusche(@PathVariable("id") Long id,ModelMap modelMap){
		GurtOrder gurtOrder=new GurtOrder();
		gurtOrder.setId(id);
		gurtOrder.setStatus(Long.valueOf(4));
		gurtOrderService.updateOrderstatus(gurtOrder);
		UtilOrder.gurtOrder(modelMap,gurtOrderService);
		return prefix + "/gurtOrder";
	}
	/**
	 * 查询订单列表
	 */
	@RequiresPermissions("baohan:gurtOrder:list")
	@PostMapping("/list")
	@ResponseBody
	public TableDataInfo list(GurtOrder gurtOrder,ModelMap modelMap)
	{
		List<GurtStatus> statusList=gurtOrderService.getStatus();
		modelMap.put("statusList",statusList);
		int role=UtilOrder.getRole();
		modelMap.put("role",role);

		startPage();
        List<GurtOrder> list =null;
        if(role==1){
        	list= gurtOrderService.selectGurtOrderList(gurtOrder);
		}else{
        	gurtOrder.setCreateUserId(ShiroUtils.getUserId());
        	list=gurtOrderService.selectGurtOrderList(gurtOrder);
		}
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
	@PostMapping("/importData")
	@ResponseBody
	public AjaxResult importData(MultipartFile file, boolean updateSupport) throws Exception
	{
		ExcelUtil<GurtOrder> util = new ExcelUtil<GurtOrder>(GurtOrder.class);
		List<GurtOrder> gurtOrderList = util.importExcel(file.getInputStream());
		gurtOrderService.importExcel(gurtOrderList);
		return AjaxResult.success(1);
	}

	@GetMapping("/xiazai")
	@ResponseBody
	public AjaxResult xiazai(@RequestParam("url") String url, HttpServletResponse response,
							 HttpServletRequest request)throws IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition",
				"attachment;fileName=" + FileUtils.setFileDownloadHeader(request,String.valueOf(System.currentTimeMillis())));
		FileUtils.writeBytes(url, response.getOutputStream());
		return AjaxResult.success(1);
	}
	/**
	 * 新增订单
	 */
	@GetMapping("/add")
	public String add(ModelMap modelMap)
	{

 		SysUser currentUser = ShiroUtils.getSysUser();

 		//查询保函下拉框
        List<GurtGuarantee> gurtGuaranteeList=iGurtGuaranteeService.selectGurtGuaranteeList(new GurtGuarantee());
        //银行下拉框
        List<GurtBank> bankList=gurtOrderService.getAllBank();


        currentUser=iUserService.selectUserById(currentUser.getUserId());
        GurtProjectType gurtProjectType=new GurtProjectType();
        //分类下拉框
        gurtProjectType.setCatId(0);
        List<GurtProjectType> gurtProjectTypeList=iGurtProjectTypeService.selectGurtProjectTypeList(gurtProjectType);


        modelMap.put("gurtGuaranteeList",gurtGuaranteeList);
		modelMap.put("bankList",bankList);
		modelMap.put("gurtProjectTypeList",gurtProjectTypeList);
		int role=0;
		List<SysRole> user=ShiroUtils.getSysUser().getRoles();
		for (int i=0;i<user.size();i++){
			if(user.get(i).getRoleName().equals("管理员")||user.get(i).getRoleName().equals("客户经理"))
				role=1;
		}
		modelMap.put("role",role);
	    return prefix + "/add";
	}

	@Autowired
	private ServerConfig serverConfig;
	/**
	 * 新增保存订单
	 */
	@RequiresPermissions("baohan:gurtOrder:add")
	@Log(title = "订单", businessType = BusinessType.INSERT)
	@PostMapping("/add")
	@ResponseBody
	public AjaxResult addSave(GurtOrder gurtOrder,String[] fileNames,String[] fileUrls,String[] money)
	{
	    GurtGuarantee gurtGuarantee=iGurtGuaranteeService.selectGurtGuaranteeById(gurtOrder.getGuaranteeId());
	    String baourl=gurtGuarantee.getGuaranteeFilePath();
	    String ab=Global.getUploadPath()+baourl.substring(baourl.lastIndexOf("/"));
        Map map=new HashMap();
        map.put("warrantee",gurtOrder.getWarrantee());
        map.put("beneficiary",gurtOrder.getBeneficiary());
        List<GurtProjectType> gurtProjectTypeList=iGurtProjectTypeService.selectGurtProjectTypeList(new GurtProjectType());
        for (GurtProjectType type : gurtProjectTypeList) {
            if(type.getId()==gurtOrder.getProjectTypeId())
                gurtOrder.setFenName(type.getName());
        }
        map.put("fenName",gurtOrder.getFenName());
        map.put("xiao",gurtOrder.getAmount().toString());
        map.put("da",UtilNumber.convert(gurtOrder.getAmount().toString()));
        Calendar calendar = Calendar.getInstance();
        Date date=new Date();
        calendar.setTime(date);
        map.put("yy",String.valueOf(calendar.get(Calendar.YEAR)));
        map.put("mm",String.valueOf(calendar.get(Calendar.MONTH) + 1));
        map.put("dd",String.valueOf(calendar.get(Calendar.DATE)));
        String newpath=Global.getUploadPath()+baourl.substring(baourl.lastIndexOf("/"),baourl.lastIndexOf("/"))+gurtOrder.getWarrantee()+gurtOrder.getBeneficiary()+".docx";
        Replace.searchAndReplace(ab,newpath,map);
		String a=serverConfig.getUrl()+newpath.substring(newpath.lastIndexOf("/profile"));
        gurtOrder.setBaohanfile(a);
		return toAjax(gurtOrderService.insertGurtOrder(gurtOrder,fileNames,fileUrls,money));
	}
	/**
	 * 修改保存订单
	 */
	@RequiresPermissions("baohan:gurtOrder:edit")
	@Log(title = "订单", businessType = BusinessType.UPDATE)
	@PostMapping("/edit")
	@ResponseBody
	public AjaxResult editSave(GurtOrder gurtOrder,String[] fileNames,String[] fileUrls,String[] money)
	{
        GurtGuarantee gurtGuarantee=iGurtGuaranteeService.selectGurtGuaranteeById(gurtOrder.getGuaranteeId());
        String baourl=gurtGuarantee.getGuaranteeFilePath();
        String ab=Global.getUploadPath()+baourl.substring(baourl.lastIndexOf("/"));
        Map map=new HashMap();
        map.put("warrantee",gurtOrder.getWarrantee());
        map.put("beneficiary",gurtOrder.getBeneficiary());
        List<GurtProjectType> gurtProjectTypeList=iGurtProjectTypeService.selectGurtProjectTypeList(new GurtProjectType());
        for (GurtProjectType type : gurtProjectTypeList) {
            if(type.getId()==gurtOrder.getProjectTypeId())
                gurtOrder.setFenName(type.getName());
        }
        map.put("fenName",gurtOrder.getFenName());
        map.put("xiao",gurtOrder.getAmount().toString());
        map.put("da",UtilNumber.convert(gurtOrder.getAmount().toString()));
        Calendar calendar = Calendar.getInstance();
        Date date=new Date();
        calendar.setTime(date);
        map.put("yy",String.valueOf(calendar.get(Calendar.YEAR)));
        map.put("mm",String.valueOf(calendar.get(Calendar.MONTH) + 1));
        map.put("dd",String.valueOf(calendar.get(Calendar.DATE)));
        String newpath=Global.getUploadPath()+baourl.substring(baourl.lastIndexOf("/"),baourl.lastIndexOf("/"))+gurtOrder.getWarrantee()+gurtOrder.getBeneficiary()+".docx";
        Replace.searchAndReplace(ab,newpath,map);
        String a=serverConfig.getUrl()+newpath.substring(newpath.lastIndexOf("/profile"));
        gurtOrder.setBaohanfile(a);
		return toAjax(gurtOrderService.updateGurtOrder(gurtOrder,fileNames,fileUrls,money));
	}

	/**
	 * 显示应付金额
	 */
	@GetMapping("/money")
	@ResponseBody
	public Object money(GurtOrder gurtOrder)
	{
		GurtProjectTypeCostConfig gurtProjectTypeCostConfig=new GurtProjectTypeCostConfig();
		gurtProjectTypeCostConfig.setProjectTypeId(gurtOrder.getProjectTypeId());
		if(ShiroUtils.getSysUser().getCatId()==null){
			gurtProjectTypeCostConfig.setCategoryId(0);
		}else{
			gurtProjectTypeCostConfig.setCategoryId(ShiroUtils.getSysUser().getCatId());
		}
		List<GurtProjectTypeCostConfig> gurtProjectTypeCostConfigList=iGurtProjectTypeCostConfigService.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
		for (GurtProjectTypeCostConfig g :gurtProjectTypeCostConfigList) {
			if(g.getStartingAmount()<gurtOrder.getGuaranteeAmount()&&g.getEndingAmount()>gurtOrder.getGuaranteeAmount()){
				if(g.getSinglePaymentCountType()==0) {
					gurtOrder.setAmount(g.getSinglePaymentCost());
				}else{
					gurtOrder.setAmount(gurtOrder.getGuaranteeAmount()*g.getSinglePaymentCost()/100);
				}
			}
		}
		Map map=new HashMap();
		map.put("gurtOrder",gurtOrder);
		return map;
	}

	/**
	 * 修改订单
	 */
	@GetMapping("/edit/{id}")
	public String edit(@PathVariable("id") Long id, ModelMap mmap)
	{
		List<GurtOrderFile> fileList=gurtOrderService.selectOrderFile(id.intValue());
		mmap.put("fileList", fileList);
		GurtOrder gurtOrder = gurtOrderService.selectGurtOrderById(id);
		mmap.put("gurtOrder", gurtOrder);
		List<GurtGuarantee> gurtGuaranteeList=iGurtGuaranteeService.selectGurtGuaranteeList(new GurtGuarantee());

		List<GurtBank> bankList=gurtOrderService.getAllBank();

		GurtProjectType gurtProjectType=new GurtProjectType();

		gurtProjectType.setCatId(0);
		List<GurtProjectType> gurtProjectTypeList=iGurtProjectTypeService.selectGurtProjectTypeList(gurtProjectType);
		int role=0;
		List<SysRole> user=ShiroUtils.getSysUser().getRoles();
		for (int i=0;i<user.size();i++){
			if(user.get(i).getRoleName().equals("管理员")||user.get(i).getRoleName().equals("客户经理"))
				role=1;
		}
		List<GurtOrderRecord> gurtOrderRecordList=gurtOrderService.getRecordByOrderId(id.intValue());
		int sum=0;
		for (GurtOrderRecord record : gurtOrderRecordList) {
			sum+=record.getPaidamount();
		}
		mmap.put("sum",sum);
		mmap.put("gurtGuaranteeList",gurtGuaranteeList);
		mmap.put("bankList",bankList);
		mmap.put("gurtProjectTypeList",gurtProjectTypeList);
		mmap.put("role",role);
		mmap.put("recordList",gurtOrderRecordList);
	    return prefix + "/edit";
	}

	@GetMapping("/chakan/{id}")
	public Object chakan(@PathVariable("id")Long id,ModelMap mmap){
		GurtOrder gurtOrder = gurtOrderService.selectGurtOrderById(id);
		mmap.put("gurtOrder", gurtOrder);

		List<GurtOrderFile> fileList=gurtOrderService.selectOrderFile(id.intValue());
		mmap.put("fileList", fileList);

		//查询保函下拉框
		List<GurtGuarantee> gurtGuaranteeList=iGurtGuaranteeService.selectGurtGuaranteeList(new GurtGuarantee());
		//银行下拉框
		List<GurtBank> bankList=gurtOrderService.getAllBank();

		GurtProjectType gurtProjectType=new GurtProjectType();
		//分类下拉框
		gurtProjectType.setCatId(0);
		List<GurtProjectType> gurtProjectTypeList=iGurtProjectTypeService.selectGurtProjectTypeList(gurtProjectType);

		mmap.put("gurtGuaranteeList",gurtGuaranteeList);
		mmap.put("bankList",bankList);
		mmap.put("gurtProjectTypeList",gurtProjectTypeList);
		int role=0;
		List<SysRole> user=ShiroUtils.getSysUser().getRoles();
		for (int i=0;i<user.size();i++){
			if(user.get(i).getRoleName().equals("管理员")||user.get(i).getRoleName().equals("客户经理"))
				role=1;
		}
		mmap.put("role",role);

		List<GurtOrderRecord> gurtOrderRecordList=gurtOrderService.getRecordByOrderId(id.intValue());
		int sum=0;
		for (GurtOrderRecord record : gurtOrderRecordList) {
			sum+=record.getPaidamount();
		}
		mmap.put("sum",sum);
		mmap.put("recordList",gurtOrderRecordList);
		return prefix + "/view";
	}
	@PostMapping("/delorderfile")
	@ResponseBody
	public Object delorderfile(@RequestParam("id") Integer id){
		return gurtOrderService.delorderfile(id);
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
	/**
	 * 上传招标
	 */
	@PostMapping( "/shangchuan")
	@ResponseBody
	public AjaxResult shangchuan(String ids)
	{
		return toAjax(0);
	}

	@GetMapping("/shezhi")
	@ResponseBody
	public Object shezhi(String cb,String[] starttime,String[] endtime)throws Exception{
		gurtOrderService.delAll();
		Gurtshezhi gurtshezhi=new Gurtshezhi();
		gurtshezhi.setCb(cb);
		for(int i=0;i<starttime.length;i++){
			String a="0000-00-00 "+starttime[i];
			String b="0000-00-00 "+endtime[i];
			DateFormat format= new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date start=format.parse(a);
			Date end=format.parse(b);
			gurtshezhi.setStarttime(start);
			gurtshezhi.setEndtime(end);
			gurtOrderService.addshezhi(gurtshezhi);
		}
		return gurtshezhi;
	}
}
