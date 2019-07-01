package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 订单 数据层
 *
 * @author ruoyi
 * @date 2019-06-14
 */
public interface GurtOrderMapper {

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

    int insertOrderRecord(@Param("orderId") Long orderId, @Param("money") String money);

    int insertinviteCommission(@Param("orderId") Long orderId, @Param("commissionamount") int commissionamount);

    int delorderfile(@Param("id") Integer id);

    int delByOrderId(@Param("orderId") Long orderId);

    List<Gurtshezhi> getAllShezhi();

    List<GurtOrderRecord> getRecordByOrderId(@Param("orderId") Integer orderId);

    int delticheng(@Param("orderId")Long orderId);

    int addshezhi(Gurtshezhi gurtshezhi);

    int delAll();

    double getcb();
    List<GurtStatus> getStatus();

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

    List<GurtOrderFile> selectOrderFile(@Param("orderId") Integer orderId);
}