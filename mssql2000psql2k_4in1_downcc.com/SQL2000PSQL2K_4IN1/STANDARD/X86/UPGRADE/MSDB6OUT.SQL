/**********************************************************************/
/* MSDB6OUT.SQL                                                       */
/*                                                                    */
/* The output of this script (which should be run on the 6.x server)  */
/* is a SQL script to be run against the 7.0 server.                  */
/* The purpose of the generated script is to create a table in 7.0    */
/* msdb that contains a mapping between the 6.x suid (which will have */
/* changed in 7.0) and the login name (which will have remained the   */
/* same).  This information is necessary to accurately convert the    */
/* systasks.ownerloginid to a 7.0 sid.                                */
/*                                                                    */
/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/
/**********************************************************************/

