package com.ruoyi.baohan.controller;

public class UtilNumber
{
    public final static String[] SEG_STR = new String[]{"", "拾", "佰", "仟", "万", "拾", "佰", "仟", "亿", "拾", "佰", "仟"};

    public static String convert(String num) {
        // 每个数字后插入单位
        StringBuffer ret = new StringBuffer();
        int pos = 0;
        for (int i = num.length() - 1; i >= 0; i--) {
            char curChar = num.charAt(i);
            ret.insert(0, SEG_STR[pos]);
            ret.insert(0, curChar);
            pos++;
        }

        String retStr = ret.toString();
        // 0仟0佰0拾，替换为0
        retStr = retStr.replaceAll("0[仟佰拾]", "0");
        // 0万0亿(0兆0京等等)，替换为万/亿等
        retStr = retStr.replaceAll("0([万亿兆京垓])", "$1");
        // 一个或多个0，替换为一个零
        retStr = retStr.replaceAll("0+", "零");
        // 去掉末尾的零
        retStr = retStr.replaceAll("零$", "");
        // 123456789替换为大写数字
        retStr = retStr.replaceAll("1", "壹")
                .replaceAll("2", "贰")
                .replaceAll("3", "叁")
                .replaceAll("4", "肆")
                .replaceAll("5", "伍")
                .replaceAll("6", "陆")
                .replaceAll("7", "柒")
                .replaceAll("8", "捌")
                .replaceAll("9", "玖");

        // 加上结尾单位
        retStr += "元整";
        System.out.println(retStr);

        return retStr;
    }

}
