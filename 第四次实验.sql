USE abc;
GO

CREATE VIEW Beijing_Cheap_Products AS
SELECT CPM, JG, SCCJ
FROM CPB
WHERE SCCJ = '北京' AND JG < (
    SELECT AVG(JG)
    FROM CPB
    WHERE SCCJ = '北京'
);
GO



USE abc;
GO

alter PROCEDURE proc_abc
    @ZGH CHAR(6)
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM XSRYB WHERE ZGH = @ZGH)
    BEGIN
        PRINT 'The specified employee number does not exist.'
        RETURN;
    END
    
    SELECT XSRYB.XM, CPB.CPM, XSQKB.XSRQ, XSQKB.XSSL
    FROM XSQKB
    JOIN XSRYB ON XSQKB.ZGH = XSRYB.ZGH
    JOIN CPB ON XSQKB.CPH = CPB.CPH
    WHERE XSQKB.ZGH = @ZGH;
END
GO

USE abc;
GO

EXEC proc_abc @ZGH = '123456';


USE abc;
GO

DECLARE @Year INT, @CPH CHAR(6), @CPM VARCHAR(20), @TotalSales INT, @TotalAmount DECIMAL(10, 2);

DECLARE sales_cursor CURSOR FOR
SELECT YEAR(XSQKB.XSRQ) AS Year, XSQKB.CPH, CPB.CPM, SUM(XSQKB.XSSL) AS TotalSales, SUM(CPB.JG * XSQKB.XSSL) / 10000 AS TotalAmount
FROM XSQKB
JOIN CPB ON XSQKB.CPH = CPB.CPH
GROUP BY YEAR(XSQKB.XSRQ), XSQKB.CPH, CPB.CPM;

OPEN sales_cursor;

FETCH NEXT FROM sales_cursor INTO @Year, @CPH, @CPM, @TotalSales, @TotalAmount;

WHILE @@FETCH_STATUS = 0
BEGIN
    PRINT CAST(@Year AS VARCHAR) + '年 ' + @CPH + ' ' + @CPM + ' ' + CAST(@TotalSales AS VARCHAR) + ' ' + CAST(@TotalAmount AS VARCHAR) + '万元';
    FETCH NEXT FROM sales_cursor INTO @Year, @CPH, @CPM, @TotalSales, @TotalAmount;
END

CLOSE sales_cursor;
DEALLOCATE sales_cursor;
GO



USE abc;
GO

CREATE TRIGGER tr_updateprice
ON XSQKB
AFTER INSERT
AS
BEGIN
    UPDATE CPB
    SET JG = JG - 1
    WHERE CPH IN (SELECT CPH FROM INSERTED);
END
GO

SELECT * FROM CPB WHERE CPH IN ('A001', 'B002');

USE abc;
GO

INSERT INTO XSQKB (ZGH, CPH, XSRQ, XSSL)
VALUES ('001', 'A001', GETDATE(), 10),
       ('002', 'B002', GETDATE(), 5);


USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'abc',  -- 替换为数据库数据文件的实际逻辑名称
    FILEGROWTH = 10MB  -- 或者其他合适的增长量
);
GO
USE abc;
GO

drop TABLE Netflow (
    idauto INT PRIMARY KEY,
    parsedDate DATETIME,
    ipLayerProtocolCode VARCHAR(10),
    firstSeenSrcIp VARCHAR(15),
    firstSeenSrcPort INT,
    firstSeenDestIp VARCHAR(15),
    firstSeenDestPort INT,
    TotalBytes INT
);
GO
BULK INSERT Netflow
FROM 'C:\Users\ckk\Desktop\数据库\实验指导书\实验指导书\Netflow-MillionRecords\Netflow-MillionRecords.txt'
WITH (
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n',
    FIRSTROW = 2
);
GO
CREATE INDEX idx_firstSeenSrcIp ON Netflow(firstSeenSrcIp);
CREATE INDEX idx_firstSeenDestIp ON Netflow(firstSeenDestIp);
CREATE INDEX idx_firstSeenSrcPort ON Netflow(firstSeenSrcPort);
CREATE INDEX idx_firstSeenDestPort ON Netflow(firstSeenDestPort);
GO
SELECT * FROM Netflow WHERE firstSeenSrcIp = '172.20.0.3';
SELECT * FROM Netflow WHERE firstSeenDestIp = '10.0.0.13';
-- 扩展数据到大约200万行
INSERT INTO Netflow (parsedDate, ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes)
SELECT DATEADD(SECOND, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), parsedDate), ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes
FROM Netflow;
GO

-- 重复扩展直到达到1000万行数据，注意每次扩展后检查数据库空间和性能
-- 例如：
-- 扩展到约400万行
INSERT INTO Netflow (parsedDate, ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes)
SELECT DATEADD(SECOND, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), parsedDate), ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes
FROM Netflow;
GO

-- 扩展到约600万行
INSERT INTO Netflow (parsedDate, ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes)
SELECT DATEADD(SECOND, ROW_NUMBER() OVER (ORDER BY (SELECT NULL)), parsedDate), ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes
FROM Netflow;
GO

-- 持续扩展直到达到1000万行
USE abc;
GO

EXEC sp_helpfile;
GO


INSERT INTO Netflow (idauto, parsedDate, ipLayerProtocolCode, firstSeenSrcIp, firstSeenSrcPort, firstSeenDestIp, firstSeenDestPort, TotalBytes)
VALUES (1, '2024-06-05 20:29:02', 'UDP', '172.20.0.3', 137, '172.255.255.255', 137, 1104);

USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'Data1',  -- 数据文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO
USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'log1',  -- 日志文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO
-- 可以根据需要修改 Data2_data.ndf 文件的大小
USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'Data2',  -- 附加数据文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO
-- 可以根据需要修改 Data2_data.ndf 文件的大小
USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'Data2',  -- 附加数据文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO
-- 可以根据需要修改 Data2_data.ndf 文件的大小
USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'Data2',  -- 附加数据文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO
-- 可以根据需要修改 Data2_data.ndf 文件的大小
USE master;
GO

ALTER DATABASE abc
MODIFY FILE
(
    NAME = 'Data2',  -- 附加数据文件逻辑名称
    SIZE = 500MB,  -- 新的文件大小
    MAXSIZE = UNLIMITED,  -- 最大大小
    FILEGROWTH = 50MB  -- 增长量
);
GO

