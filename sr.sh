#!/usr/bin/env bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin

export PATH

#=================================================

#    System Required: CentOS 6+/Debian 6+/Ubuntu 14.04+

#    Description: Install the ShadowsocksR server

#    Version: 2.0.38

#    Author: Toyo

#    Blog: https://doub.io/ss-jc42/

#=================================================

sh_ver="2.0.38"

filepath=$(cd "$(dirname "$0")"; pwd)

file=$(echo -e "${filepath}"|awk -F "$0" '{print $1}')

ssr_folder="/usr/local/shadowsocksr"

ssr_ss_file="${ssr_folder}/shadowsocks"

config_file="${ssr_folder}/config.json"

config_folder="/etc/shadowsocksr"

config_user_file="${config_folder}/user-config.json"

ssr_log_file="${ssr_ss_file}/ssserver.log"

Libsodiumr_file="/usr/local/lib/libsodium.so"

Libsodiumr_ver_backup="1.0.13"

Server_Speeder_file="/serverspeeder/bin/serverSpeeder.sh"

LotServer_file="/appex/bin/serverSpeeder.sh"

BBR_file="${file}/bbr.sh"

jq_file="${ssr_folder}/jq"

Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"

Info="${Green_font_prefix}[信息]${Font_color_suffix}"

Error="${Red_font_prefix}[错误]${Font_color_suffix}"

Tip="${Green_font_prefix}[注意]${Font_color_suffix}"

Separator_1="——————————————————————————————"

check_root(){

    [[ $EUID != 0 ]] && echo -e "${Error} 当前账号非ROOT(或没有ROOT权限)，无法继续操作，请使用${Green_background_prefix} sudo su ${Font_color_suffix}来获取临时ROOT权限（执行后会提示输入当前账号的密码）。" && exit 1

}

check_sys(){

    if [[ -f /etc/redhat-release ]]; then

        release="centos"

    elif cat /etc/issue | grep -q -E -i "debian"; then

        release="debian"

    elif cat /etc/issue | grep -q -E -i "ubuntu"; then

        release="ubuntu"

    elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then

        release="centos"

    elif cat /proc/version | grep -q -E -i "debian"; then

        release="debian"

    elif cat /proc/version | grep -q -E -i "ubuntu"; then

        release="ubuntu"

    elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then

        release="centos"

    fi

    bit=`uname -m`

}

check_pid(){

    PID=`ps -ef |grep -v grep | grep server.py |awk '{print $2}'`

}

SSR_installation_status(){

    [[ ! -e ${config_user_file} ]] && echo -e "${Error} 没有发现 ShadowsocksR 配置文件，请检查 !" && exit 1

    [[ ! -e ${ssr_folder} ]] && echo -e "${Error} 没有发现 ShadowsocksR 文件夹，请检查 !" && exit 1

}

Server_Speeder_installation_status(){

    [[ ! -e ${Server_Speeder_file} ]] && echo -e "${Error} 没有安装 锐速(Server Speeder)，请检查 !" && exit 1

}

LotServer_installation_status(){

    [[ ! -e ${LotServer_file} ]] && echo -e "${Error} 没有安装 LotServer，请检查 !" && exit 1

}

BBR_installation_status(){

    if [[ ! -e ${BBR_file} ]]; then

        echo -e "${Error} 没有发现 BBR脚本，开始下载..."

        cd "${file}"

        if ! wget -N --no-check-certificate https://raw.githubusercontent.com/ToyoDAdoubi/doubi/master/bbr.sh; then

            echo -e "${Error} BBR 脚本下载失败 !" && exit 1

        else

            echo -e "${Info} BBR 脚本下载完成 !"

            chmod +x bbr.sh

        fi

    fi

}

# 设置 防火墙规则

Add_iptables(){

    iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ssr_port} -j ACCEPT

    iptables -I INPUT -m state --state NEW -m udp -p udp --dport ${ssr_port} -j ACCEPT

    ip6tables -I INPUT -m state --state NEW -m tcp -p tcp --dport ${ssr_port} -j ACCEPT

    ip6tables -I INPUT -m state --state NEW -m udp -p udp --dport ${ssr_port} -j ACCEPT

}

Del_iptables(){

    iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT

    iptables -D INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT

    ip6tables -D INPUT -m state --state NEW -m tcp -p tcp --dport ${port} -j ACCEPT

    ip6tables -D INPUT -m state --state NEW -m udp -p udp --dport ${port} -j ACCEPT

}

Save_iptables(){

    if [[ ${release} == "centos" ]]; then

        service iptables save

        service ip6tables save

    else

        iptables-save > /etc/iptables.up.rules

        ip6tables-save > /etc/ip6tables.up.rules

    fi

}

Set_iptables(){

    if [[ ${release} == "centos" ]]; then

        service iptables save

        service ip6tables save

        chkconfig --level 2345 iptables on

        chkconfig --level 2345 ip6tables on

    else

        iptables-save > /etc/iptables.up.rules

        ip6tables-save > /etc/ip6tables.up.rules

        echo -e '#!/bin/bash\n/sbin/iptables-restore < /etc/iptables.up.rules\n/sbin/ip6tables-restore < /etc/ip6tables.up.rules' > /etc/network/if-pre-up.d/iptables

        chmod +x /etc/network/if-pre-up.d/iptables

    fi

}

# 读取 配置信息

Get_IP(){

    ip=$(wget -qO- -t1 -T2 ipinfo.io/ip)

    if [[ -z "${ip}" ]]; then

        ip=$(wget -qO- -t1 -T2 api.ip.sb/ip)

        if [[ -z "${ip}" ]]; then

            ip=$(wget -qO- -t1 -T2 members.3322.org/dyndns/getip)

            if [[ -z "${ip}" ]]; then

                ip="VPS_IP"

            fi

        fi

    fi

}

Get_User(){

    [[ ! -e ${jq_file} ]] && echo -e "${Error} JQ解析器 不存在，请检查 !" && exit 1

    port=`${jq_file} '.server_port' ${config_user_file}`

    password=`${jq_file} '.password' ${config_user_file} | sed 's/^.//;s/.$//'`

    method=`${jq_file} '.method' ${config_user_file} | sed 's/^.//;s/.$//'`

    protocol=`${jq_file} '.protocol' ${config_user_file} | sed 's/^.//;s/.$//'`

    obfs=`${jq_file} '.obfs' ${config_user_file} | sed 's/^.//;s/.$//'`

    protocol_param=`${jq_file} '.protocol_param' ${config_user_file} | sed 's/^.//;s/.$//'`

    speed_limit_per_con=`${jq_file} '.speed_limit_per_con' ${config_user_file}`

    speed_limit_per_user=`${jq_file} '.speed_limit_per_user' ${config_user_file}`

    connect_verbose_info=`${jq_file} '.connect_verbose_info' ${config_user_file}`

}

urlsafe_base64(){

    date=$(echo -n "$1"|base64|sed ':a;N;s/\n/ /g;ta'|sed 's/ //g;s/=//g;s/+/-/g;s/\//_/g')

    echo -e "${date}"

}

ss_link_qr(){

    SSbase64=$(urlsafe_base64 "${method}:${password}@${ip}:${port}")

    SSurl="ss://${SSbase64}"

    SSQRcode="http://doub.pw/qr/qr.php?text=${SSurl}"

    ss_link=" SS    链接 : ${Green_font_prefix}${SSurl}${Font_color_suffix} \n SS  二维码 : ${Green_font_prefix}${SSQRcode}${Font_color_suffix}"

}

ssr_link_qr(){

    SSRprotocol=$(echo ${protocol} | sed 's/_compatible//g')

    SSRobfs=$(echo ${obfs} | sed 's/_compatible//g')

    SSRPWDbase64=$(urlsafe_base64 "${password}")

    SSRbase64=$(urlsafe_base64 "${ip}:${port}:${SSRprotocol}:${method}:${SSRobfs}:${SSRPWDbase64}")

    SSRurl="ssr://${SSRbase64}"

    SSRQRcode="http://doub.pw/qr/qr.php?text=${SSRurl}"

    ssr_link=" SSR   链接 : ${Red_font_prefix}${SSRurl}${Font_color_suffix} \n SSR 二维码 : ${Red_font_prefix}${SSRQRcode}${Font_color_suffix} \n "

}

ss_ssr_determine(){

    protocol_suffix=`echo ${protocol} | awk -F "_" '{print $NF}'`

    obfs_suffix=`echo ${obfs} | awk -F "_" '{print $NF}'`

    if [[ ${protocol} = "origin" ]]; then

        if [[ ${obfs} = "plain" ]]; then

            ss_link_qr

            ssr_link=""

        else

            if [[ ${obfs_suffix} != "compatible" ]]; then

                ss_link=""

            else

                ss_link_qr

            fi

        fi

    else

        if [[ ${protocol_suffix} != "compatible" ]]; then

            ss_link=""

        else

            if [[ ${obfs_suffix} != "compatible" ]]; then

                if [[ ${obfs_suffix} = "plain" ]]; then

                    ss_link_qr

                else

                    ss_link=""

                fi

            else

                ss_link_qr

            fi

        fi

    fi

    ssr_link_qr

}

# 显示 配置信息

View_User(){

    SSR_installation_status

    Get_IP

    Get_User

    now_mode=$(cat "${config_user_file}"|grep '"port_password"')

    [[ -z ${protocol_param} ]] && protocol_param="0(无限)"

    if [[ -z "${now_mode}" ]]; then

        ss_ssr_determine

        clear && echo "===================================================" && echo

        echo -e " ShadowsocksR账号 配置信息：" && echo

        echo -e " I  P\t    : ${Green_font_prefix}${ip}${Font_color_suffix}"

        echo -e " 端口\t    : ${Green_font_prefix}${port}${Font_color_suffix}"

        echo -e " 密码\t    : ${Green_font_prefix}${password}${Font_color_suffix}"

        echo -e " 加密\t    : ${Green_font_prefix}${method}${Font_color_suffix}"

        echo -e " 协议\t    : ${Red_font_prefix}${protocol}${Font_color_suffix}"

        echo -e " 混淆\t    : ${Red_font_prefix}${obfs}${Font_color_suffix}"

        echo -e " 设备数限制 : ${Green_font_prefix}${protocol_param}${Font_color_suffix}"

        echo -e " 单线程限速 : ${Green_font_prefix}${speed_limit_per_con} KB/S${Font_color_suffix}"

        echo -e " 端口总限速 : ${Green_font_prefix}${speed_limit_per_user} KB/S${Font_color_suffix}"

        echo -e "${ss_link}"

        echo -e "${ssr_link}"

        echo -e " ${Green_font_prefix} 提示: ${Font_color_suffix}

 在浏览器中，打开二维码链接，就可以看到二维码图片。

 协议和混淆后面的[ _compatible ]，指的是 兼容原版协议/混淆。"

        echo && echo "==================================================="

    else

        user_total=`${jq_file} '.port_password' ${config_user_file} | sed '$d' | sed "1d" | wc -l`

        [[ ${user_total} = "0" ]] && echo -e "${Error} 没有发现 多端口用户，请检查 !" && exit 1

        clear && echo "===================================================" && echo

        echo -e " ShadowsocksR账号 配置信息：" && echo

        echo -e " I  P\t    : ${Green_font_prefix}${ip}${Font_color_suffix}"

        echo -e " 加密\t    : ${Green_font_prefix}${method}${Font_color_suffix}"

        echo -e " 协议\t    : ${Red_font_prefix}${protocol}${Font_color_suffix}"

        echo -e " 混淆\t    : ${Red_font_prefix}${obfs}${Font_color_suffix}"

        echo -e " 设备数限制 : ${Green_font_prefix}${protocol_param}${Font_color_suffix}"

        echo -e " 单线程限速 : ${Green_font_prefix}${speed_limit_per_con} KB/S${Font_color_suffix}"

        echo -e " 端口总限速 : ${Green_font_prefix}${speed_limit_per_user} KB/S${Font_color_suffix}" && echo

        for((integer = ${user_total}; integer >= 1; integer--))

        do

            port=`${jq_file} '.port_password' ${config_user_file} | sed '$d' | sed "1d" | awk -F ":" '{print $1}' | sed -n "${integer}p" | sed -r 's/.*\"(.+)\".*/\1/'`

            password=`${jq_file} '.port_password' ${config_user_file} | sed '$d' | sed "1d" | awk -F ":" '{print $2}' | sed -n "${integer}p" | sed -r 's/.*\"(.+)\".*/\1/'`

            ss_ssr_determine

            echo -e ${Separator_1}

            echo -e " 端口\t    : ${Green_font_prefix}${port}${Font_color_suffix}"

            echo -e " 密码\t    : ${Green_font_prefix}${password}${Font_color_suffix}"

            echo -e "${ss_link}"

            echo -e "${ssr_link}"

        done

        echo -e " ${Green_font_prefix} 提示: ${Font_color_suffix}

 在浏览器中，打开二维码链接，就可以看到二维码图片。

 协议和混淆后面的[ _compatible ]，指的是 兼容原版协议/混淆。"

        echo && echo "==================================================="

    fi

}

# 设置 配置信息

Set_config_port(){

    while true

    do

    echo -e "请输入要设置的ShadowsocksR账号 端口"

    read -e -p "(默认: 2333):" ssr_port

    [[ -z "$ssr_port" ]] && ssr_port="233
