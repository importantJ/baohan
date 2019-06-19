package com.ruoyi.system.domain;

import com.ruoyi.common.core.domain.BaseEntity;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;

import java.util.List;

/**
 * 项目基础资料表 gurt_category
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public class GurtCategorys extends BaseEntity
{
	private static final long serialVersionUID = 1L;

	/**  */
	private Integer id;
	/** 类目名称 */
	private String name;
	/**  */
	private Integer createUserId;
	/** 是否删除(0 否; 1 是) */
	private Integer deleted;


	public void setId(Integer id)
	{
		this.id = id;
	}

	public Integer getId()
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
	public void setCreateUserId(Integer createUserId)
	{
		this.createUserId = createUserId;
	}

	public Integer getCreateUserId()
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
