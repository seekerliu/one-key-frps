# 微信开发本地测试环境一键部署脚本
将本地环境端口映射到远程服务器，用于微信开发调试

## 一、服务端一键部署脚本（install-frps.sh）

这个脚本会自动下载指定版本的FRP，解压，生成一个随机的16位`token`，配置`frps.ini`，并设置FRP服务端作为`systemd`服务运行。

### 使用方法

1. 确保你有sudo权限。
2. 下载脚本：将`install-frps.sh`脚本保存到服务器上。
3. 赋予执行权限：运行`chmod +x install-frps.sh`。
4. 执行脚本：运行`./install-frps.sh`。

## 二、客户端配置脚本（frpc.sh）

这个脚本提供`init`和`start`两个命令，用于初始化FRP客户端配置文件和启动FRP客户端。

### 使用方法

1. 确保FRP客户端程序`frpc`已安装在本地机器上。
2. 下载`frpc.sh`脚本到本地机器。
3. 赋予执行权限：运行`chmod +x frpc.sh`。

#### 初始化配置（init）

初始化FRP客户端配置，设置服务器地址和token。

```bash
./frpc.sh init <TOKEN> <SERVER_IP>
```
<TOKEN>: 与FRP服务端相匹配的token。
<SERVER_IP>: FRP服务端的IP地址。

#### 启动客户端（start）
```bash
./frpc.sh start
```
