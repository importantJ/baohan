package com.ruoyi.baohan.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;

import java.util.List;

/**
 * 项目名称表 gurt_project_type
 * 
 * @author ruoyi
 * @date 2019-06-17
 */
public class GurtProjectType extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	
	/**  */
	private Long id;
	/** 类目名称 */
	private String name;

	public void setId(Long id) 
	{
		this.id = id;
	}
	private Integer catId;

	public Integer getCatId() {
		return catId;
	}

	public void setCatId(Integer catId) {
		this.catId = catId;
	}

	public Long getId()
	{
		return id;
	}
	public void setName(String name) 
	{
		this.name = name;
	}
	private List<GurtProjectTypeCostConfig> gurtProjectTypeCostConfigList;

	public List<GurtProjectTypeCostConfig> getGurtProjectTypeCostConfigList() {
		return gurtProjectTypeCostConfigList;
	}

	public void setGurtProjectTypeCostConfigList(List<GurtProjectTypeCostConfig> gurtProjectTypeCostConfigList) {
		this.gurtProjectTypeCostConfigList = gurtProjectTypeCostConfigList;
	}

	public String getName()
	{
		return name;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("name", getName())
            .toString();
    }
}
