SELECT xsb.xh, xsb.xm, kcb.kcm, xskcb.fs
FROM xsb
INNER JOIN xskcb ON xsb.xh = xskcb.xh
INNER JOIN kcb ON xskcb.kch = kcb.kch
WHERE xskcb.fs >= 90;
