package com.ruoyi.baohan.service.impl;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.ruoyi.baohan.domain.*;
import com.ruoyi.baohan.mapper.GurtProjectTypeCostConfigMapper;
import com.ruoyi.baohan.mapper.UserMapper;
import com.ruoyi.framework.util.ShiroUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.cache.CacheProperties;
import org.springframework.stereotype.Service;
import com.ruoyi.baohan.mapper.GurtOrderMapper;
import com.ruoyi.baohan.service.IGurtOrderService;
import com.ruoyi.common.core.text.Convert;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

/**
 * 订单 服务层实现
 *
 * @author ruoyi
 * @date 2019-06-14
 */
@Service
@Transactional
public class GurtOrderServiceImpl implements IGurtOrderService {
    @Resource
    private GurtOrderMapper gurtOrderMapper;

    /**
     * 查询订单信息
     *
     * @param id 订单ID
     * @return 订单信息
     */
    @Override
    public GurtOrder selectGurtOrderById(Long id) {
        return gurtOrderMapper.selectGurtOrderById(id);
    }

    /**
     * 查询订单列表
     *
     * @param gurtOrder 订单信息
     * @return 订单集合
     */
    @Override
    public List<GurtOrder> selectGurtOrderList(GurtOrder gurtOrder) {
        return gurtOrderMapper.selectGurtOrderList(gurtOrder);
    }

    /**
     * 新增订单
     *
     * @param gurtOrder 订单信息
     * @return 结果
     */
    @Override
    public int insertGurtOrder(GurtOrder gurtOrder, String[] fileNames, String[] fileUrls, String[] money) {
        Long userId = ShiroUtils.getSysUser().getUserId();
        gurtOrder.setCreateUserId(userId);

        //新增订单
        gurtOrderMapper.insertGurtOrder(gurtOrder);

        //新增订单文件

        for (int i = 0; i < fileNames.length; i++) {
            GurtOrderFile gurtOrderFile = new GurtOrderFile();
            gurtOrderFile.setCreateUserId(userId);
            gurtOrderFile.setOrderId(gurtOrder.getId());
            gurtOrderFile.setName(fileNames[i]);
            gurtOrderFile.setFileDownLoadUrl(fileUrls[i]);
            gurtOrderMapper.insertOrderFile(gurtOrderFile);

        }

        //新增已付金额
        if (money != null) {
            for (int i = 0; i < money.length; i++) {
                if (money[i] == "" || money.equals("0")) {
                    break;
                }
                gurtOrderMapper.insertOrderRecord(gurtOrder.getId(), money[i]);
            }
        }


		/*
		提成
		Integer ivId=ShiroUtils.getSysUser().getInviteUserId();
		if(ivId!=null){
			gurtOrderMapper.insertinviteCommission(gurtOrder.getId(),"提交金额");
		}*/


        return 1;
    }

    @Override
    public List<GurtBank> getAllBank() {
        return gurtOrderMapper.getAllBank();
    }

    @Override
    public int updateOrderstatus(GurtOrder gurtOrder) {
        return gurtOrderMapper.updateGurtOrder(gurtOrder);
    }

    /**
     * 修改订单
     *
     * @param gurtOrder 订单信息
     * @return 结果
     */
    @Override
    public int updateGurtOrder(GurtOrder gurtOrder, String[] fileNames, String[] fileUrls, String[] money) {
        Long userId = ShiroUtils.getSysUser().getUserId();

        Integer flag = gurtOrderMapper.updateGurtOrder(gurtOrder);
        if (fileNames.length != 0) {
            for (int i = 0; i < fileNames.length; i++) {
                GurtOrderFile gurtOrderFile = new GurtOrderFile();
                gurtOrderFile.setCreateUserId(userId);
                gurtOrderFile.setOrderId(gurtOrder.getId());
                gurtOrderFile.setName(fileNames[i]);
                gurtOrderFile.setFileDownLoadUrl(fileUrls[i]);
                gurtOrderMapper.insertOrderFile(gurtOrderFile);
            }
        }

        gurtOrderMapper.delByOrderId(gurtOrder.getId());
        if (money != null) {
            for (int i = 0; i < money.length; i++) {
                if (money[i] == "" || money.equals("0")) {
                    break;
                }
                gurtOrderMapper.insertOrderRecord(gurtOrder.getId(), money[i]);
            }
        }
        return flag;
    }

    @Override
    public List<GurtStatus> getStatus() {
        return gurtOrderMapper.getStatus();
    }

    @Override
    public int addshezhi(Gurtshezhi gurtshezhi) {
        return gurtOrderMapper.addshezhi(gurtshezhi);
    }

    @Override
    public int delAll() {
        return gurtOrderMapper.delAll();
    }

    /**
     * 删除订单对象
     *
     * @param ids 需要删除的数据ID
     * @return 结果
     */
    @Override
    public int deleteGurtOrderByIds(String ids) {
        return gurtOrderMapper.deleteGurtOrderByIds(Convert.toStrArray(ids));
    }

    @Override
    public List<GurtOrderFile> selectOrderFile(Integer orderId) {
        return gurtOrderMapper.selectOrderFile(orderId);
    }

    @Override
    public int delorderfile(Integer id) {
        return gurtOrderMapper.delorderfile(id);
    }

    @Resource
    private UserMapper userMapper;
    @Resource
    private GurtProjectTypeCostConfigMapper gurtProjectTypeCostConfigMapper;

    @Override
    public int insertinviteCommission(GurtOrder gurtOrder) throws Exception {
        Calendar cal = Calendar.getInstance();
        Calendar start = Calendar.getInstance();
        Calendar end = Calendar.getInstance();
        int count = 0;
        List<GurtOrder> gurtOrderList = gurtOrderMapper.selectGurtOrderList(new GurtOrder());


        for (GurtOrder order : gurtOrderList) {
            if (order.getWarrantee().equals(gurtOrder.getWarrantee())
                    && order.getBeneficiary().equals(gurtOrder.getBeneficiary())
                    && order.getProjectNumber().equals(gurtOrder.getProjectNumber())
                    && order.getProjectName().equals(gurtOrder.getProjectName())
                    && order.getGuaranteeAmount().equals(gurtOrder.getGuaranteeAmount())) {

                Date date = new Date();
                Long result = date.getTime() - order.getBankSubmissionTime().getTime();
                if (result < (24 * 3600000)) {

                    List<Gurtshezhi> gurtshezhiList = gurtOrderMapper.getAllShezhi();
                    for (Gurtshezhi gurtshezhi : gurtshezhiList) {

                        SimpleDateFormat df = new SimpleDateFormat("HH:mm");
                        Date startHH = df.parse(df.format(gurtshezhi.getStarttime()));
                        start.setTime(startHH);

                        Date endHH = df.parse(df.format(gurtshezhi.getEndtime()));
                        end.setTime(endHH);

                        Date nowHH = df.parse(df.format(date));
                        cal.setTime(nowHH);

                        if (cal.after(end) && cal.before(start))
                            count++;
                    }

                }
            }
        }

        if (count > 2) {
            GurtProjectTypeCostConfig gurtProjectTypeCostConfig = new GurtProjectTypeCostConfig();
            gurtProjectTypeCostConfig.setProjectTypeId(gurtOrder.getProjectTypeId());
            User user = userMapper.selectUserById(gurtOrder.getCreateUserId());
            if (user.getCategoryId() != null) {
                gurtProjectTypeCostConfig.setCategoryId(user.getCategoryId().intValue());
            } else {
                gurtProjectTypeCostConfig.setCategoryId(0);
            }
            List<GurtProjectTypeCostConfig> gurtProjectTypeCostConfigList =
                    gurtProjectTypeCostConfigMapper.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
            for (GurtProjectTypeCostConfig g : gurtProjectTypeCostConfigList) {
                if (g.getStartingAmount() < gurtOrder.getGuaranteeAmount() && g.getEndingAmount() > gurtOrder.getGuaranteeAmount()) {
                    if (g.getMultiplePaymentCountType() == 0) {
                        gurtOrder.setAmount(g.getMultiplePaymentCost());
                        gurtOrderMapper.updateGurtOrder(gurtOrder);
                    } else {
                        gurtOrder.setAmount(gurtOrder.getGuaranteeAmount() * g.getMultiplePaymentCost() / 100);
                        gurtOrderMapper.updateGurtOrder(gurtOrder);
                    }
                }
            }
        }

        Long money = null;
        //订单创建人信息
        User user = userMapper.selectUserById(gurtOrder.getCreateUserId());
        //根据创建人id查找邀请人
        if (user.getInviteUserId() != null) {
            //邀请人信息
            User ivUser = userMapper.selectUserById(user.getInviteUserId());
            if (ivUser.getCategoryId() != null) {
                GurtProjectTypeCostConfig gurtProjectTypeCostConfig = new GurtProjectTypeCostConfig();
                gurtProjectTypeCostConfig.setProjectTypeId(gurtOrder.getProjectTypeId());
                gurtProjectTypeCostConfig.setCategoryId(ivUser.getCategoryId().intValue());
                List<GurtProjectTypeCostConfig> gurtProjectTypeCostConfigList = gurtProjectTypeCostConfigMapper.selectGurtProjectTypeCostConfigList(gurtProjectTypeCostConfig);
                for (GurtProjectTypeCostConfig g1 : gurtProjectTypeCostConfigList) {
                    if (g1.getStartingAmount() < gurtOrder.getGuaranteeAmount() && g1.getEndingAmount() > gurtOrder.getGuaranteeAmount()) {
                        if (g1.getSinglePaymentCountType() == 0) {
                            if (count > 1) {
                                money = gurtOrder.getAmount() - g1.getMultiplePaymentCost();
                            } else {
                                money = gurtOrder.getAmount() - g1.getSinglePaymentCost();
                            }
                        } else {
                            if (count > 1) {
                                money = (gurtOrder.getAmount() * g1.getMultiplePaymentCost() / 100);
                            } else {
                                money = (gurtOrder.getAmount() * g1.getSinglePaymentCost() / 100);
                            }
                        }
                    }
                }
                double cb = gurtOrderMapper.getcb();
                int ticheng = (int) (cb * money);
                gurtOrderMapper.delticheng(gurtOrder.getId());
                gurtOrderMapper.insertinviteCommission(gurtOrder.getId(), ticheng);

            }
        }
        return count;
    }

    @Override
    public List<GurtOrderRecord> getRecordByOrderId(Integer orderId) {
        return gurtOrderMapper.getRecordByOrderId(orderId);
    }

}
