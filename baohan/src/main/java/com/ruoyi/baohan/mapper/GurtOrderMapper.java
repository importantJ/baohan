package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtBank;
import com.ruoyi.baohan.domain.GurtOrder;
import com.ruoyi.baohan.domain.GurtOrderFile;

import java.util.List;

/**
 * 订单 数据层
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public interface GurtOrderMapper 
{

	List<GurtBank> getAllBank();
	/**
     * 查询订单信息
     * 
     * @param id 订单ID
     * @return 订单信息
     */
	public GurtOrder selectGurtOrderById(Long id);
	
	/**
     * 查询订单列表
     * 
     * @param gurtOrder 订单信息
     * @return 订单集合
     */
	public List<GurtOrder> selectGurtOrderList(GurtOrder gurtOrder);
	
	/**
     * 新增订单
     * 
     * @param gurtOrder 订单信息
     * @return 结果
     */
	public int insertGurtOrder(GurtOrder gurtOrder);

	int insertOrderFile(GurtOrderFile orderFile);

	int insertOrderRecord(Long orderId,String money);

	int insertinviteCommission(Long orderId,String commissionamount);
	/**
     * 修改订单
     * 
     * @param gurtOrder 订单信息
     * @return 结果
     */
	public int updateGurtOrder(GurtOrder gurtOrder);
	
	/**
     * 删除订单
     * 
     * @param id 订单ID
     * @return 结果
     */
	public int deleteGurtOrderById(Long id);
	
	/**
     * 批量删除订单
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtOrderByIds(String[] ids);
	
}