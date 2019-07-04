package com.ruoyi.baohan.domain;

import com.ruoyi.common.annotation.Excel;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.ruoyi.common.core.domain.BaseEntity;
import java.util.Date;

/**
 * 订单表 gurt_order
 * 
 * @author ruoyi
 * @date 2019-06-14
 */

public class GurtOrder extends BaseEntity
{
	private static final long serialVersionUID = 1L;
	
	/** 主键 */
	private Long id;
	/** 被保证人 */
	@Excel(name = "被保证人", prompt = "被保证人")
	private String warrantee;
	/** 受益人 */
	@Excel(name = "受益人", prompt = "受益人")
	private String beneficiary;
	/** 项目编号 */
	@Excel(name = "项目编号", prompt = "项目编号")
	private String projectNumber;
	/** 项目名称 */
	@Excel(name = "项目名称", prompt = "项目名称")
	private String projectName;
	/** 截标日期 */
	@Excel(name = "截标日期", prompt = "截标日期")
	private Date closingTime;
	/** 担保金额 */
	@Excel(name = "担保金额", prompt = "担保金额")
	private Long guaranteeAmount;
	/** 有效期 */
	@Excel(name = "有效期", prompt = "有效期")
	private String validityDeadline;
	/** 保函格式 */
	@Excel(name = "保函格式", prompt = "保函格式")
	private String baoName;
	private Long guaranteeId;
	/** 贷款银行 */
	private Long bankId;
	/** 项目分类 */
	@Excel(name = "项目分类", prompt = "项目分类")
	private String fenName;
	private Long projectTypeId;
	/** 应付金额 */
	@Excel(name = "应付金额", prompt = "应付金额")
	private Long amount;
	@Excel(name = "已付金额", prompt = "已付金额")
	private Long yifu;

	public Long getYifu() {
		return yifu;
	}

	public void setYifu(Long yifu) {
		this.yifu = yifu;
	}
	private String guaranteefilepath;

	public String getGuaranteefilepath() {
		return guaranteefilepath;
	}

	public void setGuaranteefilepath(String guaranteefilepath) {
		this.guaranteefilepath = guaranteefilepath;
	}

	/**  */
	@Excel(name = "处理人", prompt = "处理人")
	private String userName;

	public String getBaoName() {
		return baoName;
	}

	public void setBaoName(String baoName) {
		this.baoName = baoName;
	}

	public String getFenName() {
		return fenName;
	}

	public void setFenName(String fenName) {
		this.fenName = fenName;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	private Long createUserId;
	/**  */

	private Date bankSubmissionTime;
	/** 订单状态(0 待提交; 1 待接收; 2 待处理; 3 已提交银行; 4 已撤销) */

	private Long status;
	/** 是否需要开发票(0 否, 1 是) */

	private Long needInvoice;
	@Excel(name = "状态", prompt = "状态")
	private String statusName;

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	/**  */
	private String companyName;
	/**  */
	private String taxNumber;

	public String getBankName() {
		return bankName;
	}

	public void setBankName(String bankName) {
		this.bankName = bankName;
	}

	/**  */
	@Excel(name = "贷款银行", prompt = "贷款银行")
	private String bankName;
	/**  */
	private String bankAccount;
	/**  */
	private String companyAddress;
	/** 联系方式 */
	@Excel(name = "联系方式", prompt = "联系方式")
	private Long phoneNumber;
	/** 发票文件下载地址 */

	private String invoiceFileDownloadUrl;

	public void setId(Long id) 
	{
		this.id = id;
	}

	public Long getId() 
	{
		return id;
	}
	public void setWarrantee(String warrantee) 
	{
		this.warrantee = warrantee;
	}

	public String getWarrantee() 
	{
		return warrantee;
	}
	public void setBeneficiary(String beneficiary) 
	{
		this.beneficiary = beneficiary;
	}

	public String getBeneficiary() 
	{
		return beneficiary;
	}
	public void setProjectNumber(String projectNumber) 
	{
		this.projectNumber = projectNumber;
	}

	public String getProjectNumber() 
	{
		return projectNumber;
	}
	public void setProjectName(String projectName) 
	{
		this.projectName = projectName;
	}

	public String getProjectName() 
	{
		return projectName;
	}
	public void setClosingTime(Date closingTime)
	{
		this.closingTime = closingTime;
	}

	public Date getClosingTime()
	{
		return closingTime;
	}
	public void setGuaranteeAmount(Long guaranteeAmount) 
	{
		this.guaranteeAmount = guaranteeAmount;
	}

	public Long getGuaranteeAmount() 
	{
		return guaranteeAmount;
	}
	public void setValidityDeadline(String validityDeadline)
	{
		this.validityDeadline = validityDeadline;
	}

	public String getValidityDeadline()
	{
		return validityDeadline;
	}
	public void setGuaranteeId(Long guaranteeId) 
	{
		this.guaranteeId = guaranteeId;
	}

	public Long getGuaranteeId() 
	{
		return guaranteeId;
	}
	public void setBankId(Long bankId) 
	{
		this.bankId = bankId;
	}

	public Long getBankId() 
	{
		return bankId;
	}
	public void setProjectTypeId(Long projectTypeId) 
	{
		this.projectTypeId = projectTypeId;
	}

	public Long getProjectTypeId() 
	{
		return projectTypeId;
	}
	public void setAmount(Long amount) 
	{
		this.amount = amount;
	}

	public Long getAmount() 
	{
		return amount;
	}
	public void setCreateUserId(Long createUserId) 
	{
		this.createUserId = createUserId;
	}

	public Long getCreateUserId() 
	{
		return createUserId;
	}
	public void setBankSubmissionTime(Date bankSubmissionTime) 
	{
		this.bankSubmissionTime = bankSubmissionTime;
	}

	public Date getBankSubmissionTime() 
	{
		return bankSubmissionTime;
	}
	public void setStatus(Long status) 
	{
		this.status = status;
	}

	public Long getStatus() 
	{
		return status;
	}
	public void setNeedInvoice(Long needInvoice) 
	{
		this.needInvoice = needInvoice;
	}

	public Long getNeedInvoice() 
	{
		return needInvoice;
	}
	public void setCompanyName(String companyName) 
	{
		this.companyName = companyName;
	}

	public String getCompanyName() 
	{
		return companyName;
	}
	public void setTaxNumber(String taxNumber) 
	{
		this.taxNumber = taxNumber;
	}

	public String getTaxNumber() 
	{
		return taxNumber;
	}

	public void setBankAccount(String bankAccount) 
	{
		this.bankAccount = bankAccount;
	}

	public String getBankAccount() 
	{
		return bankAccount;
	}
	public void setCompanyAddress(String companyAddress) 
	{
		this.companyAddress = companyAddress;
	}

	public String getCompanyAddress() 
	{
		return companyAddress;
	}
	public void setPhoneNumber(Long phoneNumber) 
	{
		this.phoneNumber = phoneNumber;
	}

	public Long getPhoneNumber() 
	{
		return phoneNumber;
	}
	public void setInvoiceFileDownloadUrl(String invoiceFileDownloadUrl) 
	{
		this.invoiceFileDownloadUrl = invoiceFileDownloadUrl;
	}

	public String getInvoiceFileDownloadUrl() 
	{
		return invoiceFileDownloadUrl;
	}

    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
            .append("id", getId())
            .append("warrantee", getWarrantee())
            .append("beneficiary", getBeneficiary())
            .append("projectNumber", getProjectNumber())
            .append("projectName", getProjectName())
            .append("closingTime", getClosingTime())
            .append("guaranteeAmount", getGuaranteeAmount())
            .append("validityDeadline", getValidityDeadline())
            .append("guaranteeId", getGuaranteeId())
            .append("bankId", getBankId())
            .append("projectTypeId", getProjectTypeId())
            .append("amount", getAmount())
            .append("createUserId", getCreateUserId())
            .append("createTime", getCreateTime())
            .append("bankSubmissionTime", getBankSubmissionTime())
            .append("status", getStatus())
            .append("needInvoice", getNeedInvoice())
            .append("companyName", getCompanyName())
            .append("taxNumber", getTaxNumber())
            .append("bankName", getBankName())
            .append("bankAccount", getBankAccount())
            .append("companyAddress", getCompanyAddress())
            .append("phoneNumber", getPhoneNumber())
            .append("invoiceFileDownloadUrl", getInvoiceFileDownloadUrl())
            .toString();
    }
}
