package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtProjectType;
import java.util.List;	

/**
 * 项目名称 数据层
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
public interface GurtProjectTypeMapper 
{
	/**
     * 查询项目名称信息
     * 
     * @param id 项目名称ID
     * @return 项目名称信息
     */
	public GurtProjectType selectGurtProjectTypeById(Long id);


	int deleteGurtProjectTypeById1(Long id);
	/**
     * 查询项目名称列表
     * 
     * @param gurtProjectType 项目名称信息
     * @return 项目名称集合
     */
	public List<GurtProjectType> selectGurtProjectTypeList(GurtProjectType gurtProjectType);
	
	/**
     * 新增项目名称
     * 
     * @param gurtProjectType 项目名称信息
     * @return 结果
     */
	public int insertGurtProjectType(GurtProjectType gurtProjectType);
	
	/**
     * 修改项目名称
     * 
     * @param gurtProjectType 项目名称信息
     * @return 结果
     */
	public int updateGurtProjectType(GurtProjectType gurtProjectType);
	
	/**
     * 删除项目名称
     * 
     * @param id 项目名称ID
     * @return 结果
     */
	public int deleteGurtProjectTypeById(Long id);
	
	/**
     * 批量删除项目名称
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtProjectTypeByIds(String[] ids);
	
}