#!/usr/bin/env bash
echo "请输入Xdebug Remote所需的IP:"
read LOCAL_IP

cat > /etc/php5/mods-available/xdebug.ini <<EOF
zend_extension=xdebug.so
xdebug.remote_enable = On
xdebug.remote_host = ${LOCAL_IP}
xdebug.remote_autostart = On
EOF