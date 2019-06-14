package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtCategory;
import java.util.List;	

/**
 * 项目基础资料 数据层
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public interface GurtCategoryMapper 
{
	/**
     * 查询项目基础资料信息
     * 
     * @param id 项目基础资料ID
     * @return 项目基础资料信息
     */
	public GurtCategory selectGurtCategoryById(Long id);
	
	/**
     * 查询项目基础资料列表
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 项目基础资料集合
     */
	public List<GurtCategory> selectGurtCategoryList(GurtCategory gurtCategory);
	
	/**
     * 新增项目基础资料
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 结果
     */
	public int insertGurtCategory(GurtCategory gurtCategory);
	
	/**
     * 修改项目基础资料
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 结果
     */
	public int updateGurtCategory(GurtCategory gurtCategory);
	
	/**
     * 删除项目基础资料
     * 
     * @param id 项目基础资料ID
     * @return 结果
     */
	public int deleteGurtCategoryById(Long id);
	
	/**
     * 批量删除项目基础资料
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtCategoryByIds(String[] ids);
	
}