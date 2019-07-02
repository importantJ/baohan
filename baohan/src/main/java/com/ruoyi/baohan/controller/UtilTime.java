package com.ruoyi.baohan.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class UtilTime {
   /* public static void main(String[] args)throws Exception {
        Calendar start = Calendar.getInstance();
        Calendar end = Calendar.getInstance();

        SimpleDateFormat df = new SimpleDateFormat("HH:mm");
        start.setTime(df.parse(df.format("12:36")));


        end.setTime(df.parse(df.format("13:36")));

        System.out.println(start);
        System.out.println(end);
        if (start.before(end)) {
            System.out.println(true);
        }else{
            System.out.println(false);
        }
    }*/
    private static final String formatStr = "HH:mm";
    private static SimpleDateFormat sdf=new SimpleDateFormat(formatStr);

    public static void main(String args[]) throws ParseException {
        String tS = "13:00";
        String tE = "9:15";
        Date date=new Date();
        boolean a=day(getLong(sdf.format(date)),getLong(tE));
    }

    private static boolean isInZone(long tStart,long tEnd,long t) throws ParseException {
        System.out.println(tStart <= t && t <= tEnd);
        return tStart <= t && t <= tEnd;
    }

    public static boolean day(long tStart,long tEnd) throws ParseException {
        System.out.println(tStart < tEnd);
        return tStart < tEnd;
    }

    public static boolean day(long tStart,long tEnd,long order,long date) throws ParseException {
        boolean flag=false;
        if(order>tStart&&order<tEnd&&date>tStart&&date<tEnd){
            flag=true;
        }
        return flag;
    }

    public static boolean day1(long tStart,long tEnd,long order,long date) throws ParseException {
        boolean flag=false;
        if(order>tStart&&date>tStart||order<tEnd&&date<tEnd){
            flag=true;
        }
        return flag;
    }

    public static boolean day2(long tStart,long tEnd,long order,long date) throws ParseException {
        boolean flag=false;
        if(order>tStart&&date<tEnd){
            flag=true;
        }
        return flag;
    }

    public static long getLong(String timeStr) throws ParseException {
        return sdf.parse(timeStr).getTime();
    }

    private static long getCurrentTime() throws ParseException {
        return getLong(sdf.format(new Date()));
    }
}
