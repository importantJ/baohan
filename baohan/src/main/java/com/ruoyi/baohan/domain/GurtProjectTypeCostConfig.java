package com.ruoyi.baohan.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目分类表 gurt_project_type_cost_config
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
public class GurtProjectTypeCostConfig extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	
	/**  */
	private Long id;
	/**  */
	private Long projectTypeId;
	/**  */
	private Long startingAmount;
	/**  */
	private Long endingAmount;
	/**  */
	private Long singlePaymentCost;
	/** 成本计算方式(0 元, 1 %) */
	private Integer singlePaymentCountType;
	/**  */
	private Long multiplePaymentCost;
	/** 成本计算方式(0 元, 1 %) */
	private Integer multiplePaymentCountType;
	/**  */
	private Integer categoryId;

	public void setId(Long id) 
	{
		this.id = id;
	}

	public Long getId() 
	{
		return id;
	}
	public void setProjectTypeId(Long projectTypeId) 
	{
		this.projectTypeId = projectTypeId;
	}

	public Long getProjectTypeId() 
	{
		return projectTypeId;
	}
	public void setStartingAmount(Long startingAmount) 
	{
		this.startingAmount = startingAmount;
	}

	public Long getStartingAmount() 
	{
		return startingAmount;
	}
	public void setEndingAmount(Long endingAmount) 
	{
		this.endingAmount = endingAmount;
	}

	public Long getEndingAmount() 
	{
		return endingAmount;
	}
	public void setSinglePaymentCost(Long singlePaymentCost) 
	{
		this.singlePaymentCost = singlePaymentCost;
	}

	public Long getSinglePaymentCost() 
	{
		return singlePaymentCost;
	}
	public void setSinglePaymentCountType(Integer singlePaymentCountType) 
	{
		this.singlePaymentCountType = singlePaymentCountType;
	}

	public Integer getSinglePaymentCountType() 
	{
		return singlePaymentCountType;
	}
	public void setMultiplePaymentCost(Long multiplePaymentCost) 
	{
		this.multiplePaymentCost = multiplePaymentCost;
	}

	public Long getMultiplePaymentCost() 
	{
		return multiplePaymentCost;
	}
	public void setMultiplePaymentCountType(Integer multiplePaymentCountType) 
	{
		this.multiplePaymentCountType = multiplePaymentCountType;
	}

	public Integer getMultiplePaymentCountType() 
	{
		return multiplePaymentCountType;
	}
	public void setCategoryId(Integer categoryId)
	{
		this.categoryId = categoryId;
	}

	public Integer getCategoryId()
	{
		return categoryId;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("projectTypeId", getProjectTypeId())
            .append("startingAmount", getStartingAmount())
            .append("endingAmount", getEndingAmount())
            .append("singlePaymentCost", getSinglePaymentCost())
            .append("singlePaymentCountType", getSinglePaymentCountType())
            .append("multiplePaymentCost", getMultiplePaymentCost())
            .append("multiplePaymentCountType", getMultiplePaymentCountType())
            .append("categoryId", getCategoryId())
            .toString();
    }
}
