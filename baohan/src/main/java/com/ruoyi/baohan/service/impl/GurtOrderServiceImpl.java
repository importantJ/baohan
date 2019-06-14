package com.ruoyi.baohan.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtOrderMapper;
import com.ruoyi.baohan.domain.GurtOrder;
import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.common.core.text.Convert;

/**
 * 订单 服务层实现
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
@Service
public class GurtOrderServiceImpl implements IGurtOrderService 
{
	@Autowired
	private GurtOrderMapper gurtOrderMapper;

	/**
     * 查询订单信息
     * 
     * @param id 订单ID
     * @return 订单信息
     */
    @Override
	public GurtOrder selectGurtOrderById(Long id)
	{
	    return gurtOrderMapper.selectGurtOrderById(id);
	}
	
	/**
     * 查询订单列表
     * 
     * @param gurtOrder 订单信息
     * @return 订单集合
     */
	@Override
	public List<GurtOrder> selectGurtOrderList(GurtOrder gurtOrder)
	{
	    return gurtOrderMapper.selectGurtOrderList(gurtOrder);
	}
	
    /**
     * 新增订单
     * 
     * @param gurtOrder 订单信息
     * @return 结果
     */
	@Override
	public int insertGurtOrder(GurtOrder gurtOrder)
	{
	    return gurtOrderMapper.insertGurtOrder(gurtOrder);
	}
	
	/**
     * 修改订单
     * 
     * @param gurtOrder 订单信息
     * @return 结果
     */
	@Override
	public int updateGurtOrder(GurtOrder gurtOrder)
	{
	    return gurtOrderMapper.updateGurtOrder(gurtOrder);
	}

	/**
     * 删除订单对象
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	@Override
	public int deleteGurtOrderByIds(String ids)
	{
		return gurtOrderMapper.deleteGurtOrderByIds(Convert.toStrArray(ids));
	}
	
}
