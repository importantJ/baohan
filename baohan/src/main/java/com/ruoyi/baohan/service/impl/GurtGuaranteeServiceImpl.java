package com.ruoyi.baohan.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtGuaranteeMapper;
import com.ruoyi.baohan.domain.GurtGuarantee;
import com.ruoyi.baohan.service.IGurtGuaranteeService;
import com.ruoyi.common.core.text.Convert;
import org.springframework.transaction.annotation.Transactional;

/**
 * 保函 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Service
@Transactional
public class GurtGuaranteeServiceImpl implements IGurtGuaranteeService 
{
	@Autowired
	private GurtGuaranteeMapper gurtGuaranteeMapper;

	/**
     * 查询保函信息
     * 
     * @param id 保函ID
     * @return 保函信息
     */
    @Override
	public GurtGuarantee selectGurtGuaranteeById(Long id)
	{
	    return gurtGuaranteeMapper.selectGurtGuaranteeById(id);
	}
	
	/**
     * 查询保函列表
     * 
     * @param gurtGuarantee 保函信息
     * @return 保函集合
     */
	@Override
	public List<GurtGuarantee> selectGurtGuaranteeList(GurtGuarantee gurtGuarantee)
	{
	    return gurtGuaranteeMapper.selectGurtGuaranteeList(gurtGuarantee);
	}
	
    /**
     * 新增保函
     * 
     * @param gurtGuarantee 保函信息
     * @return 结果
     */
	@Override
	public int insertGurtGuarantee(GurtGuarantee gurtGuarantee)
	{
	    return gurtGuaranteeMapper.insertGurtGuarantee(gurtGuarantee);
	}
	
	/**
     * 修改保函
     * 
     * @param gurtGuarantee 保函信息
     * @return 结果
     */
	@Override
	public int updateGurtGuarantee(GurtGuarantee gurtGuarantee)
	{
	    return gurtGuaranteeMapper.updateGurtGuarantee(gurtGuarantee);
	}

	/**
     * 删除保函对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtGuaranteeByIds(String ids)
	{
		return gurtGuaranteeMapper.deleteGurtGuaranteeByIds(Convert.toStrArray(ids));
	}
	
}
