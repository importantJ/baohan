package com.ruoyi.baohan.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 邀请提成表 gurt_invite_commission
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public class GurtInviteCommission extends BaseEntity
{
	private static final long serialVersionUID = 1L;

	private String inviteuserid;
	private String name;

	public String getInviteuserid() {
		return inviteuserid;
	}

	public void setInviteuserid(String inviteuserid) {
		this.inviteuserid = inviteuserid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	private GurtOrder gurtOrder;

	public GurtOrder getGurtOrder() {
		return gurtOrder;
	}

	public void setGurtOrder(GurtOrder gurtOrder) {
		this.gurtOrder = gurtOrder;
	}

	/**  */
	private Long id;
	/**  */
	private Long orderId;
	/**  */
	private Long commissionAmount;
	/** 状态(0 未支付; 1 已支付) */
	private Long status;

	private String statusName;

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public void setId(Long id)
	{
		this.id = id;
	}

	public Long getId() 
	{
		return id;
	}
	public void setOrderId(Long orderId) 
	{
		this.orderId = orderId;
	}

	public Long getOrderId() 
	{
		return orderId;
	}
	public void setCommissionAmount(Long commissionAmount) 
	{
		this.commissionAmount = commissionAmount;
	}

	public Long getCommissionAmount() 
	{
		return commissionAmount;
	}
	public void setStatus(Long status) 
	{
		this.status = status;
	}

	public Long getStatus() 
	{
		return status;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("orderId", getOrderId())
            .append("commissionAmount", getCommissionAmount())
            .append("status", getStatus())
            .toString();
    }
}
