# 我的 Mac 机 Ulord 挖矿实践

1、首先得装个 Ulord 钱包

首先登陆[官网](http://ulord.one/)，在主页右上角点击“客户端”，点击进入下载页面。

下载 Ulord 挖矿软件和 Ulor 钱包，我试过 Ulord windows 版的桌面版钱包，不过安装后卡在同步上了。后来我是下载了安卓的手机版钱包。
安装后记下助记词。进入后点 UT , 收款，就会显示钱包地址。记下这个地址，等下有用。

2、下载 Ulord 挖矿软件

因为没有 windows 和 linux 的电脑，手头只有一台 mac 台机，官网也没有 Mac 版的挖矿软件。

我就下载了 linux 版的挖矿软件，打算使用 docker 大法试试。

3、修改配置文件 config.json

```javaScript
{
    "threads":3,    // 设置挖矿线程数
    "pools": [
      {
	       "url":"stratum+tcp://ut.jeepool.com:7100",
	       "user":"UZGpMHVa6c25PNAhDHA1kR4oYVfLdTGPVy.dw", // 格式为收款地址.矿工名
	       "pass":"x"


         },

        {
            "url": "stratum+tcp://main-pool.ulorders.com:18888",   // URL of mining server
            "user": "Ugf1kQj8gpTGazYae1zW4ktPzTqKXdJ7jk.test01",   // username for mining server
            "pass": "x"                                            // password for mining server

        }
    ]
}

```
在上面加入了 ut.jeepool.com:7100 矿池，并且加上了收款地址。矿工名可以随意取。

4、创建 Docker image 文件

将下载的挖矿软件解压。在解压目录下建一个 Dockerfile。

```bash
touch Dockerfile
```

然后加入以下内容：

```
FROM centos

RUN mkdir -p /ulord
COPY ./config.json /ulord
COPY ./ulordrig /ulord

WORKDIR /ulord

CMD ["/ulord/ulordrig"]

```
生成镜像文件:
```bash
docker build -t ulord .
```

5、运行探矿软件
```bash
docker run -d ulord
```
查看运行状态
```bash
docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
a2f7769886c2        ulord               "/ulord/ulordrig"   21 minutes ago      Up 22 minutes                           friendly_stallman
```

```bash
docker logs friendly_stallman
* VERSIONS:     ulordrig/1.0.0 libuv/1.8.0 gcc/5.4.0
* HUGE PAGES:   available, disabled
* CPU:          Intel(R) Core(TM) i5-4570 CPU @ 3.20GHz (2) x64 AES-NI
* CPU L2/L3:    1.0 MB/12.0 MB
* THREADS:      3, cryptohello
* POOL #1:      ut.jeepool.com:7100
* POOL #2:      main-pool.ulorders.com:18888
* COMMANDS:     hashrate, pause, resume
[2018-05-24 00:32:59] use pool ut.jeepool.com:7100 47.75.162.19
[2018-05-24 00:32:59] new job from ut.jeepool.com:7100 diff 3276
[2018-05-24 00:33:06] accepted (1/0) diff 3276 (222 ms)
[2018-05-24 00:33:17] accepted (2/0) diff 3276 (54 ms)
[2018-05-24 00:33:17] accepted (3/0) diff 3276 (253 ms)
[2018-05-24 00:33:25] accepted (4/0) diff 3276 (121 ms)
[2018-05-24 00:33:36] accepted (5/0) diff 3276 (99 ms)
[2018-05-24 00:33:41] new job from ut.jeepool.com:7100 diff 3276
[2018-05-24 00:33:51] accepted (6/0) diff 3276 (79 ms)
[2018-05-24 00:33:52] accepted (7/0) diff 3276 (83 ms)
[2018-05-24 00:33:53] accepted (8/0) diff 3276 (115 ms)
[2018-05-24 00:33:58] accepted (9/0) diff 3276 (101 ms)
[2018-05-24 00:34:03] speed 2.5s/60s/15m 310.9 301.8 n/a H/s max: 314.6 H/s
[2018-05-24 00:34:05] accepted (10/0) diff 3276 (642 ms)
[2018-05-24 00:34:06] accepted (11/0) diff 3276 (431 ms)
[2018-05-24 00:34:12] accepted (12/0) diff 3276 (130 ms)
[2018-05-24 00:34:19] accepted (13/0) diff 3276 (60 ms)
[2018-05-24 00:34:23] accepted (14/0) diff 3276 (182 ms)
[2018-05-24 00:34:37] new job from ut.jeepool.com:7100 diff 3276
[2018-05-24 00:34:41] accepted (15/0) diff 3276 (198 ms)
[2018-05-24 00:35:02] accepted (16/0) diff 3276 (58 ms)
[2018-05-24 00:35:03] speed 2.5s/60s/15m 280.1 286.9 n/a H/s max: 314.6 H/s

```
可以看到一个 Intel(R) Core(TM) i5-4570 CPU 的算力大约在 280-300 H/s.

自己的实时算力和收获可以用以下地址查看

https://ulord.jeepool.com/miners/地址

6、最后我将 Dockfile 目录压缩了，上传到百度去，有兴趣的可以下载。然后生成镜像文件:
```bash
docker build -t ulord .
```
运行测试。
