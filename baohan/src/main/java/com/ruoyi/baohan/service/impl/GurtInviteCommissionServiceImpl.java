package com.ruoyi.baohan.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtInviteCommissionMapper;
import com.ruoyi.baohan.domain.GurtInviteCommission;
import com.ruoyi.baohan.service.IGurtInviteCommissionService;
import com.ruoyi.common.core.text.Convert;

/**
 * 邀请提成 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Service
public class GurtInviteCommissionServiceImpl implements IGurtInviteCommissionService 
{
	@Autowired
	private GurtInviteCommissionMapper gurtInviteCommissionMapper;

	/**
     * 查询邀请提成信息
     * 
     * @param id 邀请提成ID
     * @return 邀请提成信息
     */
    @Override
	public GurtInviteCommission selectGurtInviteCommissionById(Long id)
	{
	    return gurtInviteCommissionMapper.selectGurtInviteCommissionById(id);
	}
	
	/**
     * 查询邀请提成列表
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 邀请提成集合
     */
	@Override
	public List<GurtInviteCommission> selectGurtInviteCommissionList(GurtInviteCommission gurtInviteCommission)
	{
	    return gurtInviteCommissionMapper.selectGurtInviteCommissionList(gurtInviteCommission);
	}
	
    /**
     * 新增邀请提成
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 结果
     */
	@Override
	public int insertGurtInviteCommission(GurtInviteCommission gurtInviteCommission)
	{
	    return gurtInviteCommissionMapper.insertGurtInviteCommission(gurtInviteCommission);
	}
	
	/**
     * 修改邀请提成
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 结果
     */
	@Override
	public int updateGurtInviteCommission(GurtInviteCommission gurtInviteCommission)
	{
	    return gurtInviteCommissionMapper.updateGurtInviteCommission(gurtInviteCommission);
	}

	/**
     * 删除邀请提成对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtInviteCommissionByIds(String ids)
	{
		return gurtInviteCommissionMapper.deleteGurtInviteCommissionByIds(Convert.toStrArray(ids));
	}
	
}
