package com.ruoyi.baohan.controller;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test1 {
    public static void main(String[] args)throws Exception {


        Calendar cal=Calendar.getInstance();//使用日历类
        cal.setTime(new Date());

        System.out.println(cal.get(cal.HOUR_OF_DAY));
        System.out.println(cal.get(cal.MINUTE));
        System.out.println(cal.get(cal.SECOND));
    }
}
