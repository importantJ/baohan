package com.ruoyi.baohan.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtProjectTypeMapper;
import com.ruoyi.baohan.domain.GurtProjectType;
import com.ruoyi.baohan.service.IGurtProjectTypeService;
import com.ruoyi.common.core.text.Convert;

/**
 * 项目名称 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
@Service
public class GurtProjectTypeServiceImpl implements IGurtProjectTypeService 
{
	@Autowired
	private GurtProjectTypeMapper gurtProjectTypeMapper;

	/**
     * 查询项目名称信息
     * 
     * @param id 项目名称ID
     * @return 项目名称信息
     */
    @Override
	public GurtProjectType selectGurtProjectTypeById(Long id)
	{
	    return gurtProjectTypeMapper.selectGurtProjectTypeById(id);
	}
	
	/**
     * 查询项目名称列表
     * 
     * @param gurtProjectType 项目名称信息
     * @return 项目名称集合
     */
	@Override
	public List<GurtProjectType> selectGurtProjectTypeList(GurtProjectType gurtProjectType)
	{
	    return gurtProjectTypeMapper.selectGurtProjectTypeList(gurtProjectType);
	}
	
    /**
     * 新增项目名称
     * 
     * @param gurtProjectType 项目名称信息
     * @return 结果
     */
	@Override
	public int insertGurtProjectType(GurtProjectType gurtProjectType)
	{
	    return gurtProjectTypeMapper.insertGurtProjectType(gurtProjectType);
	}
	
	/**
     * 修改项目名称
     * 
     * @param gurtProjectType 项目名称信息
     * @return 结果
     */
	@Override
	public int updateGurtProjectType(GurtProjectType gurtProjectType)
	{
	    return gurtProjectTypeMapper.updateGurtProjectType(gurtProjectType);
	}

	/**
     * 删除项目名称对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtProjectTypeByIds(String ids)
	{
		return gurtProjectTypeMapper.deleteGurtProjectTypeById(Long.valueOf(ids));
	}

	@Override
	public int deleteGurtProjectTypeById1(String ids) {
		return gurtProjectTypeMapper.deleteGurtProjectTypeById1(Long.valueOf(ids));
	}

}
