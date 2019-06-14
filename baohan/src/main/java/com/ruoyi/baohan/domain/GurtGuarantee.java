package com.ruoyi.baohan.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

/**
 * 保函表 gurt_guarantee
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public class GurtGuarantee extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	
	/**  */
	private Long id;
	/** 名称 */
	private String name;
	/** 保函文件路径 */
	private String guaranteeFilePath;

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
	public void setGuaranteeFilePath(String guaranteeFilePath) 
	{
		this.guaranteeFilePath = guaranteeFilePath;
	}

	public String getGuaranteeFilePath() 
	{
		return guaranteeFilePath;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .append("remark", getRemark())
            .append("guaranteeFilePath", getGuaranteeFilePath())
            .toString();
    }
}
