package com.ruoyi.framework.shiro.token;

import org.apache.shiro.authc.HostAuthenticationToken;
import org.apache.shiro.authc.RememberMeAuthenticationToken;

/**
 * ruoyi
 * Description: //TODO
 *
 * @author lucas <link>mailto:lucas.shao@foxmail.com</link>
 * @since 2019-06-28
 */
public class SmsAuthenticationToken implements HostAuthenticationToken,RememberMeAuthenticationToken {

    private String phoneNumber;

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    private boolean rememberMe;

    private String host;


    @Override
    public String getHost() {
        return null;
    }

    @Override
    public boolean isRememberMe() {
        return false;
    }

    @Override
    public Object getPrincipal() {
        return phoneNumber;
    }

    @Override
    public Object getCredentials() {
        return phoneNumber;
    }

    public SmsAuthenticationToken() { this.rememberMe = false; }

    public SmsAuthenticationToken(String phone) { this(phone, false, null); }

    public SmsAuthenticationToken(String phone, boolean rememberMe) { this(phone, rememberMe, null); }

    public SmsAuthenticationToken(String phone, boolean rememberMe, String host) {
        this.phoneNumber = phone;
        this.rememberMe = rememberMe;
        this.host = host;
    }

}