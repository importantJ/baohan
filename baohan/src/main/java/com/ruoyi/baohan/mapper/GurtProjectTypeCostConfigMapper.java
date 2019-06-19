package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtProjectTypeCostConfig;
import java.util.List;	

/**
 * 项目分类 数据层
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
public interface GurtProjectTypeCostConfigMapper 
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
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 结果
     */
	public int insertGurtProjectTypeCostConfig(GurtProjectTypeCostConfig gurtProjectTypeCostConfig);
	
	/**
     * 修改项目分类
     * 
     * @param gurtProjectTypeCostConfig 项目分类信息
     * @return 结果
     */
	public int updateGurtProjectTypeCostConfig(GurtProjectTypeCostConfig gurtProjectTypeCostConfig);
	
	/**
     * 删除项目分类
     * 
     * @param id 项目分类ID
     * @return 结果
     */
	public int deleteGurtProjectTypeCostConfigById(Long id);
	
	/**
     * 批量删除项目分类
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtProjectTypeCostConfigByIds(String[] ids);
	int deleteGurtProjectTypeCostConfigByCatId(Long id);
}