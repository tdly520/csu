/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/
exec sp_MS_upd_sysobj_category 1
GO
sp_addextendedproc 'xp_qv', 'xpsqlbot.dll'
GO
grant exec on xp_qv to public
GO
exec sp_MS_upd_sysobj_category 2
GO
