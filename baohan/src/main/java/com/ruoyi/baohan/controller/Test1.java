package com.ruoyi.baohan.controller;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

public class Test1 {
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
        String tE = "23:55";

        long a=isis(tS,tE);
        System.out.println(a);
    }

    private static boolean isInZone(long tStart,long tEnd,long t) throws ParseException {
        System.out.println(tStart <= t && t <= tEnd);
        return tStart <= t && t <= tEnd;
    }

    private static boolean isis(long tStart,long tEnd) throws ParseException {
        System.out.println(tStart < tEnd);
        return tStart < tEnd;
    }

    private static long getLong(String timeStr) throws ParseException {
        return sdf.parse(timeStr).getTime();
    }

    private static long getCurrentTime() throws ParseException {
        return getLong(sdf.format(new Date()));
    }
}
