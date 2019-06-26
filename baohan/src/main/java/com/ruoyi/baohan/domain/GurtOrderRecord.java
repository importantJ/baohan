package com.ruoyi.baohan.domain;

public class GurtOrderRecord {
    private int id;
    private Integer orderId;
    private Integer paidamount;

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Integer getPaidamount() {
        return paidamount;
    }

    public void setPaidamount(Integer paidamount) {
        this.paidamount = paidamount;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
}
