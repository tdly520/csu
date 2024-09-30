-- 创建销售人员表
CREATE TABLE XSRYB (
    ZGH NVARCHAR(6) PRIMARY KEY,
    XM NVARCHAR(10) NOT NULL,
    NL INT CHECK (NL BETWEEN 20 AND 60),
    DQ NVARCHAR(10),
    YZhBM CHAR(6) CHECK (YZhBM LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- 创建产品表
CREATE TABLE CPB (
    CPH NVARCHAR(6) PRIMARY KEY,
    CPM NVARCHAR(20) NOT NULL,
    SCCJ NVARCHAR(10) NOT NULL,
    JG INT CHECK (JG > 0),
    SCRQ SMALLDATETIME DEFAULT GETDATE()
);

-- 创建销售情况表
CREATE TABLE XSQKB (
    ZGH NVARCHAR(6) NOT NULL,
    CPH NVARCHAR(6) NOT NULL,
    XSRQ SMALLDATETIME NOT NULL,
    XSSL INT,
    PRIMARY KEY (ZGH, CPH, XSRQ),
    FOREIGN KEY (ZGH) REFERENCES XSRYB(ZGH),
    FOREIGN KEY (CPH) REFERENCES CPB(CPH)
);

-- 插入销售人员表数据
INSERT INTO XSRYB (ZGH, XM, NL, DQ, YZhBM)
VALUES 
('G01', '人员1', 25, '北京', '100101'),
('G02', '人员2', 45, '北京', '100108'),
('G03', '人员3', 30, '天津', '200211'),
('G04', '人员4', 42, '天津', '200322'),
('G05', '人员5', 50, '南京', '123456'),
('G06', '人员6', 38, '上海', '300310'),
('G07', '人员7', 28, '上海', '300123'),
('G08', '人员8', 55, '上海', '300456');

-- 插入产品表数据
INSERT INTO CPB (CPH, CPM, SCCJ, JG, SCRQ)
VALUES
('P02', '电冰箱', '北京', 4800, '2002-02-14'),
('P03', '计算机', '北京', 7900, '2001-11-01'),
('P04', '音响', '上海', 4000, '2001-04-06'),
('P05', '空调', '上海', 3800, '2001-10-11'),
('P06', '洗衣机', '青岛', 3100, '2001-09-18'),
('P07', '笔记本', '北京', 11230, '2001-08-30'),
('P08', '微波炉', '天津', 1980, '2002-01-20');

-- 插入销售情况表数据
INSERT INTO XSQKB (ZGH, CPH, XSRQ, XSSL)
VALUES
('G03', 'P04', '2001-11-20', 16),
('G03', 'P05', '2001-11-20', 2),
('G05', 'P02', '2002-05-02', 1),
('G06', 'P07', '2001-12-04', 5),
('G06', 'P08', '2002-04-04', 10),
('G03', 'P02', '2002-06-05', 4),
('G08', 'P02', '2001-12-05', 1);
