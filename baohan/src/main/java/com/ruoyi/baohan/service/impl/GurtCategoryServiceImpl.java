package com.ruoyi.baohan.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtCategoryMapper;
import com.ruoyi.baohan.domain.GurtCategory;
import com.ruoyi.baohan.service.IGurtCategoryService;
import com.ruoyi.common.core.text.Convert;

/**
 * 项目基础资料 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Service
public class GurtCategoryServiceImpl implements IGurtCategoryService 
{
	@Autowired
	private GurtCategoryMapper gurtCategoryMapper;

	/**
     * 查询项目基础资料信息
     * 
     * @param id 项目基础资料ID
     * @return 项目基础资料信息
     */
    @Override
	public GurtCategory selectGurtCategoryById(Long id)
	{
	    return gurtCategoryMapper.selectGurtCategoryById(id);
	}

	@Override
	public GurtCategory selectGurtCategoryAndProjectById(Long id) {
		return gurtCategoryMapper.selectGurtCategoryAndProjectById(id);
	}

	/**
     * 查询项目基础资料列表
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 项目基础资料集合
     */
	@Override
	public List<GurtCategory> selectGurtCategoryList(GurtCategory gurtCategory)
	{
	    return gurtCategoryMapper.selectGurtCategoryList(gurtCategory);
	}
	
    /**
     * 新增项目基础资料
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 结果
     */
	@Override
	public int insertGurtCategory(GurtCategory gurtCategory)
	{
	    return gurtCategoryMapper.insertGurtCategory(gurtCategory);
	}
	
	/**
     * 修改项目基础资料
     * 
     * @param gurtCategory 项目基础资料信息
     * @return 结果
     */
	@Override
	public int updateGurtCategory(GurtCategory gurtCategory)
	{
	    return gurtCategoryMapper.updateGurtCategory(gurtCategory);
	}

	/**
     * 删除项目基础资料对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtCategoryByIds(String ids)
	{
		return gurtCategoryMapper.deleteGurtCategoryByIds(Convert.toStrArray(ids));
	}
	
}
