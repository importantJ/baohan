package com.ruoyi.baohan.mapper;

import com.ruoyi.baohan.domain.GurtGuarantee;
import java.util.List;	

/**
 * 保函 数据层
 * 
 * @author ruoyi
 * @date 2019-06-14
 */
public interface GurtGuaranteeMapper 
{
	/**
     * 查询保函信息
     * 
     * @param id 保函ID
     * @return 保函信息
     */
	public GurtGuarantee selectGurtGuaranteeById(Long id);
	
	/**
     * 查询保函列表
     * 
     * @param gurtGuarantee 保函信息
     * @return 保函集合
     */
	public List<GurtGuarantee> selectGurtGuaranteeList(GurtGuarantee gurtGuarantee);
	
	/**
     * 新增保函
     * 
     * @param gurtGuarantee 保函信息
     * @return 结果
     */
	public int insertGurtGuarantee(GurtGuarantee gurtGuarantee);
	
	/**
     * 修改保函
     * 
     * @param gurtGuarantee 保函信息
     * @return 结果
     */
	public int updateGurtGuarantee(GurtGuarantee gurtGuarantee);
	
	/**
     * 删除保函
     * 
     * @param id 保函ID
     * @return 结果
     */
	public int deleteGurtGuaranteeById(Long id);
	
	/**
     * 批量删除保函
     * 
     * @param ids 需要删除的数据ID
     * @return 结果
     */
	public int deleteGurtGuaranteeByIds(String[] ids);
	
}