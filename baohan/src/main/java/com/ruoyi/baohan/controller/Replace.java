
package com.ruoyi.baohan.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import com.ruoyi.common.config.ServerConfig;
import org.apache.poi.POIXMLDocument;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;

/**
 *
 * @author zhangdapeng
 * @Date 2014年4月22日
 */

public class Replace {

    public static void searchAndReplace(String srcPath, String destPath,
                                        Map<String, String> map) {
        try {
            InputStream input = new FileInputStream(srcPath);
            XWPFDocument document = new XWPFDocument(input);
            // 替换段落中的指定文字
            Iterator<XWPFParagraph> itPara = document.getParagraphsIterator();
            while (itPara.hasNext()) {
                XWPFParagraph paragraph = (XWPFParagraph) itPara.next();
                //String s = paragraph.getParagraphText();
                Set<String> set = map.keySet();
                Iterator<String> iterator = set.iterator();
                while (iterator.hasNext()) {
                    String key = iterator.next();
                    List<XWPFRun> run=paragraph.getRuns();
                    for(int i=0;i<run.size();i++)
                    {
                        if(run.get(i).getText(run.get(i).getTextPosition())!=null && run.get(i).getText(run.get(i).getTextPosition()).equals(key))
                        {
                            run.get(i).setText(map.get(key),0);
                        }
                    }
                }
            }
            // 替换表格中的指定文字
            Iterator<XWPFTable> itTable = document.getTablesIterator();
            while (itTable.hasNext()) {
                XWPFTable table = (XWPFTable) itTable.next();
                int rcount = table.getNumberOfRows();
                for (int i = 0; i < rcount; i++) {
                    XWPFTableRow row = table.getRow(i);
                    List<XWPFTableCell> cells = row.getTableCells();
                    for (XWPFTableCell cell : cells) {
                        for (Entry<String, String> e : map.entrySet()) {
                            if (cell.getText().equals(e.getKey())) {
                                cell.removeParagraph(0);
                                cell.setText(e.getValue());
                            }
                        }
                    }
                }
            }
            FileOutputStream outStream = null;
            outStream = new FileOutputStream(destPath);
            document.write(outStream);
            outStream.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void main(String[] args) throws Exception {
        Map<String, String> map = new HashMap<String, String>();
        map.put("${name}", "艾程");
        String srcPath = "E:\\dl/58e2bb25f87186d749d42cdbaf73ba6e.docx";
        String destPath = "E:\\dl/58e2bb25f87186d749d42cdbaf73ba6e123123.docx";
        searchAndReplace(srcPath, destPath, map);
    }
}