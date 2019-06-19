package com.ruoyi.baohan.service.impl;

import java.util.List;

import com.ruoyi.baohan.domain.GurtProjectType;
import com.ruoyi.baohan.mapper.GurtProjectTypeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper;
import com.ruoyi.baohan.domain.GurtProjectTypeCostConfig;
import com.ruoyi.baohan.service.IGurtProjectTypeCostConfigService;
import com.ruoyi.common.core.text.Convert;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * 项目分类 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
@Service
@Transactional
public class GurtProjectTypeCostConfigServiceImpl implements IGurtProjectTypeCostConfigService 
{
	@Resource
	private GurtProjectTypeCostConfigMapper gurtProjectTypeCostConfigMapper;

	@Resource
	private GurtProjectTypeMapper gurtProjectTypeMapper;
	/**
     * 查询项目分类信息
     * 
     * @param id 项目分类ID
     * @return 项目分类信息
     */
    @Override
	public GurtProjectTypeCostConfig selectGurtProjectTypeCostConfigById(Long id)
	{
	    return gurtProjectTypeCostConfigMapper.selectGurtProjectTypeCostConfigById(id);
	}
	
	/**
     * 查询项目分类列表
     * 
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 项目分类集合
     */
	@Override
	public List<GurtProjectTypeCostConfig> selectGurtProjectTypeCostConfigList(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
	{
	    return gurtProjectTypeCostConfigMapper.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
	}

	@Override
	public int insertGurtProjectTypeCostConfig(String[] starting_amount, String[] ending_amount, String[] single_payment_cost, String[] multiple_payment_cost, String[] result, String projectName, int catId) {
		GurtProjectType gurtProjectType=new GurtProjectType();
		gurtProjectType.setName(projectName);
		gurtProjectType.setCatId(catId);
		List<GurtProjectType> gurtProjectTypeList=gurtProjectTypeMapper.selectGurtProjectTypeList(gurtProjectType);
		if(gurtProjectTypeList.size()==0){

			gurtProjectTypeMapper.insertGurtProjectType(gurtProjectType);
		}else{
			gurtProjectType=gurtProjectTypeList.get(0);
		}
		GurtProjectTypeCostConfig gurtProjectTypeCostConfig=new GurtProjectTypeCostConfig();
		gurtProjectTypeCostConfig.setCategoryId(catId);
		gurtProjectTypeCostConfig.setProjectTypeId(gurtProjectType.getId());
		for (int i=0;i<starting_amount.length;i++){
			gurtProjectTypeCostConfig.setStartingAmount(Long.valueOf(starting_amount[i]));
			gurtProjectTypeCostConfig.setEndingAmount(Long.valueOf(ending_amount[i]));
			gurtProjectTypeCostConfig.setSinglePaymentCost(Long.valueOf(single_payment_cost[i]));
			gurtProjectTypeCostConfig.setMultiplePaymentCost(Long.valueOf(multiple_payment_cost[i]));
			if(i==0){
				gurtProjectTypeCostConfig.setSinglePaymentCountType(Integer.valueOf(result[i]));
				gurtProjectTypeCostConfig.setMultiplePaymentCountType(Integer.valueOf(result[i+1]));
			}else{
				gurtProjectTypeCostConfig.setSinglePaymentCountType(Integer.valueOf(result[i*2]));
				gurtProjectTypeCostConfig.setMultiplePaymentCountType(Integer.valueOf(result[i*2+1]));
			}
			gurtProjectTypeCostConfigMapper.insertGurtProjectTypeCostConfig(gurtProjectTypeCostConfig);
		}
		return 1;
	}

	@Override
	public int insertAndUpdateGurtProjectTypeCostConfig(Long[] id,String[] starting_amount, String[] ending_amount, String[] single_payment_cost, String[] multiple_payment_cost, String[] result,GurtProjectType gurtProjectType) {
		GurtProjectTypeCostConfig gurtProjectTypeCostConfig=new GurtProjectTypeCostConfig();
		for (int i=0;i<starting_amount.length;i++){
			gurtProjectTypeCostConfig.setId(id[i]);
			gurtProjectTypeCostConfig.setStartingAmount(Long.valueOf(starting_amount[i]));
			gurtProjectTypeCostConfig.setEndingAmount(Long.valueOf(ending_amount[i]));
			gurtProjectTypeCostConfig.setSinglePaymentCost(Long.valueOf(single_payment_cost[i]));
			gurtProjectTypeCostConfig.setMultiplePaymentCost(Long.valueOf(multiple_payment_cost[i]));
			if(i==0){
				gurtProjectTypeCostConfig.setSinglePaymentCountType(Integer.valueOf(result[i]));
				gurtProjectTypeCostConfig.setMultiplePaymentCountType(Integer.valueOf(result[i+1]));
			}else{
				gurtProjectTypeCostConfig.setSinglePaymentCountType(Integer.valueOf(result[i*2]));
				gurtProjectTypeCostConfig.setMultiplePaymentCountType(Integer.valueOf(result[i*2+1]));
			}
			gurtProjectTypeCostConfigMapper.updateGurtProjectTypeCostConfig(gurtProjectTypeCostConfig);
		}
		return 1;
	}

	@Override
	public int insertGurtProjectTypeCostConfig1(GurtProjectTypeCostConfig gurtProjectTypeCostConfig) {
		return 0;
	}


	/**
     * 修改项目分类
     * 
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 结果
     */
	@Override
	public int updateGurtProjectTypeCostConfig(GurtProjectTypeCostConfig gurtProjectTypeCostConfig)
	{
	    return gurtProjectTypeCostConfigMapper.updateGurtProjectTypeCostConfig(gurtProjectTypeCostConfig);
	}

	/**
     * 删除项目分类对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtProjectTypeCostConfigByIds(String ids)
	{
		return gurtProjectTypeCostConfigMapper.deleteGurtProjectTypeCostConfigById(Long.valueOf(ids));
	}

	@Override
	public int deleteGurtProjectTypeCostConfigByCatId(Long id) {
		return gurtProjectTypeCostConfigMapper.deleteGurtProjectTypeCostConfigByCatId(id);
	}

}
