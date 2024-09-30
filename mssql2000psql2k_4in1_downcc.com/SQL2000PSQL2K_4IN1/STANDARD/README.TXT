***************************************************************
           Microsoft SQL Server 2000 自述文件
                        2000 年 8 月 5 日
***************************************************************
(c) 版权所有 Microsoft Corporation, 2000。保留所有权利。

本文件所含信息是对 Microsoft SQL Server 2000 文档
的补充。

***************************************************************
目录
***************************************************************
1.0 简介
2.0 安装 SQL Server 2000
    2.1 系统要求
    2.2 不要将 Analysis Services 安装到 DBCS 文件夹
    2.3 安装 Analysis Services 示例
    2.4 从 SQL Server 7.0 升级后更新统计
    2.5 SQL Server 最小安装组件
    2.6 Active Directory 集成的要求
    2.7 未安装 Silverston 示例
    2.8 Windows 95 上的安装帮助
    2.9 在 SQL Server 6.5 版的基础上安装 SQL Server 2000
3.0 文档说明
    3.1 SQL Server 核心组件说明
      3.1.1 复制和 Host Integration Server
      3.1.2 用于独立软件供应商的备份/还原 API
      3.1.3 执行在 Visual Basic 中创建的 DTS 自定义任务
      3.1.4 Desktop Engine 安装程序参数
      3.1.5 将属性添加到 DTS 自定义任务
      3.1.6 触发器中的 @@TRANCOUNT 和 COMMIT
      3.1.7 通配符和转义符的行为
      3.1.8 更改 SQL Server 代理服务帐户
      3.1.9 添加纯 Unicode 错误信息
      3.1.10 卸载 SQL Server 7.0 后 DTS 使
用 ActiveX 脚本
      3.1.11 删除辅助数据库以进行日志传送
      3.1.12 ODBC API：SQLGetConnectAttr
      3.1.13 将早期版本的客户程序连接到命名实例
      3.1.14 SQL Server 有时无法打开静态 IP 端口
             地址
      3.1.15 SQLSetConnectAttr 和连接特性
             SQL_COPT_SS_PRESERVE_CURSORS
      3.1.16 SQLEndTran
      3.1.17 Active Directory 集成的权限
      3.1.18 srv_pfield（扩展存储过程编程）
      3.1.19 在 Windows 身份验证模式下使用 MSX 向导
      3.1.20 更新链接服务器上的表
      3.1.21 READ_ONLY 游标上锁定提示的作用
      3.1.22 将相关性添加到 SQL Server 资源
      3.1.23 从 MSDE 1.0 升级到 SQL Server 2000 
Desktop Engine
      3.1.24 Microsoft 搜索服务
      3.1.25 有关 Windows 95 的信息
      3.1.26 更改 SQL Server 帐户后无法访问
             全文目录
      3.1.27 有关设计分布式分区
视图的建议
      3.1.28 Desktop Engine 安装程序文件的要求
      3.1.29 Desktop Engine 安装程序 TARGETDIR 和 DATADIR 
参数
      3.1.30 重新安装 SQL Server 2000 Desktop Engine
    3.2 SQL Server 联机丛书功能说明
      3.2.1 指向 MDAC 和 XML 文档的链接不起作用
      3.2.2 打印限制
      3.2.3. 从 ADO 动态属性主题到 ADO 连接对象的
             超级链接不正确
    3.3 English Query
      3.3.1 SaveProjectToXMLDom 方法
      3.3.2 “问题自动澄清”(Automatic Clarification of Questions) 功能
    3.4 Analysis Services
      3.4.1 在 Windows NT 4.0 上注册 Analysis Services 性能
            监视计数器之前
      3.4.2 Distinct Count 聚合函数
      3.4.3 UPDATE CUBE 语句
      3.4.4 从 Beta 2 升级后处理数据库

***************************************************************
1.0 简介
***************************************************************
本文档包含在安装 Microsoft SQL Server 2000 之前应阅读的重要
信息。

SQL Server 2000 在 SQL Server 7.0 版的基础上建立，并扩展
了 SQL Server 7.0 版的性能、可靠性、质量以及易用性。
7.0. 它还包括许多新功能，这些功能进一步
将 SQL Server 确立为 OLTP、
数据仓储以及电子商务应用程序的最佳数据库平台。

***************************************************************
2.0 安装 SQL Server 2000
***************************************************************
可从下列这些来源获得 Microsoft SQL Server 2000 文
档：

* SQL Server 2000 产品盒中的《Microsoft SQL Server 2000 简介》
  手册。
* SQL Server 安装程序窗口上的 F1 帮助。 也可
  从自运行安装菜单打开 SQL Server 安装程序帮助
  文件。
* 可执行自定义安装，仅选择“联机丛书”组件以
  将 SQL Server 联机丛书
  文档安装到计算机的硬盘上。

无法从 SQL Server 2000 光盘打开 SQL Server 2000 的
整个 SQL Server 联机丛书
文档。SQL Server 联机丛书必须先安装到本地硬盘上
才可以打开。 《Microsoft SQL Server 2000 简介》手册
中的安装文档
不包含手册印刷后出现的一些
事项。 这些事项在 SQL Server 联机
丛书和 SQL Server 安装程序帮助文件中有述。

使用 SQL Server 2000 光盘上
的自运行安装程序安装 SQL Server 2000 组件。 将光盘
插入驱动器后，自运行安装程序将
自动运行。 也可通过
选择 SQL Server 2000 光盘根目录
下的 Autorun.exe 程序执行它。虽然 SQL Server 2000 光盘
的 SQLMSDE 文件夹中也有一个 Setup.exe 程序，但该程序
供在安装过程中必须
安装 SQL Server 2000 Desktop Engine 的那些应用程序
使用。 Desktop Engine 安装程序不用于从光盘
安装 SQL Server 2000 组件。有关
分发 SQL Server 应用程序的更多信息，请
参阅 SQL Server 联机丛书。

SQL Server 联机丛书是一组 HTML 帮助文档，
并且需要 Microsoft Internet Explorer 5.0 版。 可从 http://microsoft.com/ie 下
载 Internet Explorer 5.0。

对于首次安装 SQL Server 2000 的 SQL Server 7.0 版
的用户，可在安装过程中选择这些
新功能：

* 可在一台计算机上安装多个 SQL Server 
  实例。 
* 故障转移群集已与 SQL Server 安装程序
  集成。 
* 必须指定 SQL Server 排序规则，而不用指定代码
  页和排序次序。 

有关这些功能的更多信息，请参阅 SQL Server 
联机丛书。

当在同一台计算机上将 SQL Server 6.5 版升级到 SQL 
Server 2000 的实例时，必须事先应用 
SQL Server 6.5 版 Service Pack 5 (SP5) 或更高版本。当
在不同的计算机上将 SQL Server 6.5 版升级到 SQL Server 
2000 的实例时，必须事先应用 SQL 
Server 6.5 版 Service Pack 3 (SP3) 或更高版本。

Service Pack 5a 是 SQL Server 6.5 版
的最新 Service Pack，可从 
http://support.microsoft.com/support/sql 获得。

有两种方法可从 SQL Server 6.0 版
安装升级到 SQL Server 2000 安装：

* 可将 SQL Server 6.0 安装升级到 
  SQL Server 6.5，然后使用 SQL Server 2000 升级
  向导将 SQL Server 6.5 安装升级到 
SQL Server 2000。
* 可将 SQL Server 6.0 安装升级到 
  SQL Server 7.0，然后使用 SQL Server 2000 安装程序将 
  SQL Server 7.0 安装升级到 SQL Server 2000。

有关更多信息，请参阅 SQL Server 联机丛书
或《Microsoft SQL Server 2000 简介》手册中的
“升级 SQL Server 的现有安装”。

-----------------------
2.1 系统要求
-----------------------
Microsoft SQL Server 2000 可在运行 Intel 
或兼容的 Pentium、Pentium Pro 或 Pentium II 处理器的计算机上运作。
处理器必须以最低 166 MHz 的速度运行。

SQL Server 2000 的各版本有如下这些
内存 (RAM) 要求：

    企业版     最低 64 MB，推荐使用 128 MB
    标准版     最低 64 MB
    个人版     在 Windows 2000 上需要 64 MB，在
               所有其它操作系统上需要 32 MB
    开发版     最低 64 MB
    Desktop Engine         在 Windows 2000 上最低需要 64 MB，在所有
                           其它操作系统上需要 32 MB

根据所选组件和安装选项，SQL Server 2000 有
如下硬盘要求：

    数据库组件      95 到 270 MB，通常需要 250 MB
    Analysis Services        最低 50 MB，通常需要 130 MB
    English Query            80 MB
    仅 Desktop Engine       44 MB

SQL Server 2000 要求显示器具有 VGA 分辨能力；
SQL Server 图形工具要求显示器使用 800x600 
或更高的分辨率。

SQL Server 2000 需要 CD-ROM 驱动器以及 Microsoft 
鼠标或兼容的指针设备。

SQL Server 2000 需要 Internet Explorer 5.0 或更高版本，而且在
下列这些操作系统上受支持：

    * Windows 2000
    * Microsoft Windows NT 4.0 版 Service Pack 5 或更高版本
    * Windows Millennium Edition
    * Windows 98
    * Windows 95（仅客户端连接选项）

Windows NT 的最新 Service Pack 可从 
http://support.microsoft.com/support/NTServer 获得。

在 Windows 95 上安装 SQL Server 2000 软件之前，
必须安装用于 Windows 95 的 Winsock 2 Update。SQL Server 2000 光
盘上提供此更新程序，
并可从 SQL Server 2000 光盘所显示的自运行窗口
选择“SQL Server 2000 前提条件”选项
来安装它。

Windows NT 4.0 终端服务器上不
支持 SQL Server 2000。

有关 SQL Server 2000 的各版本和组件对操作系统
的要求的更多信息，请参阅 SQL Server 联机丛书
或《Microsoft SQL Server 2000 简介》手册
中的“安装SQL Server 2000 的硬件和软件
要求”。

-----------------------------------------------------
2.2 不要将 Analysis Services 安装到 DBCS 文件夹中
-----------------------------------------------------
Analysis Services 不应安装到
路径或名称采用双字节字符集 (DBCS) 中的字符的
文件夹中。 将 Analysis Services 安装到路径和名称仅使用
单字节字符的文件夹中。

----------------------------------------
2.3 安装 Analysis Services 示例
----------------------------------------
若要安装 Analysis Services 示例，必须
从 SQL Server 光盘安装 Analysis Services。示例
安装到 
x:\Program Files\Microsoft Analysis Services\Samples 中。

-----------------------------------------------------------
2.4 从 SQL Server 7.0 升级后更新统计
-----------------------------------------------------------
从 SQL Server 7.0 升级后，运行 sp_updatestats 
'resample' 更新数据库中用户表上的
统计。

----------------------------------------------
2.5 SQL Server 最小安装组件
----------------------------------------------
全文检索不包括在 SQL Server 2000 最小
安装中。

-------------------------------------------------
2.6 Active Directory 集成的要求
-------------------------------------------------
若要在 Active Directory 中注册 Microsoft SQL Server 2000 的
实例，SQL Server 实例必须安装在
运行 Microsoft Windows 2000 并且
启用 Active Directory 服务的计算机上。 SQL Server 服务也必须
配置为在本地管理员组中的 Windows LocalSystem 帐户
或 Windows 域帐户下
运行。 必须满足此要求才能将数据库和
发布从实例添加到 Active Directory。 配置为
在高级用户帐户下运行的 SQL Server 2000 实例
不具有足够权限，无法调用
处理 Active Directory 所需的所有 SQL Server 组件。

若要在 Active Directory 中注册分析服务器，
必须在运行 Windows 2000 且启了 Active Directory 服务
用的计算机上安装 MSSQLServerOLAPService。 
MSSQLServerOLAPService 也必须配置为在本地管理员组中
的 Windows LocalSystem 帐户或 Windows 域帐户下
运行。

----------------------------------------
2.7 未安装 Silverston 示例
----------------------------------------
Microsoft SQL Server 2000 企业版包含四种
常用数据库架构示例的许可证。 主题“数据库架构示例”中
提供了使用安装程序安装这些示例的指导，
但是安装程序并不安装
这些示例。 若要安装数据库架构
示例，请双击位于 SQL Server 2000 光盘上
\Devtools\Samples\Silverstondb 中的
Unzip_silverstondb.exe。

-----------------------------------
2.8 Windows 95 上的安装帮助
-----------------------------------
如果要在 Microsoft Windows 95 上安装客户端连接的过程中使用
帮助，可能需要升级到
Microsoft Internet Explorer 5.0 和 HTML Help 1.3。 可通过
从 http://www.microsoft.com 下载最新版本
来更新 Internet Explorer 和 HTML Help。HTML Help 
更新文件名为 Hhupd.exe。

----------------------------------------------------------
2.9 在 SQL Server 6.5 版的基础上安装 SQL Server 2000
----------------------------------------------------------
SQL Server 联机丛书包含的在运行 SQL Server 6.5 版的计算机上
安装 Microsoft SQL Server 2000 的
陈述自相矛盾。 结果安装取决于
安装的是 SQL Server 2000的命名实例还是
默认实例：

* 如果在运行 SQL Server 6.5 实例的计算机上
  安装 SQL Server 2000 的默认实例，则 SQL Server 2000 默认
  实例会成为可访问的 SQL Server 实例，
  而且 SQL Server 2000 程序组出现在
  “开始”菜单上。 SQL Server 6.5 的实例关闭，
  而且 SQL Server 6.5 程序组不在“开始”菜单
  上出现。

  可运行 SQL Server 2000 的默认实例或
  运行 SQL Server 6.5 的实例，但不能同时运行这
  两者。 若要在这两种版本的 SQL Server 间切换，请使用
  “开始”菜单上的“Microsoft SQL Server-Verswitch”条目。 
  当从 SQL Server 2000 切换到 SQL Server 6.5 时，
  SQL Server 2000 的实例成为不活动状态，而且 SQL 
  Server 6.5 程序组替代“开始”菜单
  上的 SQL Server 2000 程序组。 当从 SQL Server 6.5 
  切换到 SQL Server 2000 时，过程相反。

* 如果在运行 SQL Server 6.5 的计算机上安装了一个或
  多个 SQL Server 2000 的命名实例，则无默认的
  SQL Server 2000 实例，SQL Server 6.5 的实例
  作为默认实例保持活动状态。 SQL Server 
  2000 和 SQL Server 6.5 程序组同时出现在“开始”
  菜单上。 应使用 SQL Server 6.5 工具管理SQL Server 6.5 的
  默认实例，而使用 SQL Server 2000 工具
  管理 SQL Server 2000 的命名实例。

* 如果在运行 SQL Server 6.5 的计算机上同时
  安装 SQL Server 2000 的命名和默认实例，则可随时
  运行 SQL Server 2000 的命名实例，但必须
  在 SQL Server 2000 的默认实例和
  SQL Server 6.5 的默认实例之间切换版本。 SQL Server 
  2000 程序组始终出现在“开始”菜单上。每当
  切换版本使 SQL Server 6.5 成为活动的
  默认实例时，SQL Server 6.5 程序组出现在
  “开始”菜单上。 当切换版本使 SQL Server 2000 成为
  活动的默认实例时，SQL Server 6.5 程序组不会
  出现。

***************************************************************
3.0 文档说明
***************************************************************
这些是 SQL Server 联机丛书文档
完成后出现的问题。

-----------------------------------
3.1 SQL Server 核心组件说明
-----------------------------------
这些说明与 SQL Server 核心组件，如
数据库引擎、客户端组件、连接组件、
图形工具以及命令提示实用程序等有关。

3.1.1 复制和 Host Integration Server

主题“从异类数据源对复制进行编程”指出
Microsoft Host Integration Server 2000 提供
与 Microsoft SQL Server 2000 一起使用的复制日志读取器
代理程序，但是，Host Integration Server 2000 不提供与
SQL Server 2000 一起使用的日志读取器代理程序。

3.1.2 用于独立软件供应商的备份/还原 API

大量第三方备份解决方案都
支持 Microsoft SQL Server 2000。 SQL Server 提供应用程序
编程接口，使独立软件供应商
得以将 SQL Server 集成到其产品中。 这些 API 提供
最大的可靠性和性能，而且支持各种 SQL Server 备份
和还原功能，包括热点
和快照功能。 有关备份解决方案如何
与 SQL Server 集成的信息，请与备份解决方案供应商
联系。 有关备份/还原 API 的信息，请安装 SQL Server
“开发工具”组件的“备份/还原 API”
子组件。 若要完成示例和文档的
安装，请运行位于
C:\Program Files\Microsoft SQL Server\80\Tools\Devtools\Samples\
Backup 下的 Unzip_backup.exe。 
Vbackup.chm 中提供该文档。

3.1.3 执行在 Visual Basic 中创建的 DTS 自定义任务

若要在 Microsoft Visual Basic 中实现数据转换服务 (DTS) 自定义
任务，必须在主线程上执行
自定义任务。 如果自定义任务包含于“执行包”
任务中，则“执行包”任务将也需要在主线程上
运行。 同样，如果自定义任务由“动态属性”任务
操作（例如，已分配其中一个属性值），
则“动态属性”任务将需要在主线程上
执行。

3.1.4 Desktop Engine 安装程序参数

SQL Server 联机丛书主题“将 Desktop Engine 合并到
Windows 安装程序”和“SQL Server 2000 Desktop Engine 安装程序”
说明了最终版本的 Desktop Engine 安装程序忽略的
两个参数： USEDEFAULTSAPWD 和 SAPASSWORD。

默认情况下，当在 Microsoft Windows NT 4.0 或 Windows 
2000 操作系统上运行时，Desktop Engine 安装程序将已
安装的 Microsoft SQL Server 实例配置为使用 Windows 
身份验证，并将 Windows 本地管理员组放置
在 SQL Server sysadmin 固定服务器角色中。 当在
Windows NT 4.0 或 Windows 2000 操作系统上运行 Desktop Engine 安装
程序时，可指定 SECURITYMODE=SQL 参数以将
已安装的实例配置为使用具有空 sa 密
码的 SQL Server 身份验证。 当在 Windows 98 操作系统上运行
时，Desktop Engine 安装程序始终将已安装的
实例配置为使用 SQL Server 身份验证，而与是否
指定了 SECURITYMODE=SQL 无关。

已合并到 Windows 安装程序的一组 Desktop Engine 合并模块
具有相同的行为。 在 Windows 
NT 4.0 和 Windows 2000 操作系统上，如果未指定 SECURITYMODE=SQL，则SQL 
Server 的实例配置为使用 Windows 身份
验证，而如果指定了 SECURITYMODE=SQL，则配置为使用 SQL 
Server 身份验证。在 Windows 98 操作
系统上，该实例始终配置为
使用 SQL Server 身份验证。

可在使用 USEDEFAULTSAPWD 或 SAPASSWORD 的同一位置
指定 SECURITYMODE=SQL。有关更多信息，请参阅
SQL Server 联机丛书主题“将 Desktop Engine 
合并到 Windows 安装程序中”和“SQL Server 2000 Desktop Engine 安装程序”。

3.1.5 将属性添加到 DTS 自定义任务

因为 Microsoft SQL Server 2000 用来管理 DTS 自定义
任务的进程的原因，对于所有属性都必须同时包括 Get 和 Let（或 Set）
属性过程。 与自定义任务相关联的
每个属性都应包含一对属性
过程： 检索属性值的属性 Get 和
分配新值的属性 Let（或 Set）。      

3.1.6 触发器中的 @@TRANCOUNT 和 COMMIT

仅当语句开始处的事务计数
为 0 时，Microsoft SQL Server 2000 才递增语句内的
事务计数。 在 SQL Server version 7.0 中，事务计数始终
递增，而与语句开始处的事务
计数无关。 这可能导致触发器中
的 @@TRANCOUNT 返回的值在 SQL Server 2000 中要比
在 SQL Server 7.0 版中要低。 

在 SQL Server 2000 中，如果 COMMIT TRANSACTION 或 COMMIT WORK 
语句在触发器中执行，而且触发器的开始处无
相应的显式或隐性 BEGIN TRANSACTION
语句，用户所看到的行为可能与 SQL Server 7.0 版上
的行为不同。 不推荐在触发器中
放置 COMMIT TRANSACTION 或 COMMIT WORK 语句。

3.1.7 通配符和转义符的行为

通配符和转义符在 Microsoft SQL Server 2000 的 LIKE 运算符
中有如下附加行为：

* 在限定单个字符范围的 '[]' 字符内，
  通配符字符 '%'、'_' 和 '[' 不能用作
  通配符。

* 在限定单个字符范围的 '[]' 字符内，可以
  使用转义符，而且字符
  '^'、'-' 和 ']' 可以转义。

* 如果在 LIKE 模式中转义符后
  无字符，则该模式无效，而且 LIKE 返回 FALSE。

* 如果转义符后的字符不是通配符，
  则转义符将被丢弃，而且转义符后的字符
  将视为该模式中的常规字符。 
  这包括包含在限定单个字符范围
  的 '[]' 字符中的通配符字符 '%'、'_' 以及
   '['。

3.1.8 更改 SQL Server 代理服务帐户

如果运行的是 Microsoft Windows NT 4.0 和 Windows 2000，
而且选择将 Microsoft SQL Server 的 SQL Server 代理服务帐户
更改为非管理员帐户，则
必须将非管理员帐户添加到 SQL Server 中
的 sysadmin 服务器角色中。 如果不添加该帐户，则
SQL Server 代理服务帐户将无法登录
到 SQL Server。

SQL Server 代理服务必须在
Windows NT 4.0 或 Windows 2000 管理员帐户下运行，才能使用
非集成安全性连接到 SQL Server。SQL Server
必须在 Windows NT 或 Windows 2000 管理员帐户
下运行，才能将 SQL Server 代理连接选项设置为
非集成安全性。

如果将 SQL Server 服务帐户更改为 Windows NT 4.0 
或 Windows 2000 非管理员帐户，而且
在 SQL Server 6.5 和 SQL Server 2000 之间切换，则可能会丢失
对 SQL Server 6.5 服务帐户的访问权限。例
如，如果将 SQL Server 2000 服务帐户更改
为 Windows NT 4.0 或 Windows 2000 上的非管理员帐户，
然后切换到 SQL Server 6.5，那么将无法访问
运行 SQL Server 6.5 的计算机。 必须使用“控制面板”
将 SQL Server 服务帐户改回到 Windows NT 
或 Windows 2000 管理员帐户。

如果在同一计算机上有 SQL Server 7.0 的默认实例和
SQL Server 2000 的命名实例，而且使用 SQL Server 7.0 中的
SQL Server 企业管理器管理 SQL Server 7.0 的默认
实例，则可能无法
切换 SQL Server 2000 命名实例上的服务帐户。
例如，如果这两个实例使用
SQL Server 服务的同一非管理员帐户运行，而且您
将 SQL Server 7.0 的实例更改为不同的帐户，则
可能无法更改 SQL Server 2000 实例上
的服务帐户。在此帐户上已失去模拟管理员的
能力，因为 SQL Server 7.0 的实例和
SQL Server 2000 的实例具有相同的
非管理员帐户。 若要纠正此问题，请使用 SQL Server 2000 实例上的“控制面板”
将 SQL Server 服务帐户更改为
Windows NT 或 Windows 2000 管理员
帐户。 重新启动服务后，可将服务
帐户更改为运行 SQL Server 2000 的计算机上的
任何其它帐户。

3.1.9 添加纯 Unicode 错误信息

“管理 SQL Server 消息”对话框不支持
向 sysmessages 表添加纯 Unicode 消息。 若要添加
这类消息，请使用 sp_addmessage 存储过程。 请确保
在 'msg' 参数上使用 N 前缀（例如，
@msgtext = N'xxx'）。

3.1.10  卸载 SQL Server 7.0 后 DTS 使
用 ActiveX 脚本

卸载 SQL Server 7.0 后，若要在 Microsoft SQL Server 2000 
中使用 Microsoft ActiveX 脚本，则必须重新注册
ActiveX 脚本库 (Axscphst.dll)。 请使用 Regsvr32.exe 
注册实用程序并从 MS-DOS 或 Windows“运行”命令
执行下列命令（用您自己的盘符
替代）： 
regsvr32.exe C:\Program Files\Microsoft SQL Server\80\Tools\Binn\
axscphst.dll 

如果注册成功，将出现一个消息框，指出
已正确注册 Axscphst.dll。 

3.1.11 删除辅助数据库以进行日志传送

如果为进行日志传送而配置的所有辅助数据库都
从辅助项本身删除，那么用于日志传送的数据库维护
计划将无法再用来将辅助数据库添加回
计划中。 用于日志传送的数据库维护计划
必须删除并为日志传送重新配置才能在
辅助数据库上使用。 

3.1.12 ODBC API： SQLGetConnectAttr

Microsoft SQL Server 2000 中 SQL_ATTR_CONNECTION_DEAD 和 
SQL_COPT_SS_CONNECTION_DEAD 的行为与在
SQL Server 早期版本中的行为不同。 
在 SQL Server 2000 中，SQL_ATTR_CONNECTION_DEAD 返回连接的最新
状态，但该状态可能不是当前
连接状态。 但是，SQL_COPT_SS_CONNECTION_DEAD 将
始终查询连接的当前状态的
Net-Library。

为了区分这些行为，
在 SQL Server 2000 引用文件中
赋予了 SQL_COPT_SS_CONNECTION_DEAD 一个新值。 对于使用此特性（用 SQL Server 2000 头生成）的
应用程序，如果运行时所用的是 SQL Server 7.0 驱动
程序，那么将返回错误
（HY092，无效特性/选项标识符）。 建议
应用程序在调用 SQLGetConnectAttr 之前检查所用的
驱动程序的版本，如果应用程序
在 SQL Server 7.0 驱动程序上运行，那么请使
用 SQL_ATTR_CONNECTION_DEAD 替换 SQL_COPT_SS_CONNECTION_DEAD。

3.1.13 将早期版本的客户程序连接到命名实例

SQL Server 联机丛书主题“使用 SQL Server 2000 的命名
和多个实例”指出必须使用
SQL Server 2000 客户端组件才能连接到
SQL Server 2000 的命名实例。但是，SQL Server 7.0 版客户端
网络实用工具可用于配置服务器别名，SQL Server 7.0 版
客户端组件可用该服务器别名连接到 SQL Server 2000 的命名
实例。SQL Server 联机丛书
主题“SQL Server 
2000 和 SQL Server 7.0 版”和“与多个实例通讯”中
有这方面的叙述。

3.1.14 SQL Server 有时无法打开静态 IP 端口地址

Microsoft SQL Server 的实例配置为监听
静态 IP 端口（如默认情况下监听
端口 1433 的默认实例）时，如果 SQL Server 服务初始化时另一个
应用程序或组件正在使用该端口，那么
SQL Server 服务无法打开该端口。 TCP/IP 服务器
Net-Library 将不初始化，而且 SQL Server 的实例
在服务停止并重新启动前无法
接受 TCP/IP 连接。 如果使用服务器网络实用工具指定为 0 的
端口地址，从而将 SQL Server 的实例配置为使用动态端口
地址，则不会出现此问题。 
如果无法使用动态端口地址（例如，当
SQL Server 连接必须通过配置为通过
特定端口地址的防火墙，或者当某些连接
是使用 SQL Server 7.0 版或更早版本的
客户端组件建立时），那么推荐使用小于 1024 的
端口地址。 在此范围内选择未被操作系统
或其它应用程序使用的端口。

3.1.15 SQLSetConnectAttr 和连接特性
       SQL_COPT_SS_PRESERVE_CURSORS

SQL_COPT_SS_PRESERVE_CURSORS 定义使用手工提交模式时
游标的行为。 当使用 SQLEndTran 提交或回滚的事务时
表现该行为。

SQL_PC_OFF：默认值。 当使用 SQLEndTran 提交或回滚
事务时，游标关闭。

SQL_PC_ON： 当使用 SQLEndTran 提交或回滚
事务时，游标不关闭，但在异步模式下使用静态或
键集游标的情况除外。如果当游标的填充尚未完成时
发出回滚，则游标
将关闭。

3.1.16 SQLEndTran

当 SQLEndTran 提交或回滚操作时，语句的相关游标的行为由
特定驱动程序的ODBC 连接
特性 SQL_COPT_SS_PRESERVE_CURSORS 的值确定，而该特性是由
SQLSetConnectAttr 设置的。

3.1.17 Active Directory 集成的权限

在 Microsoft SQL Server 2000 中，只有 sysadmin 固定服务器角色的
成员才能在 Active Directory 中注册数据库
或发布，而 dbowner 固定数据库角色的成员则
不能。

3.1.18 srv_pfield（扩展存储过程编程）

不再支持 SRV_PWD 字段。 不要编写
使用此字段的扩展存储过程。

3.1.19 在 Windows 身份验证模式下使用 MSX 向导

如果在配置有 Windows 身份验证的计算机上使
用“创建主服务器向导”(MSX)，则必须
重新启动计算机。 这是因为向导需要混合
模式身份验证（Windows 身份验证和 SQL Server 
身份验证）。 向导将为您更改身份验证
模式，但您随后必须重新启动主服务器上的 Microsoft SQL Server 和 
SQL Server 代理程序。

3.1.20 更新链接服务器上的表

无法通过视图更新链接服务器上的表。 
对于任何链接服务器都是如此，而与提供程序无关。

3.1.21 READ_ONLY 游标上锁提示的作用

UPDLOCK 和 TABLOCKX 锁提示在 READ_ONLY 游标上不再
提出错误。 相反，其作用与
在 OPTIMISTIC 游标上的作用相同。 UPDLOCK 引起游标
获得更新滚动锁，而 TABLOCKX 因滚动锁的原因而
忽略。

3.1.22 将相关性添加到 SQL Server 资源

如果将 SQL Server 2000 安装到具有多个磁盘驱动器
的 Windows 2000 或 Windows NT 群集组中，并且选择
将数据放置到其中一个驱动器上，则 SQL Server 
资源设置为仅依赖于该驱动器。 若要将
数据或日志放置到另一个磁盘上，必须首先将另一个磁盘的
相关性添加到 SQL Server 资源中。
 
将新磁盘（例如，磁盘 K）添加到 SQL Server 相关性
中的方法：

1. 打开“管理工具”中的“簇管理员”。

2. 定位包含适用 SQL Server 资源的
   组。

3. 如果磁盘 K 的资源已在该组中，请转到
   第 4 步。否则，请定位包含磁盘 K 的组。
   如果该组以及包含 SQL Server 的组不属于
   同一节点，请将包含磁盘 K 的资源的组
   移动到包含 SQL Server 
   组的节点。

4. 选择 SQL Server 资源，打开“属性”对话
   框，然后使用“相关性”选项卡将磁盘 K 添加到
   SQL Server 相关性的集合中。

3.1.23 从 MSDE 1.0 升级到 SQL Server 2000 
Desktop Engine

从 MSDE 1.0 升级到 SQL Server 2000 Desktop Engine 的方法：

* 如果使用 Setup.exe，则必须指定 UPGRADE=1 作为
  命令提示开关。 有关 Setup.exe 命令提示开关的
  更多信息，请参阅 SQL Server 联机丛书
  中的“SQL Server 2000 Desktop Engine 安装程序”。 
或
  如果在 Windows 安装程序安装中使用 Desktop Engine 合并
  文件，则必须在 Windows 安装程序 .ini 文件的
  [Options] 部分指定 UPGRADE=1 以及其它
  Destktop Engine 条目。有关 Desktop Engine Windows 安装程序条目
  的更多信息，请参阅 SQL Server 联机丛书中的“将
  Desktop Engine 合并到
Windows 安装程序”。

* 必须提供使用 SampleUpg.msi 创建的自定义安装
  包文件。有关 SampleUpg.msi 的更多
  信息，请参阅 SQL Server 联机丛书中的“管理 Desktop Engine 安装
  包文件”。

将 MSDE 1.0 升级到 Microsoft SQL Server 2000 Desktop 
Engine 时，需要在 SQL Server 2000 Desktop Engine 安装过程中
 或者在 Windows 安装程序安装中
使用 Desktop Engine 合并模块时，
使用一个或两个附加选项：

* UPGRADE=1
  指定 Desktop Engine 安装程序或 Windows 安装程序
  将 MSDE 1.0 的实例升级到 SQL Server 2000 
  Desktop Engine。 支持的唯一值是 1。

* UPGRADEUSER='loginaccount'
  指定当连接到 MSDE 1.0 以升级 master 数据库时，
  Desktop Engine 安装程序或 Windows 安装程序将
  使用的 SQL Server 身份验证
  登录帐户。 登录帐户必须具有空
  密码而且必须是 sysadmin 固定服务器角色的
  成员。 如果希望安装程序或 Windows 安装程序使用 SQL Server 身份
  验证进行连接，请指定此参数。 
  推荐的选择是不指定 UPGRADEUSER，
  因为它可能引起 Desktop Engine 安装程序或 Windows 安装程序
  使用 Windows 身份验证连接到
  MSDE 1.0 的实例。 当使用 Windows 身份验证时，必须在已包含
  于 SQL Server sysadmin 固定服务器角色中的 Windows 帐户下
  运行 Desktop Engine 安装程序
  或 Windows 安装程序。 如果确实需要指定 UPGRADEUSER，
  请通过尽量缩短 sysadmin 登录可拥有
  空密码的时间（例如，升级完成后立即
  给登录分配一个有效密码）
  来保护安全性。

可在 .ini 文件中或作为
 Desktop Engine 安装程序 /设置开关的一部分指定这些选项。有关指定选项的
更多信息，请参阅 SQL Server 联机丛书中的
主题“SQL Server 2000 Desktop Engine 安装程序”和
“将 Desktop Engine 合并到 Windows 安装程序中”。 下列是
用于升级的 .ini 文件的示例：

   [Options]
   UPGRADE=1
   UPGRADEUSER=SetupLogin

请确保在将 MSDE 1.0 的实例升级到 SQL Server 2000 Desktop Engine 之前，
该实例已停止。

3.1.24 Microsoft 搜索服务

在全文索引中“创建和维护数据库”主题的说明中
包含的有关 Microsoft 搜索服务的信息
不正确。 下列是正确的信息：

Microsoft Windows NT 和 Windows 2000 上支持 Microsoft 搜索
服务，但 Windows 98 上不支持。
Microsoft 搜索服务可同 
Microsoft SQL Server 2000 个人版一起安装。

3.1.25 有关 Windows 95 的信息

SQL Server 联机丛书中少数几个主题对下列这些配置的说明
不正确：

* 在运行 Microsoft Windows 95 的计算机上
  运行 Microsoft SQL Server 2000 的实例。

* 在运行 Windows 95 的计算机上运行 SQL Server 2000 工具
  和实用程序。

联机丛书主题“Windows 98 上的 SQL Server 2000”
正确地陈述了 Windows 95 上不
支持的 SQL Server 实用程序和工具。同样，主题
“服务器组件”正确地陈述了 Windows 95 上不
支持的 SQL Server 2000 数据库引擎和
其它服务器组件。

可以在 Windows 95 上安装客户端
连接组件，这些组件允许应用程序访问
其它计算机上的 SQL Server 2000 的实例。

3.1.26 更改 SQL Server 帐户后无法访问
       全文目录

将 Microsoft SQL Server 更改为在非管理员
帐户下运行将导致现有全文目录无法访问。 
要么重建并执行属于此 SQL Server 实例的
所有目录的完全填充，要么切换回
具有管理员权限的帐户。

3.1.27 有关设计分布式分区
视图的建议

在设计分区架构时，必须明确属于每个分区
的数据是哪些。 分区列不能为
标识列、默认列或时间戳列。 对分区列的可更新性
无限制。

3.1.28 Desktop Engine 安装程序文件的要求

SQL Server 联机丛书中的主题“SQL Server 2000 Desktop Engine 安装程序”
提供的用来成功运行安装程序的
文件列表不完整。 除该主题中提到的
文件外，还必须将下列文件从 SQL Server 
2000 光盘复制到包含 Setup.exe 的文件夹：
 
* \Sqlmsde 下的 Sqlresld.dll。 

* \Sqlmsde\Resources\NNNN 下的 Setup.rll。 NNNN 因光盘上 
  SQL Server 2000 语言的不同而不同。
  例如，对于美国英语版的 SQL Server 2000，
  NNNN 为 1033，但是对于法语或德语版，
  NNNN 将是不同的数字。

* \Sqlmsde\msi 下的 Instmsi.exe 和 InstmsiW.exe。 

为使 Desktop Engine 安装示例起作用，也必须复制
这些文件。

3.1.29 Desktop Engine 安装程序 TARGETDIR 和 DATADIR 参数

为 Microsoft SQL Server Desktop Engine 
安装程序 TARGETDIR 和 DATADIR 参数指定的文件路径必须以
反斜线终止。例如：

TARGETDIR="C:\Program Files\Microsoft SQL Server\Mssql$MyInstance\Binn\"
DATADIR="C:\Program Files\Microsoft SQL Server\Mssql$MyInstance\Data\"

3.1.30 重新安装 SQL Server 2000 Desktop Engine

如果安装 Microsoft SQL Server 2000 
Desktop Engine 实例的尝试失败（原因如指定了错误的
登录帐户或使用了无足够文件
权限的 Microsoft Windows 帐户），则可以在纠正错误情况后继续执行
安装程序。 这包括使用
Desktop Engine 安装程序或 Windows 安装程序安装进程
中的 Desktop Engine 合并模块安装。

当继续执行安装进程时，除在最初安装尝试中所指定
的选项外，还必须指定
两个安装选项：

* REINSTALL=All
  指定 Desktop Engine 安装程序或 Windows 安装程序安装
  所有 SQL Server 2000 Desktop Engine 功能。 支持的唯一值
  是 All。

* REINSTALLMODE={ omus | a }
  指定 Desktop Engine 安装程序或 Windows 安装程序所执行的
  处理级别。 当重新执行失败的安装时，
  指定 REINSTALLMODE=omus。 利用此选项，将验证和完成
  整个安装进程。 当必须重建的仅有 master 数据库（如
  持有 master 数据库的磁盘驱动器出错后）时，
  指定 REINSTALLMODE=a。

在 .ini 文件中或作为 
Desktop Engine 安装程序 /设置开关的一部分指定这些选项。有关指定安装选项的
更多信息，请参阅 SQL Server 联机丛书中的主题
“SQL Server 2000 Desktop Engine 安装程序”和“将 Desktop Engine 合
并到 Windows 安装程序中”。

-----------------------------------------------
3.2 SQL Server 联机丛书功能说明
-----------------------------------------------
这些是与 SQL Server 
联机丛书的功能相关的问题。

3.2.1 指向 MDAC 和 XML 文档的链接不起作用

当用 MMC 管理单元（如 SQL Server 企业管理器）中的 F1 键或
“帮助”菜单打开 SQL Server 联机丛书时，指
向 MDAC 和 XML 文档的链接不起作用。 若要查看
MDAC 和 XML 文档，请打开位于 
C:\Program Files\Microsoft Sql Server\80\Tools\Books 下的 Mdacxml.chm。

注意： 当直接从“开始”菜单上的 
SQL Server 程序组或通过
运行 Sql80.col 启动 SQL Server 联机丛书时，该链接起正常作用。

3.2.2 打印限制

如果使用 Microsoft Internet Explorer 5.5 版，
不推荐使用“打印所选标题以及所有子主题”
选项。

如果使用 Internet Explorer 5.0 或 Internet Explorer 5.5，
则在“打印”对话框中选择“打印链接的所有文档”时，链接主题可能无法
始终打印出来。
 
3.2.3. 从 ADO 动态属性主题到 ADO 连接对象的
       超级链接不正确

ADO 连接对象支持 60 种动态属性，各个
属性分别在单个主题中进行说明。 各个
主题都包含用来交叉引用
ADO 连接对象的超级链接。 这些链接错误地引用了
DTS 连接对象。 
正确引用 ADO 连接对象的方法： 
 
1. 在 SQL Server 联机丛书中，单击“搜索”选项卡。
 
2. 在“键入要搜索的单词”框中，键入： 
   “连接对象”。 

3. 在选择主题窗格中，双击“ADO 和 SQL Server”的
   “连接对象”。

-----------------
3.3 English Query
-----------------   
这些是文档中未反映出来但 English Query 中存在
的问题。
     
3.3.1 SaveProjectToXMLDom 方法

此方法的语法应为：
      Set variable = EQModel.SaveProjectToXMLDOM
其中 variable 是返回的 XMLDOMDocument 对象，项目将保存到此
对象中。

3.3.2 “问题自动澄清”(Automatic Clarification of Questions) 功能

InputList 对象有下列附加属性以
支持“问题自动澄清”功能。这些
属性是只读、可选的，而且数据类型为 Variant：

* LookupQueries
  返回 QueryCmd 对象的数组，
  其大小在 ItemCount 中指定，或者为 NULL。 每个 LookupQuery 都与 Items 数组中的
  一个项对应。 如果查询未返回行，
  则对应的项可能不是 InputList 对象的
  正确默认选择。  

  例如，对于问题“How many awards did John 
  Fortune win？”，English Query 应用程序可能在其
  字典中无“John Fortune”，因此返回一个
  UserClarification Response，它所包含的 InputList 
  带有文本“Which of these do you mean by John Fortune？” 
这些选项包括： 演员的姓名，用来选择名
  为 John Fortune 的演员，或者电影的名字，用来选择名
  为 John Fortune 的电影。 LookupQuery 与每个选项
  都相关联。 如果仅有其中一个查询返回行，
  则客户端应用程序可使用相应的项
  作为 InputList 的用户选择，并可在无用户干涉的情况下
  响应 UserClarificationResponse。

注意： 对于某些 InputList 对象，无法
  生成 LookupQueries。 对于这些对象，数组中的每个 LookupQuery 均
  为 NULL。

* EntityIDs 属性
  返回 EntityIDs 的数组，其大小在 ItemCount 中指定。 
  每个 EntityID 均与 Items 数组中的一个项对应。 如果
  Items 数组中的选择是实体（例如，演员的
  姓名），则 EntityID 包含该实体的 ID
  （例如，author_name）。 如果 Items 数组中的选择不是
  实体（例如，名字），则 EntityID 为空。

InputText 对象具有附加属性以支持
“问题自动澄清”功能：

* LookupQueries 是只读、可选的属性，数据
  类型为 Variant，而且可以为 NULL。 LookupQueries 是用来确定 InputText 对象
  默认值的 QueryCmds 对象的
  集合。

  例如，对于问题“List the old people”，English 
  Query 应用程序可能不包含为“old”指定的阈值。 
  因而返回 UserClarificationResponse，它所包含的 InputText 
  带有文本“An old person is a person whose age is over ___。” 
  LookupQuery 选择中间年龄。 客户端应用程序
  可选择将返回值用作对 
  InputText 的响应，并可在无用户干涉的情况下
  响应 UserClarificationResponse。

注意： 对于某些 InputText 对象，无法
  生成 LookupQueries。 对于这些对象，LookupQuery 集合为空。

---------------------
3.4 Analysis Services
---------------------
这些是文档中未反映出来但 Analysis Services 中存在的
问题。

3.4.1 在 Windows NT 4.0 上注册 Analysis Services 性能
      监视计数器之前

在安装过程中 Analysis Services 性能监视计数器
安装到硬盘上，但在 Microsoft Windows NT 4.0
上，因为 Windows NT 4.0 的某些版本存在问题，所以并
不会自动对其进行注册。 在使用
SQL Server 联机丛书主题
“监视 Analysis Services 性能”中的手册指导说明在
Windows NT 4.0 上注册计数器之前，请查看 Microsoft Knowledge Base 
文章 Q242472 以获得更多信息。 可能需要将
文件 Msmdctr80.dll 移动到一个不同的文件夹，才能满足文章中
所列的要求。 在 Microsoft Windows 2000 上，
性能计数器将在安装过程中自动安装
和注册。

3.4.2 Distinct Count 聚合函数
    
Analysis Services 主题“规范和限制”中
所述的对 Distinct Count 聚合函数的限制
不正确。 Distinct Count 聚合函数
要求度量值为数字。

Analysis Services 主题“ROLAP 分区的索引
视图”中第一个带编号的项所述信息应为： “分区
不能包含使用聚合函数 Min、
Max 或 Distinct Count 的度量值。”

3.4.3 UPDATE CUBE 语句

在 Analysis Services 主题“UPDATE CUBE 语句”中，语句的 BNF 
指出的“在单个语句中可更新
多个单元”是错误的。 在每个 UPDATE CUBE 语句中仅可更新
一个单元。

3.4.4 从 Beta 2 升级后处理数据库

如果从 Analysis Services 的 Beta 2 版升级，
请处理所有升级的数据库，以确保正确的数据
转换。
