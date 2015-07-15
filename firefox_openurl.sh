#!/bin/bash


baidu_url="www.baidu.com"
mail_url="mail.126.com"
evernote_url="https://app.yinxiang.com/Home.action"

firefox $baidu_url $mail_url $evernote_url &>/dev/null

exit 0
