打造 vagrant php7 开发环境
================

## 包括以下环境和软件：

- Nginx 1.4.6
- Mysql 5.5.46（mysql -V）
- PHP 7.0.8-3
- git
- [autojump](https://github.com/joelthelion/autojump)
- [composer](https://getcomposer.org)
- vim

## Box地址

链接: http://pan.baidu.com/s/1nt1hDMD 密码: ckg4


## 如何搭建

下载 ubuntu_trusty_64.box, 执行以下命令添加刚才下载好的 box 到 Box list：

```sh
// cd 下载 box 目录
// vagrant box add 名称 路径
vagrant box add trusty64 ubuntu_trusty_64.box

vagrant box list // 查看
mkdir ubuntu // 创建文件夹
git clone https://github.com/forecho/vagrant-ubuntu-php7.git php7
cd php7
vagrant init // 初始化

```
然后启动 vagrant

```
vagrant up
```

最后你可以愉快的时候 Xshell 工具 SSH 连接了。

```
IP：192.168.33.10
端口：22
用户名：vagrant
密码：vagrant
```

连接之后切换 root 用户：

```
sudo su // 不需要输入密码
```

## 关于 nginx 的使用

默认这个 box 我已经配置好 LNMP 环境了。PHP 的项目直接放在当前文件夹的 `php` 文件夹内就可以了。（默认配置的是 php 文件夹，如果要换其他文件夹，请自行修改 nginx 的 dev.conf 文件的配置）

示例：

```
根目录
	|--php
		|--cai
			|--zheng
				|--hai
		|--getyii
			|--frontend
				|--web
```

默认我使用的是 `*.dev.com` 作为域名。

只要在**本机（一般是 Windows 系统）**的 hosts 文件，添加一下代码：

```
……
192.168.33.10	cai.dev.com
192.168.33.10	cai-zheng-hai.dev.com
192.168.33.10	getyii-frontend-web.dev.com
……
```

**注意**
- 因为是虚拟机，所以添加 hosts 这一步是必须的。
- 域名只做了三层解析，太多层觉得没必要。也就是说URL `cai-zheng-hai-open.dev.com` 默认是不行的。
- **Windows 可以使用 Acrylic 软件让 host 支持通配符解析，参考文章：[支持通配符和正则表达式的hosts文件(本地dns缓存及代理)](http://grow.sinaapp.com/?p=1368)**
- **Mac 可以使用 Dnsmasq 软件让 host 支持通配符解析，参考文章：[Mac OSX 安装 Dnsmasq 来加速网络](http://www.shixf.com/wiki/os/macosx/dnsmasq)**



## 关于MySQL

默认用户名：root

默认密码：root


## 关于一些常用的命令

**PHP-FPM**

- 重启
```
sudo service php7.0-fpm restart
```
- PHP 配置文件位置：`/etc/php/7.0/fpm/php.ini`
- 查看 phpinfo() -> http://test.dev.com/

**Nginx**

- 重启
```sh
sudo service nginx restart
```

- 修改虚拟空间配置文件：
```
sudo vim /etc/nginx/conf.d/default.conf
```

**MySQL**

- 重启
```sh
sudo service mysql restart
```

## 参考文档

- [路径（七）：用 Vagrant 管理虚拟机](http://ninghao.net/blog/2077)
- [1.2 Vagrant安装配置](https://github.com/astaxie/Go-in-Action/blob/master/ebook/zh/01.2.md)
- [forecho/vagrant-ubuntu-trusty-64](https://github.com/forecho/vagrant-ubuntu-trusty-64)
- [How To Upgrade to PHP 7 on Ubuntu 14.04](https://www.digitalocean.com/community/tutorials/how-to-upgrade-to-php-7-on-ubuntu-14-04)