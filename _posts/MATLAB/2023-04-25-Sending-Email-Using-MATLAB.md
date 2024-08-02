---
title: Send Email Using MATLAB
toc: false
categories: 
 - MATLAB
tags:
 - MATLAB Data Import and Analysis
date: 2023-04-25 11:10:11 +0800
last_modified_at: 2024-08-02 16:51:40 +0800
---

Github仓库[^1]给出了一个使用MATLAB发送邮件的脚本，仓库的作者使用的是gmail邮箱发送，我这里将其修改为了使用163邮箱发送的形式：

```matlab
mail = 'XXXX';    % Addresser
psswd = 'XXXX';   % Addresser
host = 'smtp.163.com';
port  = '25'; 
emailto = 'XXXX'; % Recipient
setpref('Internet','E_mail',mail);
setpref('Internet','SMTP_Server',host);
setpref('Internet','SMTP_Username',mail);
setpref('Internet','SMTP_Password',psswd);
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.user',mail);
props.setProperty('mail.smtp.host',host);
props.setProperty('mail.smtp.port',port);
props.setProperty('mail.smtp.starttls.enable','true');
props.setProperty('mail.smtp.debug','true');
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.port',port);
props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.fallback','false');
props.remove('mail.smtp.socketFactory.class');
sendmail(emailto,'Hello from MATLAB','Hello from MATLAB');
```

这一功需要使用邮件运营商（比如这里的163）提供的**SMTP（Simple Mail Transfer Protocol）**服务，而这个服务需要在发件人的邮箱中设置开启，163邮箱开启的方式可参考博客[^2]，若没有开启SMTP服务MATLAB会报错[^3]：


```
Error using sendmail
Could not connect to SMTP host: smtp.163.com, port: 465,
response: -1
```

在开启了SMTP服务后，运营商会提供一个新的密码，需要将这个新的密码传递到`psswd`变量中，这是为了防止用户设置的真实密码以明文的方式暴露，并且只能使用这个密码，用户原本的密码是不行的，会报错：

```
Error using sendmail
Authentication failed.
```

163邮箱所使用的服务器地址（host）和端口号（post）分别是`'smtp.163.com'`和`'25'` （非SSL协议端口号）[^4]，SSL协议端口号`'465'`和`'994'`是不行的：

```
Error using sendmail
Could not connect to SMTP host: smtp.163.com, port: 465,
response: -1
```

```
Error using sendmail
Could not connect to SMTP host: smtp.163.com, port: 994,
response: -1
```

除此之外，MATLAB的`sendmail`命令还支持发给多个收件人，并且还支持发送文件，可以参考官方文档[^5]。

<br>

**Reference**

[^1]: [matlab\_email\_demo/demo\_email.m at master · layumi/matlab\_email\_demo](https://github.com/layumi/matlab_email_demo/blob/master/demo_email.m).
[^2]: [如何使用163的SMTP服务发邮件？- 163 smtp\_liuyuinsdu的博客-CSDN博客](https://blog.csdn.net/liuyuinsdu/article/details/113878840).
[^3]: [MATLAB —— 发送邮件 - yunqianrui的博客-CSDN博客](https://blog.csdn.net/yunqianrui/article/details/106630262).
[^4]: [163邮箱SMTP端口号及服务器地址详细设置 - 新手站长网](https://www.xinshouzhanzhang.com/163smtp.html).
[^5]: [Send Email - MATLAB & Simulink - MathWorks China](https://ww2.mathworks.cn/help/matlab/import_export/sending-email.html).