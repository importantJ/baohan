package com.ruoyi.web.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.ruoyi.baohan.domain.GurtOrderFile;
import com.ruoyi.baohan.mapper.GurtOrderMapper;
import com.ruoyi.framework.util.ShiroUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.ruoyi.common.config.Global;
import com.ruoyi.common.config.ServerConfig;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.StringUtils;
import com.ruoyi.common.utils.file.FileUploadUtils;
import com.ruoyi.common.utils.file.FileUtils;

/**
 * 通用请求处理
 * 
 * @author ruoyi
 */
@Controller
public class CommonController
{
    private static final Logger log = LoggerFactory.getLogger(CommonController.class);

    /**
     * 文件上传路径
     */
    public static final String UPLOAD_PATH = "/profile/upload/";

    @Autowired
    private ServerConfig serverConfig;

    /**
     * 通用下载请求
     * 
     * @param fileName 文件名称
     * @param delete 是否删除
     */
    @GetMapping("common/download")
    public void fileDownload(String fileName, Boolean delete, HttpServletResponse response, HttpServletRequest request)
    {
        try
        {
            if (!FileUtils.isValidFilename(fileName))
            {
                throw new Exception(StringUtils.format("文件名称({})非法，不允许下载。 ", fileName));
            }
            String realFileName = System.currentTimeMillis() + fileName.substring(fileName.indexOf("_") + 1);
            String filePath = Global.getDownloadPath() + fileName;

            response.setCharacterEncoding("utf-8");
            response.setContentType("multipart/form-data");
            response.setHeader("Content-Disposition",
                    "attachment;fileName=" + FileUtils.setFileDownloadHeader(request, realFileName));
            FileUtils.writeBytes(filePath, response.getOutputStream());
            if (delete)
            {
                FileUtils.deleteFile(filePath);
            }
        }
        catch (Exception e)
        {
            log.error("下载文件失败", e);
        }
    }

    /**
     * 通用上传请求
     */
    @PostMapping("/common/upload")
    @ResponseBody
    public AjaxResult uploadFile(MultipartFile file) throws Exception
    {
        try
        {
            // 上传文件路径
            String filePath = Global.getUploadPath();
            // 上传并返回新文件名称
            String fileName = FileUploadUtils.upload(filePath, file);
            String url = serverConfig.getUrl() + UPLOAD_PATH + fileName;
            AjaxResult ajax = AjaxResult.success();
            ajax.put("fileName", file.getOriginalFilename());
            ajax.put("url", url);
            return ajax;
        }
        catch (Exception e)
        {
            return AjaxResult.error(e.getMessage());
        }
    }
    @Autowired
    private GurtOrderMapper gurtOrderMapper;
    /**
     * 多文件上传
     */
    @PostMapping("/common/uploadFiles")
    @ResponseBody
    public Object uploadFiles(MultipartFile[] file, Long[] ids, ModelMap map) throws Exception
    {
        try
        {

            // 上传文件路径
            String filePath = Global.getUploadPath();
            // 上传并返回新文件名称

            for(int i=0;i<ids.length;i++){
                for(int j=0;j<file.length;j++){
                    String fileName = FileUploadUtils.upload(filePath, file[j]);
                    String url = serverConfig.getUrl() + UPLOAD_PATH + fileName;

                    GurtOrderFile gurtOrderFile = new GurtOrderFile();
                    gurtOrderFile.setCreateUserId(ShiroUtils.getUserId());
                    gurtOrderFile.setOrderId(ids[i]);
                    gurtOrderFile.setName(file[j].getOriginalFilename());
                    gurtOrderFile.setFileDownLoadUrl(url);
                    gurtOrderMapper.insertOrderFile(gurtOrderFile);
                }
            }
            return "上传招标成功";
        }
        catch (Exception e)
        {
            return "上传招标出现错误!";
        }
    }
}
