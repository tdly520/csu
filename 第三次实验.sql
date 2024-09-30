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
('CZ1301', '����', '�Ϻ�', 1200),
('CZ1209', '�Ͼ�', '����', 1300),
('CZ1502', '�Ϻ�', '����', 1200),
('CA1130', '�ɶ�', '����', 1800),
('CA1230', '����', '����', 1500),
('CA1401', '����', '�Ͼ�', 1600);
BACKUP DATABASE FlightDB TO DISK = 'C:\Backup\BackupFull.bak';
INSERT INTO Ckb (sfzh, xm) VALUES
('91201', '����'),
('91202', '�ŷ�'),
('91203', '������'),
('91204', '������'),
('91205', '����');
INSERT INTO spb (hbh, sfzh, qfrq, sprq, sj) VALUES
('CZ1301', '91201', '2001-12-20', '2001-11-20', 900),
('CZ1209', '91202', '2001-12-20', '2001-11-20', 800),
('CZ1502', '91201', '2002-05-08', '2002-05-02', 1000),
('CA1230', '91201', '2001-12-05', '2001-12-04', 1100),
('CA1401', '91202', '2002-04-05', '2002-04-04', 1200),
('CZ1301', '91203', '2001-12-20', '2001-11-20', 900),
('CZ1209', '91204', '2001-12-20', '2001-11-20', 800),
('CZ1502', '91205', '2002-05-08', '2002-05-02', 1000);
UPDATE hbb SET YJ = YJ * 1.10 WHERE mdd = '����';
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
-- ��Ȩ��ѯȨ��
GRANT SELECT ON hbb TO FlightUser;
GRANT SELECT ON Ckb TO FlightUser;
GRANT SELECT, INSERT, UPDATE, DELETE ON spb TO FlightUser;

-- ������hbb��Ckb�Ĳ��롢���¡�ɾ��Ȩ��
DENY INSERT, UPDATE, DELETE ON hbb TO FlightUser;
DENY INSERT, UPDATE, DELETE ON Ckb TO FlightUser;
-- ��Ϊ FlightUser �û�ִ�в�ѯ
SELECT * FROM hbb;
SELECT * FROM Ckb;
SELECT * FROM spb;

-- ������ hbb �� Ckb �Ͻ��в��롢���º�ɾ����Ӧ�û�ʧ�ܣ�
INSERT INTO hbb (hbh, sfd, mdd, YJ) VALUES ('CZ999', '��', '��', 100); -- Ӧ��ʧ��
UPDATE hbb SET YJ = 1000 WHERE hbh = 'CZ131'; -- Ӧ��ʧ��
DELETE FROM hbb WHERE hbh = 'CZ130'; -- Ӧ��ʧ��

INSERT INTO Ckb (sfzh, xm) VALUES ('99999', '����'); -- Ӧ��ʧ��
UPDATE Ckb SET xm = '����' WHERE sfzh = '91201'; -- Ӧ��ʧ��
DELETE FROM Ckb WHERE sfzh = '91201'; -- Ӧ��ʧ��

-- ������ spb �Ͻ��в��롢���º�ɾ����Ӧ�óɹ���
INSERT INTO spb (hbh, sfzh, qfrq, sj) VALUES ('CZ1301', '91201', '2001-12-20', 1000); -- Ӧ�óɹ�
UPDATE spb SET sj = 1100 WHERE hbh = 'CZ1301' AND sfzh = '91201'; -- Ӧ�óɹ�
DELETE FROM spb WHERE hbh = 'CZ1301' AND sfzh = '91201'; -- Ӧ�óɹ�
