-- ����������Ա��
CREATE TABLE XSRYB (
    ZGH NVARCHAR(6) PRIMARY KEY,
    XM NVARCHAR(10) NOT NULL,
    NL INT CHECK (NL BETWEEN 20 AND 60),
    DQ NVARCHAR(10),
    YZhBM CHAR(6) CHECK (YZhBM LIKE '[0-9][0-9][0-9][0-9][0-9][0-9]')
);

-- ������Ʒ��
CREATE TABLE CPB (
    CPH NVARCHAR(6) PRIMARY KEY,
    CPM NVARCHAR(20) NOT NULL,
    SCCJ NVARCHAR(10) NOT NULL,
    JG INT CHECK (JG > 0),
    SCRQ SMALLDATETIME DEFAULT GETDATE()
);

-- �������������
CREATE TABLE XSQKB (
    ZGH NVARCHAR(6) NOT NULL,
    CPH NVARCHAR(6) NOT NULL,
    XSRQ SMALLDATETIME NOT NULL,
    XSSL INT,
    PRIMARY KEY (ZGH, CPH, XSRQ),
    FOREIGN KEY (ZGH) REFERENCES XSRYB(ZGH),
    FOREIGN KEY (CPH) REFERENCES CPB(CPH)
);

-- ����������Ա������
INSERT INTO XSRYB (ZGH, XM, NL, DQ, YZhBM)
VALUES 
('G01', '��Ա1', 25, '����', '100101'),
('G02', '��Ա2', 45, '����', '100108'),
('G03', '��Ա3', 30, '���', '200211'),
('G04', '��Ա4', 42, '���', '200322'),
('G05', '��Ա5', 50, '�Ͼ�', '123456'),
('G06', '��Ա6', 38, '�Ϻ�', '300310'),
('G07', '��Ա7', 28, '�Ϻ�', '300123'),
('G08', '��Ա8', 55, '�Ϻ�', '300456');

-- �����Ʒ������
INSERT INTO CPB (CPH, CPM, SCCJ, JG, SCRQ)
VALUES
('P02', '�����', '����', 4800, '2002-02-14'),
('P03', '�����', '����', 7900, '2001-11-01'),
('P04', '����', '�Ϻ�', 4000, '2001-04-06'),
('P05', '�յ�', '�Ϻ�', 3800, '2001-10-11'),
('P06', 'ϴ�»�', '�ൺ', 3100, '2001-09-18'),
('P07', '�ʼǱ�', '����', 11230, '2001-08-30'),
('P08', '΢��¯', '���', 1980, '2002-01-20');

-- �����������������
INSERT INTO XSQKB (ZGH, CPH, XSRQ, XSSL)
VALUES
('G03', 'P04', '2001-11-20', 16),
('G03', 'P05', '2001-11-20', 2),
('G05', 'P02', '2002-05-02', 1),
('G06', 'P07', '2001-12-04', 5),
('G06', 'P08', '2002-04-04', 10),
('G03', 'P02', '2002-06-05', 4),
('G08', 'P02', '2001-12-05', 1);
