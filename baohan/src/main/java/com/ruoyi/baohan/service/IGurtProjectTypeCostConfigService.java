package com.ruoyi.baohan.service;

import com.ruoyi.baohan.domain.GurtProjectType;
import com.ruoyi.baohan.domain.GurtProjectTypeCostConfig;
import java.util.List;

/**
 * 项目分类 服务层
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
public interface IGurtProjectTypeCostConfigService 
{
	/**
     * 查询项目分类信息
     * 
     * @param id 项目分类ID
     * @return 项目分类信息
     */
	public GurtProjectTypeCostConfig selectGurtProjectTypeCostConfigById(Long id);
	
	/**
     * 查询项目分类列表
     * 
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 项目分类集合
     */
	public List<GurtProjectTypeCostConfig> selectGurtProjectTypeCostConfigList(GurtProjectTypeCostConfig gurtProjectTypeCostConfig);
	
	/**
     * 新增项目分类
     *
     * @return 结果
     */
	public int insertGurtProjectTypeCostConfig(String[] starting_amount,String[] ending_amount,
											   String[] single_payment_cost,String[] multiple_payment_cost,
											   String[] result,String projectName,int catId);

	int insertAndUpdateGurtProjectTypeCostConfig(Long[] id,String[] starting_amount, String[] ending_amount,
												 String[] single_payment_cost, String[] multiple_payment_cost,
												 String[] result, GurtProjectType gurtProjectType);

	public int insertGurtProjectTypeCostConfig1(GurtProjectTypeCostConfig gurtProjectTypeCostConfig);
	/**
     * 修改项目分类
     * 
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 结果
     */
	public int updateGurtProjectTypeCostConfig(GurtProjectTypeCostConfig gurtProjectTypeCostConfig);
		
	/**
     * 删除项目分类信息
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtProjectTypeCostConfigByIds(String ids);
	int deleteGurtProjectTypeCostConfigByCatId(Long id);
}
