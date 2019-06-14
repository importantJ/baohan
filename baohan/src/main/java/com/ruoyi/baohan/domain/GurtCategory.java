package com.ruoyi.baohan.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 项目基础资料表 gurt_category
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public class GurtCategory extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	
	/**  */
	private Long id;
	/** 类目名称 */
	private String name;
	/**  */
	private Long createUserId;
	/** 是否删除(0 否; 1 是) */
	private Integer deleted;

	public void setId(Long id) 
	{
		this.id = id;
	}

	public Long getId() 
	{
		return id;
	}
	public void setName(String name) 
	{
		this.name = name;
	}

	public String getName() 
	{
		return name;
	}
	public void setCreateUserId(Long createUserId) 
	{
		this.createUserId = createUserId;
	}

	public Long getCreateUserId() 
	{
		return createUserId;
	}
	public void setDeleted(Integer deleted) 
	{
		this.deleted = deleted;
	}

	public Integer getDeleted() 
	{
		return deleted;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("remark", getRemark())
            .append("createUserId", getCreateUserId())
            .append("createTime", getCreateTime())
            .append("deleted", getDeleted())
            .toString();
    }
}
