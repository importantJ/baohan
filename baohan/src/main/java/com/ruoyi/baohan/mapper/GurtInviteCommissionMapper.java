package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtInviteCommission;
import java.util.List;	

/**
 * 邀请提成 数据层
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public interface GurtInviteCommissionMapper 
{
	/**
     * 查询邀请提成信息
     * 
     * @param id 邀请提成ID
     * @return 邀请提成信息
     */
	public GurtInviteCommission selectGurtInviteCommissionById(Long id);
	
	/**
     * 查询邀请提成列表
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 邀请提成集合
     */
	public List<GurtInviteCommission> selectGurtInviteCommissionList(GurtInviteCommission gurtInviteCommission);
	
	/**
     * 新增邀请提成
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 结果
     */
	public int insertGurtInviteCommission(GurtInviteCommission gurtInviteCommission);
	
	/**
     * 修改邀请提成
     * 
     * @param gurtInviteCommission 邀请提成信息
     * @return 结果
     */
	public int updateGurtInviteCommission(GurtInviteCommission gurtInviteCommission);
	
	/**
     * 删除邀请提成
     * 
     * @param id 邀请提成ID
     * @return 结果
     */
	public int deleteGurtInviteCommissionById(Long id);
	
	/**
     * 批量删除邀请提成
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtInviteCommissionByIds(String[] ids);
	
}