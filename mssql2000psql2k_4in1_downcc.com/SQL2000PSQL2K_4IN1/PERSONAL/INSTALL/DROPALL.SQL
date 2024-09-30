----+----1----+----2----+----3----+----4----+----5----+----6----+----7----+----8
Go
/***********************************************************
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.

      Pre-Drops to reduce possible space fragmentation, and to
avoid wasting time and space during DBCC UPGRADEDB.

      It is assumed this file is being run only thru ISQL.EXE,
and that the MS SQL Server allows ad-hoc catalog updates.


***********************************************************/
Go

use master
set nocount on
Go

Dump Transaction master with no_log
Go
Checkpoint
Go

/***
   Make sure server was started in single user mode (or that sp_configure?)
was used to enable updates to system tables.
***/

if (select value from syscurconfigs where config = 102) <> 1
        raiserror('Cannot run this file unless updates to system tables are enabled. Shutdown server and restart with the ''-m'' option to enable updates to system tables.'
                        ,22,127) with log

Go

if object_id('#prc_dropall_1') is not null
       drop procedure #prc_dropall_1
Go

create procedure #prc_dropall_1
as

set nocount on

Declare
       @obj_type           char(2)
      ,@obj_name           varchar(64)
      ,@count_1               integer
      ,@count_2               integer
      ,@dump_size             integer
      ,@dyn_cmd               varchar(127)
      ,@BitMSObj              integer

Select @dump_size = 25

select 'db_name()=',db_name()

Print 'Object type counts immediately prior to the drops:'

Select type ,count(*) as 'Count_10' from sysobjects
   where ObjectProperty(id, 'IsMSShipped') = 1
   group by type order by type

Print ' '


DECLARE
             csr_17_todrop
             insensitive
             Cursor For
   SELECT
             obj.type
            ,obj.name
      from
             sysobjects    obj
      where  ObjectProperty(obj.id, 'IsMSShipped') = 1
             AND (type != 'V' OR substring(name, 1, 3) != 'sys')
      order by
             obj.type
            ,obj.name
   FOR read only


Open csr_17_todrop


Select @count_1=0 ,@count_2=0


WHILE (17=17)
   begin

   FETCH        next
      from      csr_17_todrop
      into      @obj_type
               ,@obj_name

   if (@@fetch_status <> 0)
      begin
      Deallocate csr_17_todrop
      BREAK
      end

   select @count_1 = @count_1 + 1

   if (@count_1 % (@dump_size) = 0)
      begin
      select @count_2 = @count_2 + @count_1
      raiserror('So far %d Microsoft supplied sysobjects have been dropped.',0,1,@count_2) with nowait
      select @count_1=0
      dump transaction master with no_log
      end

   select @dyn_cmd = '/' + '* pre case init *' + '/'

   select @dyn_cmd =
            case @obj_type
               when 'P ' then 'drop procedure ' + @obj_name
               when 'U ' then 'drop table     ' + @obj_name
               when 'TR' then 'drop trigger   ' + @obj_name
               when 'V ' then 'drop view      ' + @obj_name
               when 'X ' then 'dbcc dropextendedproc(''' + @obj_name + ''')'
               else           '/' + '* Bypassing type=' +@obj_type+
                              ' name=' +@obj_name+ ' *' + '/'
            end


   if (@obj_type = 'U ')  --Might contain user data.
      begin

      if NOT (@obj_name in (  --Only these 'U ' can be dropped.

             'spt_values' ,'spt_monitor'
            ,'spt_datatype_info' ,'spt_datatype_info_ext'
            ,'spt_server_info'
                              )
             )
         begin
         raiserror('/* Bypassing type=%s name=%s, to avoid loss of user data. */'
                  ,0,1,@obj_type,@obj_name)
         CONTINUE
         end
      end

   print   @dyn_cmd
   EXECUTE(@dyn_cmd)

   end -- loop 17


Print ' '
Print 'Object type counts immediately after dynamic drop logic:'

Select type,count(*) 'Count_30' from sysobjects
   where ObjectProperty(id, 'IsMSShipped') = 1
   group by type order by type

Print ' '
--End of #prc_dropall_1 creation...
Go

------------------------  Run drops in some databases  --------------

use master
go
execute #prc_dropall_1
go

declare @dbname varchar(30)
select  @dbname = 'msdb'

if exists (select * from master..sysdatabases where name=@dbname)
   begin
   execute('use ' +@dbname+ ' exec #prc_dropall_1')
   end

Go

use master

Go

if object_id('tempdb..#prc_dropall_1') is not null
       drop procedure #prc_dropall_1
Go

---------- Special cases, and Hardcoded cases  -------------------

Go

if object_id('sp_dbcoalesce','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dbcoalesce (obsolete in MS SQL 6.5) ...'
	drop procedure sp_dbcoalesce
	end
else
	begin
	print 'Nonexistent is procedure sp_dbcoalesce.'
	end


-- Above were special cases.
Print ' '
Go

if object_id('MS_sqlctrs_users','P') IS NOT NULL
	begin
	print 'Dropping procedure MS_sqlctrs_users ...'
	drop procedure MS_sqlctrs_users
	end
else
	begin
	print 'Nonexistent is procedure MS_sqlctrs_users.'
	end


if object_id('sp_a_count_bits_on','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_a_count_bits_on ...'
	drop procedure sp_a_count_bits_on
	end
else
	begin
	print 'Nonexistent is procedure sp_a_count_bits_on.'
	end


if object_id('sp_abort_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_abort_xact ...'
	drop procedure sp_abort_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_abort_xact.'
	end


if object_id('sp_addalias','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addalias ...'
	drop procedure sp_addalias
	end
else
	begin
	print 'Nonexistent is procedure sp_addalias.'
	end


if object_id('sp_addarticle','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addarticle ...'
	drop procedure sp_addarticle
	end
else
	begin
	print 'Nonexistent is procedure sp_addarticle.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_addextendedproc','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addextendedproc ...'
	drop procedure sp_addextendedproc
	end
else
	begin
	print 'Nonexistent is procedure sp_addextendedproc.'
	end


if object_id('sp_addgroup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addgroup ...'
	drop procedure sp_addgroup
	end
else
	begin
	print 'Nonexistent is procedure sp_addgroup.'
	end


if object_id('sp_addlogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addlogin ...'
	drop procedure sp_addlogin
	end
else
	begin
	print 'Nonexistent is procedure sp_addlogin.'
	end


if object_id('sp_addmessage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addmessage ...'
	drop procedure sp_addmessage
	end
else
	begin
	print 'Nonexistent is procedure sp_addmessage.'
	end

Go

if object_id('sp_addpublication','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addpublication ...'
	drop procedure sp_addpublication
	end
else
	begin
	print 'Nonexistent is procedure sp_addpublication.'
	end


if object_id('sp_addpublisher','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addpublisher ...'
	drop procedure sp_addpublisher
	end
else
	begin
	print 'Nonexistent is procedure sp_addpublisher.'
	end


if object_id('sp_addremotelogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addremotelogin ...'
	drop procedure sp_addremotelogin
	end
else
	begin
	print 'Nonexistent is procedure sp_addremotelogin.'
	end


if object_id('sp_addsegment','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addsegment ...'
	drop procedure sp_addsegment
	end
else
	begin
	print 'Nonexistent is procedure sp_addsegment.'
	end


if object_id('sp_addserver','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addserver ...'
	drop procedure sp_addserver
	end
else
	begin
	print 'Nonexistent is procedure sp_addserver.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_addsubscriber','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addsubscriber ...'
	drop procedure sp_addsubscriber
	end
else
	begin
	print 'Nonexistent is procedure sp_addsubscriber.'
	end


if object_id('sp_addsubscription','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addsubscription ...'
	drop procedure sp_addsubscription
	end
else
	begin
	print 'Nonexistent is procedure sp_addsubscription.'
	end


if object_id('sp_addtype','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addtype ...'
	drop procedure sp_addtype
	end
else
	begin
	print 'Nonexistent is procedure sp_addtype.'
	end


if object_id('sp_addumpdevice','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addumpdevice ...'
	drop procedure sp_addumpdevice
	end
else
	begin
	print 'Nonexistent is procedure sp_addumpdevice.'
	end


if object_id('sp_adduser','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_adduser ...'
	drop procedure sp_adduser
	end
else
	begin
	print 'Nonexistent is procedure sp_adduser.'
	end

Go

if object_id('sp_altermessage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_altermessage ...'
	drop procedure sp_altermessage
	end
else
	begin
	print 'Nonexistent is procedure sp_altermessage.'
	end


if object_id('sp_articlecolumn','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_articlecolumn ...'
	drop procedure sp_articlecolumn
	end
else
	begin
	print 'Nonexistent is procedure sp_articlecolumn.'
	end


if object_id('sp_articlefilter','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_articlefilter ...'
	drop procedure sp_articlefilter
	end
else
	begin
	print 'Nonexistent is procedure sp_articlefilter.'
	end


if object_id('sp_articletextcol','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_articletextcol ...'
	drop procedure sp_articletextcol
	end
else
	begin
	print 'Nonexistent is procedure sp_articletextcol.'
	end


if object_id('sp_articleview','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_articleview ...'
	drop procedure sp_articleview
	end
else
	begin
	print 'Nonexistent is procedure sp_articleview.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_bindefault','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_bindefault ...'
	drop procedure sp_bindefault
	end
else
	begin
	print 'Nonexistent is procedure sp_bindefault.'
	end


if object_id('sp_bindrule','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_bindrule ...'
	drop procedure sp_bindrule
	end
else
	begin
	print 'Nonexistent is procedure sp_bindrule.'
	end


if object_id('sp_blockcnt','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_blockcnt ...'
	drop procedure sp_blockcnt
	end
else
	begin
	print 'Nonexistent is procedure sp_blockcnt.'
	end


if object_id('sp_certify_removable','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_certify_removable ...'
	drop procedure sp_certify_removable
	end
else
	begin
	print 'Nonexistent is procedure sp_certify_removable.'
	end


if object_id('sp_change_configstatus','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_change_configstatus ...'
	drop procedure sp_change_configstatus
	end
else
	begin
	print 'Nonexistent is procedure sp_change_configstatus.'
	end

Go

if object_id('sp_change_users_login','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_change_users_login ...'
	drop procedure sp_change_users_login
	end
else
	begin
	print 'Nonexistent is procedure sp_change_users_login.'
	end


if object_id('sp_changearticle','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changearticle ...'
	drop procedure sp_changearticle
	end
else
	begin
	print 'Nonexistent is procedure sp_changearticle.'
	end


if object_id('sp_changedbowner','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changedbowner ...'
	drop procedure sp_changedbowner
	end
else
	begin
	print 'Nonexistent is procedure sp_changedbowner.'
	end


if object_id('sp_changegroup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changegroup ...'
	drop procedure sp_changegroup
	end
else
	begin
	print 'Nonexistent is procedure sp_changegroup.'
	end


if object_id('sp_changepublication','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changepublication ...'
	drop procedure sp_changepublication
	end
else
	begin
	print 'Nonexistent is procedure sp_changepublication.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_changesubscriber','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changesubscriber ...'
	drop procedure sp_changesubscriber
	end
else
	begin
	print 'Nonexistent is procedure sp_changesubscriber.'
	end


if object_id('sp_changesubscription','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changesubscription ...'
	drop procedure sp_changesubscription
	end
else
	begin
	print 'Nonexistent is procedure sp_changesubscription.'
	end


if object_id('sp_changesubstatus','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_changesubstatus ...'
	drop procedure sp_changesubstatus
	end
else
	begin
	print 'Nonexistent is procedure sp_changesubstatus.'
	end


if object_id('sp_check_objects','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_check_objects ...'
	drop procedure sp_check_objects
	end
else
	begin
	print 'Nonexistent is procedure sp_check_objects.'
	end


if object_id('sp_check_removable','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_check_removable ...'
	drop procedure sp_check_removable
	end
else
	begin
	print 'Nonexistent is procedure sp_check_removable.'
	end

Go

if object_id('sp_checknames','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_checknames ...'
	drop procedure sp_checknames
	end
else
	begin
	print 'Nonexistent is procedure sp_checknames.'
	end


if object_id('sp_chklangparam','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_chklangparam ...'
	drop procedure sp_chklangparam
	end
else
	begin
	print 'Nonexistent is procedure sp_chklangparam.'
	end


if object_id('sp_coalesce_fragments','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_coalesce_fragments ...'
	drop procedure sp_coalesce_fragments
	end
else
	begin
	print 'Nonexistent is procedure sp_coalesce_fragments.'
	end


if object_id('sp_column_privileges','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_column_privileges ...'
	drop procedure sp_column_privileges
	end
else
	begin
	print 'Nonexistent is procedure sp_column_privileges.'
	end


if object_id('sp_columns','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_columns ...'
	drop procedure sp_columns
	end
else
	begin
	print 'Nonexistent is procedure sp_columns.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_commit_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_commit_xact ...'
	drop procedure sp_commit_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_commit_xact.'
	end


if object_id('sp_commonkey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_commonkey ...'
	drop procedure sp_commonkey
	end
else
	begin
	print 'Nonexistent is procedure sp_commonkey.'
	end


if object_id('sp_configure','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_configure ...'
	drop procedure sp_configure
	end
else
	begin
	print 'Nonexistent is procedure sp_configure.'
	end


if object_id('sp_create_distribution_tables','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_create_distribution_tables ...'
	drop procedure sp_create_distribution_tables
	end
else
	begin
	print 'Nonexistent is procedure sp_create_distribution_tables.'
	end


if object_id('sp_create_removable','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_create_removable ...'
	drop procedure sp_create_removable
	end
else
	begin
	print 'Nonexistent is procedure sp_create_removable.'
	end

Go

if object_id('sp_databases','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_databases ...'
	drop procedure sp_databases
	end
else
	begin
	print 'Nonexistent is procedure sp_databases.'
	end


if object_id('sp_datatype_info','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_datatype_info ...'
	drop procedure sp_datatype_info
	end
else
	begin
	print 'Nonexistent is procedure sp_datatype_info.'
	end


if object_id('sp_db_upgrade','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_db_upgrade ...'
	drop procedure sp_db_upgrade
	end
else
	begin
	print 'Nonexistent is procedure sp_db_upgrade.'
	end


if object_id('sp_db_upgrade1','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_db_upgrade1 ...'
	drop procedure sp_db_upgrade1
	end
else
	begin
	print 'Nonexistent is procedure sp_db_upgrade1.'
	end


if object_id('sp_db_upgrade2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_db_upgrade2 ...'
	drop procedure sp_db_upgrade2
	end
else
	begin
	print 'Nonexistent is procedure sp_db_upgrade2.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_dbinstall','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dbinstall ...'
	drop procedure sp_dbinstall
	end
else
	begin
	print 'Nonexistent is procedure sp_dbinstall.'
	end


if object_id('sp_dboption','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dboption ...'
	drop procedure sp_dboption
	end
else
	begin
	print 'Nonexistent is procedure sp_dboption.'
	end


if object_id('sp_dbremove','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dbremove ...'
	drop procedure sp_dbremove
	end
else
	begin
	print 'Nonexistent is procedure sp_dbremove.'
	end


if object_id('sp_ddopen','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_ddopen ...'
	drop procedure sp_ddopen
	end
else
	begin
	print 'Nonexistent is procedure sp_ddopen.'
	end


if object_id('sp_defaultdb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_defaultdb ...'
	drop procedure sp_defaultdb
	end
else
	begin
	print 'Nonexistent is procedure sp_defaultdb.'
	end

Go

if object_id('sp_defaultlanguage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_defaultlanguage ...'
	drop procedure sp_defaultlanguage
	end
else
	begin
	print 'Nonexistent is procedure sp_defaultlanguage.'
	end


if object_id('sp_depends','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_depends ...'
	drop procedure sp_depends
	end
else
	begin
	print 'Nonexistent is procedure sp_depends.'
	end


if object_id('sp_devcreate','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_devcreate ...'
	drop procedure sp_devcreate
	end
else
	begin
	print 'Nonexistent is procedure sp_devcreate.'
	end


if object_id('sp_devoption','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_devoption ...'
	drop procedure sp_devoption
	end
else
	begin
	print 'Nonexistent is procedure sp_devoption.'
	end


if object_id('sp_diskdefault','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_diskdefault ...'
	drop procedure sp_diskdefault
	end
else
	begin
	print 'Nonexistent is procedure sp_diskdefault.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_distcounters','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_distcounters ...'
	drop procedure sp_distcounters
	end
else
	begin
	print 'Nonexistent is procedure sp_distcounters.'
	end


if object_id('sp_dropalias','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropalias ...'
	drop procedure sp_dropalias
	end
else
	begin
	print 'Nonexistent is procedure sp_dropalias.'
	end


if object_id('sp_droparticle','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_droparticle ...'
	drop procedure sp_droparticle
	end
else
	begin
	print 'Nonexistent is procedure sp_droparticle.'
	end


if object_id('sp_dropdevice','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropdevice ...'
	drop procedure sp_dropdevice
	end
else
	begin
	print 'Nonexistent is procedure sp_dropdevice.'
	end


if object_id('sp_dropextendedproc','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropextendedproc ...'
	drop procedure sp_dropextendedproc
	end
else
	begin
	print 'Nonexistent is procedure sp_dropextendedproc.'
	end

Go

if object_id('sp_dropgroup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropgroup ...'
	drop procedure sp_dropgroup
	end
else
	begin
	print 'Nonexistent is procedure sp_dropgroup.'
	end


if object_id('sp_dropkey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropkey ...'
	drop procedure sp_dropkey
	end
else
	begin
	print 'Nonexistent is procedure sp_dropkey.'
	end


if object_id('sp_droplogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_droplogin ...'
	drop procedure sp_droplogin
	end
else
	begin
	print 'Nonexistent is procedure sp_droplogin.'
	end


if object_id('sp_dropmessage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropmessage ...'
	drop procedure sp_dropmessage
	end
else
	begin
	print 'Nonexistent is procedure sp_dropmessage.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_droppublication','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_droppublication ...'
	drop procedure sp_droppublication
	end
else
	begin
	print 'Nonexistent is procedure sp_droppublication.'
	end


if object_id('sp_droppublisher','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_droppublisher ...'
	drop procedure sp_droppublisher
	end
else
	begin
	print 'Nonexistent is procedure sp_droppublisher.'
	end


if object_id('sp_dropremotelogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropremotelogin ...'
	drop procedure sp_dropremotelogin
	end
else
	begin
	print 'Nonexistent is procedure sp_dropremotelogin.'
	end


if object_id('sp_dropsegment','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropsegment ...'
	drop procedure sp_dropsegment
	end
else
	begin
	print 'Nonexistent is procedure sp_dropsegment.'
	end


if object_id('sp_dropserver','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropserver ...'
	drop procedure sp_dropserver
	end
else
	begin
	print 'Nonexistent is procedure sp_dropserver.'
	end

Go

if object_id('sp_dropsubscriber','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropsubscriber ...'
	drop procedure sp_dropsubscriber
	end
else
	begin
	print 'Nonexistent is procedure sp_dropsubscriber.'
	end


if object_id('sp_dropsubscription','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropsubscription ...'
	drop procedure sp_dropsubscription
	end
else
	begin
	print 'Nonexistent is procedure sp_dropsubscription.'
	end


if object_id('sp_droptype','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_droptype ...'
	drop procedure sp_droptype
	end
else
	begin
	print 'Nonexistent is procedure sp_droptype.'
	end


if object_id('sp_dropuser','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropuser ...'
	drop procedure sp_dropuser
	end
else
	begin
	print 'Nonexistent is procedure sp_dropuser.'
	end


if object_id('sp_dsninfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dsninfo ...'
	drop procedure sp_dsninfo
	end
else
	begin
	print 'Nonexistent is procedure sp_dsninfo.'
	end

Go

if object_id('sp_enumdsn','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_enumdsn ...'
	drop procedure sp_enumdsn
	end
else
	begin
	print 'Nonexistent is procedure sp_enumdsn.'
	end


if object_id('sp_enumfullsubscribers','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_enumfullsubscribers ...'
	drop procedure sp_enumfullsubscribers
	end
else
	begin
	print 'Nonexistent is procedure sp_enumfullsubscribers.'
	end


if object_id('sp_extendsegment','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_extendsegment ...'
	drop procedure sp_extendsegment
	end
else
	begin
	print 'Nonexistent is procedure sp_extendsegment.'
	end


if object_id('sp_fixindex','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_fixindex ...'
	drop procedure sp_fixindex
	end
else
	begin
	print 'Nonexistent is procedure sp_fixindex.'
	end


if object_id('sp_fkeys','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_fkeys ...'
	drop procedure sp_fkeys
	end
else
	begin
	print 'Nonexistent is procedure sp_fkeys.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_foreignkey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_foreignkey ...'
	drop procedure sp_foreignkey
	end
else
	begin
	print 'Nonexistent is procedure sp_foreignkey.'
	end


if object_id('sp_get_volume_label','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_get_volume_label ...'
	drop procedure sp_get_volume_label
	end
else
	begin
	print 'Nonexistent is procedure sp_get_volume_label.'
	end


if object_id('sp_hcchangesubstatus1','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_hcchangesubstatus1 ...'
	drop procedure sp_hcchangesubstatus1
	end
else
	begin
	print 'Nonexistent is procedure sp_hcchangesubstatus1.'
	end


if object_id('sp_hcchangesubstatus2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_hcchangesubstatus2 ...'
	drop procedure sp_hcchangesubstatus2
	end
else
	begin
	print 'Nonexistent is procedure sp_hcchangesubstatus2.'
	end


if object_id('sp_help','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_help ...'
	drop procedure sp_help
	end
else
	begin
	print 'Nonexistent is procedure sp_help.'
	end

Go

if object_id('sp_help_revdatabase','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_help_revdatabase ...'
	drop procedure sp_help_revdatabase
	end
else
	begin
	print 'Nonexistent is procedure sp_help_revdatabase.'
	end


if object_id('sp_help_setopts','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_help_setopts ...'
	drop procedure sp_help_setopts
	end
else
	begin
	print 'Nonexistent is procedure sp_help_setopts.'
	end


if object_id('sp_helparticle','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helparticle ...'
	drop procedure sp_helparticle
	end
else
	begin
	print 'Nonexistent is procedure sp_helparticle.'
	end


if object_id('sp_helparticlecolumns','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helparticlecolumns ...'
	drop procedure sp_helparticlecolumns
	end
else
	begin
	print 'Nonexistent is procedure sp_helparticlecolumns.'
	end


if object_id('sp_helpconstraint','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpconstraint ...'
	drop procedure sp_helpconstraint
	end
else
	begin
	print 'Nonexistent is procedure sp_helpconstraint.'
	end

Go

if object_id('sp_helpdb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpdb ...'
	drop procedure sp_helpdb
	end
else
	begin
	print 'Nonexistent is procedure sp_helpdb.'
	end


if object_id('sp_helpdevice','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpdevice ...'
	drop procedure sp_helpdevice
	end
else
	begin
	print 'Nonexistent is procedure sp_helpdevice.'
	end


if object_id('sp_helpdistributor','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpdistributor ...'
	drop procedure sp_helpdistributor
	end
else
	begin
	print 'Nonexistent is procedure sp_helpdistributor.'
	end


if object_id('sp_helpextendedproc','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpextendedproc ...'
	drop procedure sp_helpextendedproc
	end
else
	begin
	print 'Nonexistent is procedure sp_helpextendedproc.'
	end


if object_id('sp_helpgroup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpgroup ...'
	drop procedure sp_helpgroup
	end
else
	begin
	print 'Nonexistent is procedure sp_helpgroup.'
	end

Go

if object_id('sp_helpindex','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpindex ...'
	drop procedure sp_helpindex
	end
else
	begin
	print 'Nonexistent is procedure sp_helpindex.'
	end

if object_id('sp_helpstats','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpstats ...'
	drop procedure sp_helpstats
	end
else
	begin
	print 'Nonexistent is procedure sp_helpstats.'
	end

if object_id('sp_helpjoins','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpjoins ...'
	drop procedure sp_helpjoins
	end
else
	begin
	print 'Nonexistent is procedure sp_helpjoins.'
	end


if object_id('sp_helpkey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpkey ...'
	drop procedure sp_helpkey
	end
else
	begin
	print 'Nonexistent is procedure sp_helpkey.'
	end


if object_id('sp_helplanguage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helplanguage ...'
	drop procedure sp_helplanguage
	end
else
	begin
	print 'Nonexistent is procedure sp_helplanguage.'
	end


if object_id('sp_helplog','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helplog ...'
	drop procedure sp_helplog
	end
else
	begin
	print 'Nonexistent is procedure sp_helplog.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_helplogins','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helplogins ...'
	drop procedure sp_helplogins
	end
else
	begin
	print 'Nonexistent is procedure sp_helplogins.'
	end


if object_id('sp_helppublication','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helppublication ...'
	drop procedure sp_helppublication
	end
else
	begin
	print 'Nonexistent is procedure sp_helppublication.'
	end


if object_id('sp_helppublicationsync','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helppublicationsync ...'
	drop procedure sp_helppublicationsync
	end
else
	begin
	print 'Nonexistent is procedure sp_helppublicationsync.'
	end


if object_id('sp_helpremotelogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpremotelogin ...'
	drop procedure sp_helpremotelogin
	end
else
	begin
	print 'Nonexistent is procedure sp_helpremotelogin.'
	end


if object_id('sp_helpreplicationdb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpreplicationdb ...'
	drop procedure sp_helpreplicationdb
	end
else
	begin
	print 'Nonexistent is procedure sp_helpreplicationdb.'
	end

Go

if object_id('sp_helprotect','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helprotect ...'
	drop procedure sp_helprotect
	end
else
	begin
	print 'Nonexistent is procedure sp_helprotect.'
	end


if object_id('sp_helpsegment','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpsegment ...'
	drop procedure sp_helpsegment
	end
else
	begin
	print 'Nonexistent is procedure sp_helpsegment.'
	end


if object_id('sp_helpserver','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpserver ...'
	drop procedure sp_helpserver
	end
else
	begin
	print 'Nonexistent is procedure sp_helpserver.'
	end


if object_id('sp_helpsort','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpsort ...'
	drop procedure sp_helpsort
	end
else
	begin
	print 'Nonexistent is procedure sp_helpsort.'
	end


Print 'Bypassing procedure sp_helpsql.'
Go

if object_id('sp_helpstartup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpstartup ...'
	drop procedure sp_helpstartup
	end
else
	begin
	print 'Nonexistent is procedure sp_helpstartup.'
	end


if object_id('sp_helpsubscriberinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpsubscriberinfo ...'
	drop procedure sp_helpsubscriberinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_helpsubscriberinfo.'
	end


if object_id('sp_helpsubscription','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpsubscription ...'
	drop procedure sp_helpsubscription
	end
else
	begin
	print 'Nonexistent is procedure sp_helpsubscription.'
	end


if object_id('sp_helptext','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helptext ...'
	drop procedure sp_helptext
	end
else
	begin
	print 'Nonexistent is procedure sp_helptext.'
	end


if object_id('sp_helpuser','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_helpuser ...'
	drop procedure sp_helpuser
	end
else
	begin
	print 'Nonexistent is procedure sp_helpuser.'
	end

Go

if object_id('sp_lock','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_lock ...'
	drop procedure sp_lock
	end
else
	begin
	print 'Nonexistent is procedure sp_lock.'
	end


if object_id('sp_lock2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_lock2 ...'
	drop procedure sp_lock2
	end
else
	begin
	print 'Nonexistent is procedure sp_lock2.'
	end


if object_id('sp_lockinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_lockinfo ...'
	drop procedure sp_lockinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_lockinfo.'
	end


if object_id('sp_logdevice','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_logdevice ...'
	drop procedure sp_logdevice
	end
else
	begin
	print 'Nonexistent is procedure sp_logdevice.'
	end


if object_id('sp_lookup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_lookup ...'
	drop procedure sp_lookup
	end
else
	begin
	print 'Nonexistent is procedure sp_lookup.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_makestartup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_makestartup ...'
	drop procedure sp_makestartup
	end
else
	begin
	print 'Nonexistent is procedure sp_makestartup.'
	end


if object_id('sp_makewebpage','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_makewebpage ...'
	drop procedure sp_makewebpage
	end
else
	begin
	print 'Nonexistent is procedure sp_makewebpage.'
	end


if object_id('sp_markreport','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_markreport ...'
	drop procedure sp_markreport
	end
else
	begin
	print 'Nonexistent is procedure sp_markreport.'
	end


if object_id('sp_monitor','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_monitor ...'
	drop procedure sp_monitor
	end
else
	begin
	print 'Nonexistent is procedure sp_monitor.'
	end


if object_id('sp_MSdbuserprofile','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSdbuserprofile ...'
	drop procedure sp_MSdbuserprofile
	end
else
	begin
	print 'Nonexistent is procedure sp_MSdbuserprofile.'
	end

Go

if object_id('sp_MSdependencies','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSdependencies ...'
	drop procedure sp_MSdependencies
	end
else
	begin
	print 'Nonexistent is procedure sp_MSdependencies.'
	end


if object_id('sp_MSfilterclause','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSfilterclause ...'
	drop procedure sp_MSfilterclause
	end
else
	begin
	print 'Nonexistent is procedure sp_MSfilterclause.'
	end


if object_id('sp_MSforeach_worker','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSforeach_worker ...'
	drop procedure sp_MSforeach_worker
	end
else
	begin
	print 'Nonexistent is procedure sp_MSforeach_worker.'
	end


if object_id('sp_MSforeachdb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSforeachdb ...'
	drop procedure sp_MSforeachdb
	end
else
	begin
	print 'Nonexistent is procedure sp_MSforeachdb.'
	end


if object_id('sp_MSforeachtable','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSforeachtable ...'
	drop procedure sp_MSforeachtable
	end
else
	begin
	print 'Nonexistent is procedure sp_MSforeachtable.'
	end

Go

if object_id('sp_MSgetalertinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSgetalertinfo ...'
	drop procedure sp_MSgetalertinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_MSgetalertinfo.'
	end

if object_id('sp_MSget_current_activity','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSget_current_activity ...'
	drop procedure sp_MSget_current_activity
	end
else
	begin
	print 'Nonexistent is procedure sp_MSget_current_activity.'
	end

if object_id('sp_MSgetexecinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSgetexecinfo ...'
	drop procedure sp_MSgetexecinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_MSgetexecinfo.'
	end


if object_id('sp_MShelpcolumns','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MShelpcolumns ...'
	drop procedure sp_MShelpcolumns
	end
else
	begin
	print 'Nonexistent is procedure sp_MShelpcolumns.'
	end


if object_id('sp_MShelpindex','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MShelpindex ...'
	drop procedure sp_MShelpindex
	end
else
	begin
	print 'Nonexistent is procedure sp_MShelpindex.'
	end


if object_id('sp_MShelptype','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MShelptype ...'
	drop procedure sp_MShelptype
	end
else
	begin
	print 'Nonexistent is procedure sp_MShelptype.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_MSindexspace','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSindexspace ...'
	drop procedure sp_MSindexspace
	end
else
	begin
	print 'Nonexistent is procedure sp_MSindexspace.'
	end


if object_id('sp_MSkilldb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSkilldb ...'
	drop procedure sp_MSkilldb
	end
else
	begin
	print 'Nonexistent is procedure sp_MSkilldb.'
	end


if object_id('sp_MSloginmappings','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSloginmappings ...'
	drop procedure sp_MSloginmappings
	end
else
	begin
	print 'Nonexistent is procedure sp_MSloginmappings.'
	end


if object_id('sp_MSmatchkey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSmatchkey ...'
	drop procedure sp_MSmatchkey
	end
else
	begin
	print 'Nonexistent is procedure sp_MSmatchkey.'
	end


if object_id('sp_MSobjectprivs','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSobjectprivs ...'
	drop procedure sp_MSobjectprivs
	end
else
	begin
	print 'Nonexistent is procedure sp_MSobjectprivs.'
	end

Go

if object_id('sp_MSsetalertinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSsetalertinfo ...'
	drop procedure sp_MSsetalertinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_MSsetalertinfo.'
	end

if object_id('sp_MSset_current_activity','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSset_current_activity ...'
	drop procedure sp_MSset_current_activity
	end
else
	begin
	print 'Nonexistent is procedure sp_MSset_current_activity.'
	end

if object_id('sp_MSsetexecinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSsetexecinfo ...'
	drop procedure sp_MSsetexecinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_MSsetexecinfo.'
	end


if object_id('sp_MSsettopology','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSsettopology ...'
	drop procedure sp_MSsettopology
	end
else
	begin
	print 'Nonexistent is procedure sp_MSsettopology.'
	end


if object_id('sp_MSSQLOLE_version','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSSQLOLE_version ...'
	drop procedure sp_MSSQLOLE_version
	end
else
	begin
	print 'Nonexistent is procedure sp_MSSQLOLE_version.'
	end


if object_id('sp_MSsubscriptions','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSsubscriptions ...'
	drop procedure sp_MSsubscriptions
	end
else
	begin
	print 'Nonexistent is procedure sp_MSsubscriptions.'
	end

Go

if object_id('sp_MStablechecks','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MStablechecks ...'
	drop procedure sp_MStablechecks
	end
else
	begin
	print 'Nonexistent is procedure sp_MStablechecks.'
	end


if object_id('sp_MStablekeys','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MStablekeys ...'
	drop procedure sp_MStablekeys
	end
else
	begin
	print 'Nonexistent is procedure sp_MStablekeys.'
	end


if object_id('sp_MStablerefs','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MStablerefs ...'
	drop procedure sp_MStablerefs
	end
else
	begin
	print 'Nonexistent is procedure sp_MStablerefs.'
	end


if object_id('sp_MStablespace','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MStablespace ...'
	drop procedure sp_MStablespace
	end
else
	begin
	print 'Nonexistent is procedure sp_MStablespace.'
	end


if object_id('sp_MSuniquename','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSuniquename ...'
	drop procedure sp_MSuniquename
	end
else
	begin
	print 'Nonexistent is procedure sp_MSuniquename.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_namecrack','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_namecrack ...'
	drop procedure sp_namecrack
	end
else
	begin
	print 'Nonexistent is procedure sp_namecrack.'
	end


if object_id('sp_objcheck','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_objcheck ...'
	drop procedure sp_objcheck
	end
else
	begin
	print 'Nonexistent is procedure sp_objcheck.'
	end


if object_id('sp_objectsegment','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_objectsegment ...'
	drop procedure sp_objectsegment
	end
else
	begin
	print 'Nonexistent is procedure sp_objectsegment.'
	end


if object_id('sp_password','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_password ...'
	drop procedure sp_password
	end
else
	begin
	print 'Nonexistent is procedure sp_password.'
	end


if object_id('sp_pkeys','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_pkeys ...'
	drop procedure sp_pkeys
	end
else
	begin
	print 'Nonexistent is procedure sp_pkeys.'
	end

Go

if object_id('sp_placeobject','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_placeobject ...'
	drop procedure sp_placeobject
	end
else
	begin
	print 'Nonexistent is procedure sp_placeobject.'
	end


if object_id('sp_primarykey','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_primarykey ...'
	drop procedure sp_primarykey
	end
else
	begin
	print 'Nonexistent is procedure sp_primarykey.'
	end


if object_id('sp_probe_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_probe_xact ...'
	drop procedure sp_probe_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_probe_xact.'
	end


if object_id('sp_processinfo','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_processinfo ...'
	drop procedure sp_processinfo
	end
else
	begin
	print 'Nonexistent is procedure sp_processinfo.'
	end


if object_id('sp_processmail','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_processmail ...'
	drop procedure sp_processmail
	end
else
	begin
	print 'Nonexistent is procedure sp_processmail.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_publishdb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_publishdb ...'
	drop procedure sp_publishdb
	end
else
	begin
	print 'Nonexistent is procedure sp_publishdb.'
	end


if object_id('sp_recompile','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_recompile ...'
	drop procedure sp_recompile
	end
else
	begin
	print 'Nonexistent is procedure sp_recompile.'
	end


if object_id('sp_remoteoption','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_remoteoption ...'
	drop procedure sp_remoteoption
	end
else
	begin
	print 'Nonexistent is procedure sp_remoteoption.'
	end


if object_id('sp_remove_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_remove_xact ...'
	drop procedure sp_remove_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_remove_xact.'
	end


if object_id('sp_rename','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_rename ...'
	drop procedure sp_rename
	end
else
	begin
	print 'Nonexistent is procedure sp_rename.'
	end

Go

if object_id('sp_renamedb','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_renamedb ...'
	drop procedure sp_renamedb
	end
else
	begin
	print 'Nonexistent is procedure sp_renamedb.'
	end


if object_id('sp_replica','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_replica ...'
	drop procedure sp_replica
	end
else
	begin
	print 'Nonexistent is procedure sp_replica.'
	end

if object_id('sp_scan_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_scan_xact ...'
	drop procedure sp_scan_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_scan_xact.'
	end


if object_id('sp_schedulersignal','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_schedulersignal ...'
	drop procedure sp_schedulersignal
	end
else
	begin
	print 'Nonexistent is procedure sp_schedulersignal.'
	end

Go

if object_id('sp_seguse','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_seguse ...'
	drop procedure sp_seguse
	end
else
	begin
	print 'Nonexistent is procedure sp_seguse.'
	end


if object_id('sp_server_info','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_server_info ...'
	drop procedure sp_server_info
	end
else
	begin
	print 'Nonexistent is procedure sp_server_info.'
	end


if object_id('sp_serveroption','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_serveroption ...'
	drop procedure sp_serveroption
	end
else
	begin
	print 'Nonexistent is procedure sp_serveroption.'
	end


if object_id('sp_setlangalias','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_setlangalias ...'
	drop procedure sp_setlangalias
	end
else
	begin
	print 'Nonexistent is procedure sp_setlangalias.'
	end


if object_id('sp_setnetname','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_setnetname ...'
	drop procedure sp_setnetname
	end
else
	begin
	print 'Nonexistent is procedure sp_setnetname.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_spaceused','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_spaceused ...'
	drop procedure sp_spaceused
	end
else
	begin
	print 'Nonexistent is procedure sp_spaceused.'
	end

if object_id('sp_checktabletempsize','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_checktabletempsize ...'
	drop procedure sp_checktabletempsize
	end
else
	begin
	print 'Nonexistent is procedure sp_checktabletempsize.'
	end

if object_id('sp_checkdbtempsize','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_checkdbtempsize ...'
	drop procedure sp_checkdbtempsize
	end
else
	begin
	print 'Nonexistent is procedure sp_checkdbtempsize.'
	end

if object_id('sp_special_columns','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_special_columns ...'
	drop procedure sp_special_columns
	end
else
	begin
	print 'Nonexistent is procedure sp_special_columns.'
	end


if object_id('sp_sproc_columns','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_sproc_columns ...'
	drop procedure sp_sproc_columns
	end
else
	begin
	print 'Nonexistent is procedure sp_sproc_columns.'
	end


if object_id('sp_sqlexec','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_sqlexec ...'
	drop procedure sp_sqlexec
	end
else
	begin
	print 'Nonexistent is procedure sp_sqlexec.'
	end


if object_id('sp_sqlregister','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_sqlregister ...'
	drop procedure sp_sqlregister
	end
else
	begin
	print 'Nonexistent is procedure sp_sqlregister.'
	end

Go

if object_id('sp_start_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_start_xact ...'
	drop procedure sp_start_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_start_xact.'
	end


if object_id('sp_stat_xact','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_stat_xact ...'
	drop procedure sp_stat_xact
	end
else
	begin
	print 'Nonexistent is procedure sp_stat_xact.'
	end


if object_id('sp_statistics','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_statistics ...'
	drop procedure sp_statistics
	end
else
	begin
	print 'Nonexistent is procedure sp_statistics.'
	end


if object_id('sp_stored_procedures','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_stored_procedures ...'
	drop procedure sp_stored_procedures
	end
else
	begin
	print 'Nonexistent is procedure sp_stored_procedures.'
	end


if object_id('sp_subscribe','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_subscribe ...'
	drop procedure sp_subscribe
	end
else
	begin
	print 'Nonexistent is procedure sp_subscribe.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_table_privileges','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_table_privileges ...'
	drop procedure sp_table_privileges
	end
else
	begin
	print 'Nonexistent is procedure sp_table_privileges.'
	end


if object_id('sp_tables','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_tables ...'
	drop procedure sp_tables
	end
else
	begin
	print 'Nonexistent is procedure sp_tables.'
	end


if object_id('sp_tempdbspace','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_tempdbspace ...'
	drop procedure sp_tempdbspace
	end
else
	begin
	print 'Nonexistent is procedure sp_tempdbspace.'
	end


if object_id('sp_textcolstatus','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_textcolstatus ...'
	drop procedure sp_textcolstatus
	end
else
	begin
	print 'Nonexistent is procedure sp_textcolstatus.'
	end


if object_id('sp_tphelp','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_tphelp ...'
	drop procedure sp_tphelp
	end
else
	begin
	print 'Nonexistent is procedure sp_tphelp.'
	end

Go

if object_id('sp_tphelp2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_tphelp2 ...'
	drop procedure sp_tphelp2
	end
else
	begin
	print 'Nonexistent is procedure sp_tphelp2.'
	end


if object_id('sp_unbindefault','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_unbindefault ...'
	drop procedure sp_unbindefault
	end
else
	begin
	print 'Nonexistent is procedure sp_unbindefault.'
	end


if object_id('sp_MSuninstall_publishing','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_MSuninstall_publishing ...'
	drop procedure sp_MSuninstall_publishing
	end
else
	begin
	print 'Nonexistent is procedure sp_MSuninstall_publishing.'
	end


if object_id('sp_unbindrule','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_unbindrule ...'
	drop procedure sp_unbindrule
	end
else
	begin
	print 'Nonexistent is procedure sp_unbindrule.'
	end


if object_id('sp_unmakestartup','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_unmakestartup ...'
	drop procedure sp_unmakestartup
	end
else
	begin
	print 'Nonexistent is procedure sp_unmakestartup.'
	end


if object_id('sp_unsubscribe','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_unsubscribe ...'
	drop procedure sp_unsubscribe
	end
else
	begin
	print 'Nonexistent is procedure sp_unsubscribe.'
	end

Go

if object_id('sp_user_counter1','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter1 ...'
	drop procedure sp_user_counter1
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter1.'
	end


if object_id('sp_user_counter10','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter10 ...'
	drop procedure sp_user_counter10
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter10.'
	end


if object_id('sp_user_counter2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter2 ...'
	drop procedure sp_user_counter2
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter2.'
	end


if object_id('sp_user_counter3','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter3 ...'
	drop procedure sp_user_counter3
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter3.'
	end


if object_id('sp_user_counter4','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter4 ...'
	drop procedure sp_user_counter4
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter4.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('sp_user_counter5','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter5 ...'
	drop procedure sp_user_counter5
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter5.'
	end


if object_id('sp_user_counter6','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter6 ...'
	drop procedure sp_user_counter6
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter6.'
	end


if object_id('sp_user_counter7','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter7 ...'
	drop procedure sp_user_counter7
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter7.'
	end


if object_id('sp_user_counter8','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter8 ...'
	drop procedure sp_user_counter8
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter8.'
	end


if object_id('sp_user_counter9','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_user_counter9 ...'
	drop procedure sp_user_counter9
	end
else
	begin
	print 'Nonexistent is procedure sp_user_counter9.'
	end

Go

if object_id('sp_userdefcounters','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_userdefcounters ...'
	drop procedure sp_userdefcounters
	end
else
	begin
	print 'Nonexistent is procedure sp_userdefcounters.'
	end


if object_id('sp_validlang','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_validlang ...'
	drop procedure sp_validlang
	end
else
	begin
	print 'Nonexistent is procedure sp_validlang.'
	end


if object_id('sp_validname','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_validname ...'
	drop procedure sp_validname
	end
else
	begin
	print 'Nonexistent is procedure sp_validname.'
	end


if object_id('sp_who','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_who ...b'
	drop procedure sp_who
	end
else
	begin
	print 'Nonexistent is procedure sp_who.'
	end


if object_id('sp_who2','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_who2 ...'
	drop procedure sp_who2
	end
else
	begin
	print 'Nonexistent is procedure sp_who2.'
	end

Go

if object_id('sp_xpoption','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_xpoption ...'
	drop procedure sp_xpoption
	end
else
	begin
	print 'Nonexistent is procedure sp_xpoption.'
	end


Print 'Bypassing table helpsql.'


if object_id('MSobjects','U') IS NOT NULL
	begin
	print 'Dropping table MSobjects ...'
	drop table MSobjects
	end
else
	begin
	print 'Nonexistent is table MSobjects.'
	end


Go


if object_id('spt_datatype_info','U') IS NOT NULL
	begin
	print 'Dropping table spt_datatype_info ...'
	drop table spt_datatype_info
	end
else
	begin
	print 'Nonexistent is table spt_datatype_info.'
	end


if object_id('spt_datatype_info_ext','U') IS NOT NULL
	begin
	print 'Dropping table spt_datatype_info_ext ...'
	drop table spt_datatype_info_ext
	end
else
	begin
	print 'Nonexistent is table spt_datatype_info_ext.'
	end


if object_id('spt_monitor','U') IS NOT NULL
	begin
	print 'Dropping table spt_monitor ...'
	drop table spt_monitor
	end
else
	begin
	print 'Nonexistent is table spt_monitor.'
	end


if object_id('spt_server_info','U') IS NOT NULL
	begin
	print 'Dropping table spt_server_info ...'
	drop table spt_server_info
	end
else
	begin
	print 'Nonexistent is table spt_server_info.'
	end

Go

Dump Transaction master with no_log
Go

if object_id('spt_values','U') IS NOT NULL
	begin
	print 'Dropping table spt_values ...'
	drop table spt_values
	end
else
	begin
	print 'Nonexistent is table spt_values.'
	end

if object_id('sp_grantdenylogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_grantdenylogin ...'
	drop procedure sp_grantdenylogin
	end
else
	begin
	print 'Nonexistent is procedure sp_grantdenylogin.'
	end

if object_id('sp_grantlogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_grantlogin ...'
	drop procedure sp_grantlogin
	end
else
	begin
	print 'Nonexistent is procedure sp_grantlogin.'
	end

if object_id('sp_denylogin','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_denylogin ...'
	drop procedure sp_denylogin
	end
else
	begin
	print 'Nonexistent is procedure sp_denylogin.'
	end

if object_id('sp_addgroupmember','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_addgroupmember ...'
	drop procedure sp_addgroupmember
	end
else
	begin
	print 'Nonexistent is procedure sp_addgroupmember.'
	end

if object_id('sp_dropgroupmember','P') IS NOT NULL
	begin
	print 'Dropping procedure sp_dropgroupmember ...'
	drop procedure sp_dropgroupmember
	end
else
	begin
	print 'Nonexistent is procedure sp_dropgroupmember.'
	end

Go
set nocount off
Go

Print 'Procedures & User Tables still present:'

Select type,name from sysobjects
   where type in ('P ','TR','U ','V ','X ')
   and   ObjectProperty(id, 'IsMSShipped') = 1
   order by type,name
Go
set nocount on
Go

use master
Go

Dump Transaction master with no_log
Go
Checkpoint
Go

print 'End of file.'
GO
-- - ----- EndOfFile

