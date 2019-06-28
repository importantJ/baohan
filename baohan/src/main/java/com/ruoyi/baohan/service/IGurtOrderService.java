package com.ruoyi.baohan.service;

import com.ruoyi.baohan.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单 服务层
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public interface IGurtOrderService 
{
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
	public int insertGurtOrder(GurtOrder gurtOrder,String[] fileNames,String[] fileUrls,String[] money);
	List<GurtBank> getAllBank();
	/**
     * 修改订单
     * 
     * @param gurtOrder 订单信息
     * @return 结果
     */
	int updateOrderstatus(GurtOrder gurtOrder);
	public int updateGurtOrder(GurtOrder gurtOrder,String[] fileNames,String[] fileUrls,String[] money);
	List<GurtStatus> getStatus();
	/**
     * 删除订单信息
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	int addshezhi(Gurtshezhi gurtshezhi);

	int delAll();

	int deleteGurtOrderByIds(String ids);

	List<GurtOrderFile> selectOrderFile(Integer orderId);

	int delorderfile(Integer id);

	int insertinviteCommission(GurtOrder gurtOrder);

	List<GurtOrderRecord> getRecordByOrderId(Integer orderId);
}
