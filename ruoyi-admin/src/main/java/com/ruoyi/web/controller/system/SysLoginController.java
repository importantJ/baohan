package com.ruoyi.web.controller.system;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.ruoyi.framework.shiro.token.SmsAuthenticationToken;
import com.ruoyi.framework.util.ShiroUtils;
import com.ruoyi.system.domain.SysUser;
import com.ruoyi.system.service.ISysUserService;
import com.ruoyi.web.controller.SendSmsUtil.IndustrySMS;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.ruoyi.common.core.controller.BaseController;
import com.ruoyi.common.core.domain.AjaxResult;
import com.ruoyi.common.utils.ServletUtils;
import com.ruoyi.common.utils.StringUtils;

import java.util.List;

/**
 * 登录验证
 * 
 * @author ruoyi
 */
@Controller
public class SysLoginController extends BaseController
{
    @GetMapping("/login")
    public String login(HttpServletRequest request, HttpServletResponse response)
    {
        // 如果是Ajax请求，返回Json字符串。
        if (ServletUtils.isAjaxRequest(request))
        {
            return ServletUtils.renderString(response, "{\"code\":\"1\",\"msg\":\"未登录或登录超时。请重新登录\"}");
        }

        return "login";
    }

    @PostMapping("/login")
    @ResponseBody
    public AjaxResult ajaxLogin(String username, String password, Boolean rememberMe)
    {
        UsernamePasswordToken token = new UsernamePasswordToken(username, password, rememberMe);
        Subject subject = SecurityUtils.getSubject();
        try
        {
            subject.login(token);
            return success();
        }
        catch (AuthenticationException e)
        {
            String msg = "用户或密码错误";
            /*if (StringUtils.isNotEmpty(e.getMessage()))
            {
                msg = e.getMessage();
            }*/
            return error(msg);
        }
    }

    @GetMapping("/sendCode")
    @ResponseBody
    public String sendCode(String phone,HttpServletResponse response){
        String code=IndustrySMS.smsCode();
        String result=IndustrySMS.execute(phone,code,"【保函科技】注册验证码："+code+"，如非本人操作，请忽略此短信。");
        Cookie cookie=new Cookie("randon",code);
        cookie.setMaxAge(7*24*60*60);
        response.addCookie(cookie);

        Cookie cookie1=new Cookie("phone",phone);
        cookie1.setMaxAge(7*24*60*60);
        response.addCookie(cookie1);
        if(result.contains("00141")){
            result="同一手机号码1小时内发送次数为四";
        }else if(result.contains("00025")){
                result="手机号格式不正确";
        } else if(result.contains("00000")){
                result="发送成功";
        }else if(result.contains("00142")){
            result="同一手机号码1天内发送次数应小于等于10";
        }else if(result.contains("00126")){
            result="手机号为空";
        }
        return result;
    }
    @Autowired
    ISysUserService userService;
    @PostMapping("/loginByPhone")
    @ResponseBody
    public AjaxResult loginByPhone(String phone,String code,String msg,String url) {
        Cookie[] cookies = getRequest().getCookies();
        String randon = null;
        String phone1 = null;
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals("randon")) {
                randon = cookie.getValue();
            } else if (cookie.getName().equals("phone")) {
                phone1 = cookie.getValue();
            }
        }
            SmsAuthenticationToken token = new SmsAuthenticationToken(phone);
            Subject subject = SecurityUtils.getSubject();
            try {

                if (randon == null || phone1 == null) {
                    msg = "请发送验证码到正确手机号!";
                    throw new AuthenticationException();
                }
                if (!randon.equals(code) || !phone1.equals(phone)) {
                    msg = "验证码输入错误";
                    throw new AuthenticationException();
                }
               SysUser user1= userService.selectUserByPhoneNumber(phone);
        if(user1==null) {
            SysUser user = new SysUser();
            user.setPhonenumber(phone);
            if(url!=""&&url!=null){
                List<SysUser> userList = userService.selectUserList(new SysUser());
                for (SysUser sysUser : userList) {
                    String initveurl = sysUser.getInviteurl();
                    url=url.substring(url.lastIndexOf("/")+1);
                    if (initveurl != null) {
                        if (initveurl.contains(url))
                            user.setInviteUserId(sysUser.getUserId().intValue());
                    }
                }
            }
            userService.insertUser1(user);
            userService.insertUserRole(user.getUserId().intValue());
        }
                subject.login(token);

                return success();
            } catch (AuthenticationException e) {
                return error(msg);
            }

    }

    @GetMapping("/unauth")
    public String unauth()
    {
        return "error/unauth";
    }
}
