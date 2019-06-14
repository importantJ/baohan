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
	
	/**  */
	private Long id;
	/**  */
	private Long orderId;
	/**  */
	private Long commissionAmount;
	/** 状态(0 未支付; 1 已支付) */
	private Long status;

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
