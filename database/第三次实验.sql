CREATE DATABASE FlightDB;
USE FlightDB;

CREATE TABLE hbb (
    hbh CHAR(6) PRIMARY KEY CHECK (hbh LIKE 'CZ%' OR hbh LIKE 'CA%' OR hbh LIKE 'FM%'),
    sfd NVARCHAR(20) NOT NULL,
    mdd NVARCHAR(20) NOT NULL,
    YJ INT NOT NULL CHECK (YJ >= 0)
);
CREATE TABLE Ckb (
    sfzh VARCHAR(20) PRIMARY KEY,
    xm NVARCHAR(10)
);
CREATE TABLE spb (
    hbh CHAR(6),
    sfzh VARCHAR(20),
    qfrq DATETIME NOT NULL,
    sprq DATETIME NOT NULL DEFAULT GETDATE(),
    sj INT NOT NULL,
    PRIMARY KEY (hbh, sfzh),
    FOREIGN KEY (hbh) REFERENCES hbb(hbh),
    FOREIGN KEY (sfzh) REFERENCES Ckb(sfzh)
);
INSERT INTO hbb (hbh, sfd, mdd, YJ) VALUES
('CZ1301', '北京', '上海', 1200),
('CZ1209', '南京', '昆明', 1300),
('CZ1502', '上海', '北京', 1200),
('CA1130', '成都', '北京', 1800),
('CA1230', '拉萨', '广州', 1500),
('CA1401', '广州', '南京', 1600);
BACKUP DATABASE FlightDB TO DISK = 'C:\Backup\BackupFull.bak';
INSERT INTO Ckb (sfzh, xm) VALUES
('91201', '王曼'),
('91202', '张飞'),
('91203', '刘羽蕴'),
('91204', '王若雨'),
('91205', '张蕊');
INSERT INTO spb (hbh, sfzh, qfrq, sprq, sj) VALUES
('CZ1301', '91201', '2001-12-20', '2001-11-20', 900),
('CZ1209', '91202', '2001-12-20', '2001-11-20', 800),
('CZ1502', '91201', '2002-05-08', '2002-05-02', 1000),
('CA1230', '91201', '2001-12-05', '2001-12-04', 1100),
('CA1401', '91202', '2002-04-05', '2002-04-04', 1200),
('CZ1301', '91203', '2001-12-20', '2001-11-20', 900),
('CZ1209', '91204', '2001-12-20', '2001-11-20', 800),
('CZ1502', '91205', '2002-05-08', '2002-05-02', 1000);
UPDATE hbb SET YJ = YJ * 1.10 WHERE mdd = '北京';
DELETE FROM spb WHERE sfzh = '91202';
DELETE FROM Ckb WHERE sfzh = '91202';
USE master;
ALTER DATABASE FlightDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

RESTORE DATABASE FlightDB FROM DISK = 'C:\Backup\BackupFull.bak' WITH NORECOVERY;
RESTORE DATABASE FlightDB FROM DISK = 'C:\Backup\BackupAdd1.bak' WITH RECOVERY;

ALTER DATABASE FlightDB SET MULTI_USER;
CREATE LOGIN FlightUser WITH PASSWORD = 'StrongPassword!';

USE FlightDB;
CREATE USER FlightUser FOR LOGIN FlightUser;
-- 授权查询权限
GRANT SELECT ON hbb TO FlightUser;
GRANT SELECT ON Ckb TO FlightUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON spb TO FlightUser;

-- 撤销对hbb和Ckb的插入、更新、删除权限
DENY INSERT, UPDATE, DELETE ON hbb TO FlightUser;
DENY INSERT, UPDATE, DELETE ON Ckb TO FlightUser;
-- 作为 FlightUser 用户执行查询
SELECT * FROM hbb;
SELECT * FROM Ckb;
SELECT * FROM spb;

-- 尝试在 hbb 和 Ckb 上进行插入、更新和删除（应该会失败）
INSERT INTO hbb (hbh, sfd, mdd, YJ) VALUES ('CZ999', '测', '测', 100); -- 应该失败
UPDATE hbb SET YJ = 1000 WHERE hbh = 'CZ131'; -- 应该失败
DELETE FROM hbb WHERE hbh = 'CZ130'; -- 应该失败

INSERT INTO Ckb (sfzh, xm) VALUES ('99999', '测试'); -- 应该失败
UPDATE Ckb SET xm = '测试' WHERE sfzh = '91201'; -- 应该失败
DELETE FROM Ckb WHERE sfzh = '91201'; -- 应该失败

-- 尝试在 spb 上进行插入、更新和删除（应该成功）
INSERT INTO spb (hbh, sfzh, qfrq, sj) VALUES ('CZ1301', '91201', '2001-12-20', 1000); -- 应该成功
UPDATE spb SET sj = 1100 WHERE hbh = 'CZ1301' AND sfzh = '91201'; -- 应该成功
DELETE FROM spb WHERE hbh = 'CZ1301' AND sfzh = '91201'; -- 应该成功
