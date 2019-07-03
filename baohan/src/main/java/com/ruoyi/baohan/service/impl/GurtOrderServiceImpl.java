package com.ruoyi.baohan.service.impl;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import com.ruoyi.baohan.controller.UtilTime;
import com.ruoyi.baohan.domain.*;
import com.ruoyi.baohan.mapper.*;
import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.mapper.SysUserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
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
    @Autowired
    private GurtGuaranteeMapper gurtGuaranteeMapper;
    @Autowired
    private GurtProjectTypeMapper gurtProjectTypeMapper;
    @Autowired
    private SysUserMapper sysUserMapper;
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
        if (gurtOrder.getCreateUserId() == null)
            gurtOrder.setCreateUserId(userId);

        //新增订单
        gurtOrderMapper.insertGurtOrder(gurtOrder);

        //新增订单文件

        if (fileNames != null && fileUrls != null) {
            for (int i = 0; i < fileNames.length; i++) {
                GurtOrderFile gurtOrderFile = new GurtOrderFile();
                gurtOrderFile.setCreateUserId(userId);
                gurtOrderFile.setOrderId(gurtOrder.getId());
                gurtOrderFile.setName(fileNames[i]);
                gurtOrderFile.setFileDownLoadUrl(fileUrls[i]);
                gurtOrderMapper.insertOrderFile(gurtOrderFile);
            }
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
    private static final String formatStr = "HH:mm";
    SimpleDateFormat fmt = new SimpleDateFormat("yyyyMMdd");
    private static SimpleDateFormat sdf = new SimpleDateFormat(formatStr);

    @Override
    public int insertinviteCommission(GurtOrder gurtOrder) throws Exception {
        int count = 0;
        List<GurtOrder> gurtOrderList = gurtOrderMapper.selectGurtOrderList(new GurtOrder());


        for (GurtOrder order : gurtOrderList) {
            if (order.getWarrantee().equals(gurtOrder.getWarrantee())
                    && order.getBeneficiary().equals(gurtOrder.getBeneficiary())
                    && order.getProjectNumber().equals(gurtOrder.getProjectNumber())
                    && order.getProjectName().equals(gurtOrder.getProjectName())
                    && order.getGuaranteeAmount().equals(gurtOrder.getGuaranteeAmount())
                    && order.getId() != gurtOrder.getId()) {
                Date date = new Date();
                if(order.getBankSubmissionTime()==null)
                    break;
                Long result = date.getTime() - order.getBankSubmissionTime().getTime();

                long orderTime = UtilTime.getLong(sdf.format(order.getBankSubmissionTime()));
                long newTime = UtilTime.getLong(sdf.format(date));

                List<Gurtshezhi> gurtshezhiList = gurtOrderMapper.getAllShezhi();
                for (Gurtshezhi gurtshezhi : gurtshezhiList) {

                    long startTime = UtilTime.getLong(sdf.format(gurtshezhi.getStarttime()));
                    long endTime = UtilTime.getLong(sdf.format(gurtshezhi.getEndtime()));

                    if (UtilTime.day(startTime, endTime)) {
                        if (fmt.format(date).equals(fmt.format(order.getBankSubmissionTime()))) {
                            if (UtilTime.day(startTime, endTime, orderTime, newTime)) {
                                count++;
                            }
                        }
                    } else {
                        if (result < (24 * 3600000)) {
                            if (fmt.format(date).equals(fmt.format(order.getBankSubmissionTime()))) {
                                if (UtilTime.day1(startTime, endTime, orderTime, newTime)) {
                                    count++;
                                }
                            } else {
                                if (UtilTime.day2(startTime, endTime, orderTime, newTime)) {
                                    count++;
                                }
                            }
                        }
                    }

                }

            }

        }

        if (count > 0) {
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

    public int importExcel(List<GurtOrder> gurtOrderList) {
        //保函列表
        List<GurtGuarantee> gurtGuaranteeList=gurtGuaranteeMapper.selectGurtGuaranteeList(new GurtGuarantee());
        //银行列表
        List<GurtBank> bankList=gurtOrderMapper.getAllBank();
        //项目分类
        List<GurtProjectType> gurtProjectTypeList=gurtProjectTypeMapper.selectGurtProjectTypeList(new GurtProjectType());
        //用户列表
        List<SysUser> userList=sysUserMapper.selectUserList(new SysUser());
        //订单状态
        List<GurtStatus> statusList=gurtOrderMapper.getStatus();

        for (GurtOrder order : gurtOrderList) {

            for (GurtGuarantee guarantee : gurtGuaranteeList) {
                if(guarantee.getName().equals(order.getBaoName()))
                    order.setGuaranteeId(guarantee.getId());
            }
            for (GurtBank bank : bankList) {
                if(bank.getBankName().equals(order.getBankName()))
                    order.setBankId(Long.valueOf(bank.getId()));
            }
            for (GurtProjectType type : gurtProjectTypeList) {
                if(type.getName().equals(order.getFenName()))
                    order.setProjectTypeId(type.getId());
            }
            for (SysUser user : userList) {
                if(order.getUserName()!=null&&user.getUserName()!=null){
                    if(user.getUserName().equals(order.getUserName()))
                        order.setCreateUserId(user.getUserId());
                }
            }
            for (GurtStatus status : statusList) {
                if(status.getStatusName().equals(order.getStatusName()))
                    order.setStatus(Long.valueOf(status.getId()));
            }
            if(order.getCreateUserId()==null)
                order.setCreateUserId(ShiroUtils.getUserId());
            order.setStatus(Long.valueOf(0));
            gurtOrderMapper.insertGurtOrder(order);
            if(order.getYifu()!=null)
            gurtOrderMapper.insertOrderRecord(order.getId(),order.getYifu().toString());
        }

        return 1;
    }

}
