package com.ruoyi.baohan.domain;

public class Gurtshezhi {
    private String cb;
    private String starttime;
    private String endtime;

    public String getCb() {
        return cb;
    }

    public void setCb(String cb) {
        this.cb = cb;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = "0000-0-0 "+starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = "0000-0-0 "+endtime;
    }
}
