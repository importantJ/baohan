package com.ruoyi.baohan.domain;

public class GurtOrderFile {
    private String name;
    private Long createUserId;
    private String createTime;
    private String fileDownLoadUrl;
    private Integer deleted;
    private Long orderId;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Long getCreateUserId() {
        return createUserId;
    }

    public void setCreateUserId(Long createUserId) {
        this.createUserId = createUserId;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getFileDownLoadUrl() {
        return fileDownLoadUrl;
    }

    public void setFileDownLoadUrl(String fileDownLoadUrl) {
        this.fileDownLoadUrl = fileDownLoadUrl;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }
}
