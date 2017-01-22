#!/usr/bin/env bash

# script:       collect_exec.sh - version 4.00
# description:  collect information about system, software and hardware.
# author:       Diego R. Santos <kdiegorsantos@gmail.com>

# check if user is root.
[ $EUID -ne 0 ] && exit 1

# IMPORTANT: global collect directory on local server for all systems.
collect_path="/var/tmp/collect/$(date +"%d%m%Y")";

# function to run on platform Red Hat Linux only.
sys_linux () {

# Source function library.
. /etc/init.d/functions

# checks if collect directory exists and delete old jobs, if not exists create it. delete collect tar files too.
[ -d /var/tmp/collect ] && find /var/tmp/collect -maxdepth 1 -type d ! -name collect -exec rm -rf '{}' \;
[ -d /var/tmp/collect ] && find /var/tmp/collect -maxdepth 1 -type f -exec rm -rf '{}' \;
[ ! -d ${collect_path} ] && mkdir -p ${collect_path}

# identify current release.
[ -f /usr/bin/lsb_release ] && lsb_release -a > ${collect_path}/redhat-release.txt || cat /etc/redhat-release > ${collect_path}/redhat_release.txt

# get the output of native and third party commands.
if [ ! -d ${collect_path}/files/ ] ; then
        mkdir -p ${collect_path}/files/{boot,proc}
        cp -r /etc/{rc.d,bashrc,collectd.conf,cron.deny,crontab,dracut.conf,exports,filesystems,fstab,group,gshadow,host.conf,hosts,hosts.allow,hosts.deny,idmapd.conf,inittab,kdump.conf,krb5.conf,lftp.conf,localtime,login.defs,logrotate.conf,lsb-release,motd,mtab,my.cnf,networks,nsswitch.conf,ntp.conf,numad.conf,passwd,php.ini,profile,protocols,quotatab,redhat-release,resolv.conf,rsyslog.conf,services,shadow,shells,sos.conf,sudoers,sysctl.conf,yum.conf,zabbix_agent.conf,zabbix_agentd.conf,zabbix_server.conf,server_id.cfg,sudoers.d,ssh/sshd_config,lvm,modprobe.conf,modprobe.d,sysconfig,security,udev,postfix/main.cf} ${collect_path}/files
        cp -r /proc/{net,cpuinfo,loadavg,meminfo,net/dev,partitions,pci,stat,uptime,version,cmdline,mounts} ${collect_path}/files/proc
        ls /boot/ | egrep $(uname -r) | while read -r line ; do cp -r /boot/$line ${collect_path}/files/boot ; done
fi

alternatives --display java > ${collect_path}/java.txt
chkconfig --list > ${collect_path}/chkconfig.txt
arp -a > ${collect_path}/arp_a.txt
crontab -l > ${collect_path}/crontab.txt
date > ${collect_path}/date.txt
df -alP > ${collect_path}/df_alP.txt
df -iP > ${collect_path}/df_i.txt
df -kP > ${collect_path}/df_k.txt
df -hP > ${collect_path}/df_h.txt
dmesg > ${collect_path}/dmesg.txt
dmidecode > ${collect_path}/dmidecode.txt
dmsetup info -c > ${collect_path}/dmsetup_info.txt
dmsetup ls --tree > ${collect_path}/dmsetup_ls.txt
dmsetup status > ${collect_path}/dmsetup_status.txt
dmsetup table > ${collect_path}/dmsetup_table.txt
exportfs -v > ${collect_path}/exportfs_v.txt
fdisk -l > ${collect_path}/fdisk.txt
free > ${collect_path}/free.txt
getconf LONG_BIT > ${collect_path}/getconf_long_bit.txt
getconf PAGE_SIZE > ${collect_path}/getconf_page_size.txt
hostid > ${collect_path}/hostid.txt
hostname --fqdn > ${collect_path}/hostname.txt
ifconfig -a > ${collect_path}/ifconfig.txt
ifenslave -a > ${collect_path}/ifenslave_a.txt
ip address > ${collect_path}/ip_address.txt
ip link > ${collect_path}/ip_link.txt
ip maddr show > ${collect_path}/ip_maddr_show.txt
ip mroute show > ${collect_path}/ip_mroute_show.txt
ip neigh show > ${collect_path}/ip_neigh_show.txt
ip route show table all > ${collect_path}/ip_route_show_table_all.txt
ip -s link show > ${collect_path}/ip_link_show.txt
ipcs -a > ${collect_path}/ipcs_a.txt
last boot > ${collect_path}/last_boot.txt
lsblk > ${collect_path}/lsblk.txt
lsmod > ${collect_path}/lsmod.txt
lsof -b +M -n -l > ${collect_path}/lsof_bMnl.txt
lspci > ${collect_path}/lspci.txt
lspci -v > ${collect_path}/lspci_v.txt
lvmdiskscan > ${collect_path}/lvmdiskscan.txt
lvm dumpconfig > ${collect_path}/lvm_dumpconfig.txt
lvm version > ${collect_path}/lvm_version.txt
lvs -a -o +devices --config="global{locking_type=0}" > ${collect_path}/lvs.txt
lvs --segments --config="global{locking_type=0}" > ${collect_path}/lvs_segments.txt
multipath -v4 -ll > ${collect_path}/multipath.txt
netstat -agn > ${collect_path}/netstat_agn.txt
netstat -antpl > ${collect_path}/netstat_antpl.txt
netstat -anupl > ${collect_path}/netstat_anupl.txt
netstat -neopa > ${collect_path}/netstat_neopa.txt
netstat -nr > ${collect_path}/netstat_nr.txt
netstat -s > ${collect_path}/netstat_s.txt
nfsstat -a > ${collect_path}/nfsstat.txt
ntpstat > ${collect_path}/ntpstat.txt
ps alxwww > ${collect_path}/ps_alxwww.txt
ps auxwwwm > ${collect_path}/ps_auxwwwm.txt
pstree > ${collect_path}/pstree.txt
pvs -a -v --config="global{locking_type=0}" > ${collect_path}/pvs.txt
pvscan -v --config="global{locking_type=0}" > ${collect_path}/pvscan.txt
readlink -f /usr/bin/java > ${collect_path}/java_version.txt
rhncfg-client channels > ${collect_path}/rhncfg-client_channels.txt
route -n > ${collect_path}/route.txt
rpcinfo -p localhost > ${collect_path}/rpcinfo_p_localhost.txt
rpm -qa > ${collect_path}/rpm_qa.txt
rpm -qai > ${collect_path}/rpm_qai.txt
runlevel > ${collect_path}/runlevel.txt
showmount -e localhost > ${collect_path}/showmount.txt
swapon -s > ${collect_path}/swapon.txt
udevadm info -e ${collect_path}/udevadm_info_e.txt
ulimit -a > ${collect_path}/ulimit.txt
uname -a > ${collect_path}/uname.txt
vgdisplay -vv --config="global{locking_type=0}" > ${collect_path}/vgdisplay.txt
vgscan -vvv --config="global{locking_type=0}" > ${collect_path}/vgscan.txt
vgs -v --config="global{locking_type=0}" > ${collect_path}/vgs.txt
yum -C repolist > ${collect_path}/yum_repolist.txt

# collect information about boot disk
[ -x /usr/local/sbin/boot_device.sh ] && /usr/local/sbin/boot_device.sh > ${collect_path}/boot_device.txt

# generate hadouken json file.
[ -x /usr/local/sbin/hadouken.py ] && /usr/local/sbin/hadouken.py

# get LUN information.
if [ -x /usr/local/sbin/inq ] ; then
  /usr/local/sbin/inq -no_dots > ${collect_path}/inq.txt
  /usr/local/sbin/inq -no_dots -wwn > ${collect_path}/inq_wwn.txt
fi

if [ -x /usr/bin/lsscsi ] ; then
  lsscsi > ${collect_path}/lsscsi.txt
fi

# get FC information.
if [ -x /usr/bin/systool ] ; then
  systool -v -c fc_host > ${collect_path}/systool_vc_fc_host.txt
else
  for a in $(ls /sys/class/fc_host/host) ; do
    cat $a/port_name >> ${collect_path}/fc_port_name.txt
  done
fi

# get EMC PowerPath information.
if [ -x /sbin/powermt ] ; then
  powermt check_registration > ${collect_path}/powermt_registration.txt
  powermt version > ${collect_path}/powermt_version.txt
  powermt display ports > ${collect_path}/powermt_display_ports.txt
  powermt display options > ${collect_path}/powermt_display_options.txt
  powermt display unmanaged > ${collect_path}/powermt_display_unmanaged.txt
  powermt display paths > ${collect_path}/powermt_display_paths.txt
  powermt display dev\=all > ${collect_path}/powermt_display_dev_all.txt
  powermt display alua dev\=all > ${collect_path}/powermt_display_alua_dev_all.txt
  powermt display options > ${collect_path}/powermt_display_options.txt
  powermt display hba_mode > ${collect_path}/powermt_display_hba_mode.txt
  powermt display port_mode > ${collect_path}/powermt_display_port_mode.txt
  powermt save file=${collect_path}/powermt_save.txt
  emcpreg -list > ${collect_path}/emcpreg.txt
fi

# get information about Oracle instances.
sids=($(ps -ef | grep pmon | awk -F\_ '{print $3}' | egrep -v '^$|\+' | xargs))
[ ! -z $sids ] && echo $sids > ${collect_path}/oracle_sids.txt

# get information about InfoScale/Veritas Cluster Server.
check_vcs_had=$(ps -ef | egrep -w "VRTSvcs/bin/had");
if [ ! -z "$check_vcs_had" ] ; then
  export PATH=${PATH}:/opt/VRTSvcs/bin:/opt/VRTS/bin:/opt/VRTSsfmh/bin:/etc/vx/bin
  hacf -verify /etc/VRTSvcs/conf/config/ -display > ${collect_path}/hacf_verify_display.txt
  had -version > ${collect_path}/had_version.txt
  hauser -display > ${collect_path}/hauser_display.txt
  hauser -list > ${collect_path}/hauser_list.txt
  hasys -list > ${collect_path}/hasys_list.txt
  hasys -state > ${collect_path}/hasys_state.txt
  hasys -nodeid > ${collect_path}/hasys_nodeid.txt
  hastatus -summ > ${collect_path}/hastatus_summ.txt
  hatype -display > ${collect_path}/hatype_display.txt
  hatype -list > ${collect_path}/hatype_list.txt
  hares -list > ${collect_path}/hares_list.txt
  hagrp -list > ${collect_path}/hares_list.txt
  haclus -value EngineVersion > ${collect_path}/haclus_engineversion.txt
  haclus -display > ${collect_path}/haclus_display.txt
  vxddladm get namingscheme > ${collect_path}/vxddladm_namingscheme.txt
  vxddladm listjbod > ${collect_path}/vxddladm_listjbod.txt
  vxddladm listsupport > ${collect_path}/vxddladm_listsupport.txt
  vxlist > ${collect_path}/vxlist.txt
  vxdisk list > ${collect_path}/vxdisk_list.txt
  vxdisk -e list > ${collect_path}/vxdisk_e_list.txt
  vxdisk -s list > ${collect_path}/vxdisk_s_list.txt
  vxdisk -o alldgs list > ${collect_path}/vxdisk_o_alldgs_list.txt
  vxdctl -c mode > ${collect_path}/vxdctl_c_mode.txt
  vxdctl mode > ${collect_path}/vxdctl_mode.txt
  vxclustadm -v nodestate > ${collect_path}/vxclustadm_nodestate.txt
  vxclustadm nidmap > ${collect_path}/vxclustadm_nidmap.txt
  vxclustadm -v nodestate -d > ${collect_path}/vxclustadm_v_nodestate.txt
  gabconfig -a > ${collect_path}/gabconfig_a.txt
  gabconfig -W > ${collect_path}/gabconfig_W.txt
  lltconfig -W > ${collect_path}/lltconfig_W.txt
  lltstat > ${collect_path}/lltstat.txt
  lltstat -nvv active > ${collect_path}/lltstat_active.txt
  lltstat -n > ${collect_path}/lltstat_n.txt
  cfscluster status > ${collect_path}/cfscluster_status.txt
  vxdg list > ${collect_path}/vxdg_list.txt && vxdg free > ${collect_path}/vxdg_free.txt
  vxprint -ht > ${collect_path}/vxprint_ht.txt
  vxprint -Ath -q > ${collect_path}/vxprint_Athq.txt
  vxprint -AGts > ${collect_path}/vxprint_AGts.txt
  vxprint -m rootdg > ${collect_path}/vxprint_m_rootdg.txt
  vxlicrep > ${collect_path}/vxlicrep.txt
  vxlicrep -e > ${collect_path}/vxlicrep_e.txt
  vxfenadm -d > ${collect_path}/vxfenadm_d.txt
  vxdmpadm gettune all > ${collect_path}/vxdmpadm_gettune_all.txt
  vxdmpadm listapm all > ${collect_path}/vxdmpadm_listapm_all.txt
  vxdmpadm listenclosure all > ${collect_path}/vxdmpadm_listenclosure_all.txt
  vxdmpadm stat restored > ${collect_path}/vxdmpadm_stat_restored.txt
  vxdmpadm listctlr all > ${collect_path}/vxdmpadm_listctlr_all.txt
  vxdmpdbprint > ${collect_path}/vxdmpdbprint.txt
  vxlicense -p > ${collect_path}/vxlicense_p.txt

for a in $(/opt/VRTSvcs/bin/hares -list | awk '{print $1}') ; do
  hares -display $a > ${collect_path}/hares_display.txt
done

for a in $(/opt/VRTSvcs/bin/hagrp -list | awk '{print $1}') ; do
  hagrp -display $a > ${collect_path}/hagrp_display.txt
done

fi

if [ -d /etc/VRTSvcs/conf/config/ ] ; then
  mkdir -p ${collect_path}/VRTSvcs
  cp -r /etc/{llthosts,VRTSvcs/conf/config/*.cf,llttab,vxfenmode,vxfentab,gabtab,gabconfig,VRTSagents,VRTSvbs,vxcps,vxfen.d} ${collect_path}/VRTSvcs
fi

# delete empty files
find ${collect_path} -empty -exec rm -rf '{}' \;

# compress than delete the current job directory.
[ -d ${collect_path} ] && cd ${collect_path}/../ && mv $(date +"%d%m%Y") $(hostname -s)_$(date +"%d%m%Y") && tar -cvjSf collect_$(hostname -s)_$(date +"%d%m%Y").tar.bz2 $(hostname -s)_$(date +"%d%m%Y") --remove-files

}

# function to run on platform AIX only.
sys_aix () {
        exit 1
}

# function to run on platform SunOS only.
sys_sunos () {

# checks if collect directory exists and delete old jobs, if not exists create it. delete collect tar files older than 7 days.
[ -d ${collect_path} ] && find ${collect_path}/../ -type d ! -name collect ! -name \. -exec rm -rf '{}' \; || mkdir -p ${collect_path}
[ -d ${collect_path} ] && find ${collect_path}/../ -type f -name collect_*.tar -mtime +7 -exec rm -rf '{}' \;

uname -n > ${collect_path}/hostname.txt
cfgadm -alv > ${collect_path}/cfgadm-alv.txt
cp -pr /etc/hosts /etc/hostname.* /root/scripts/* /etc/passwd /etc/shadow /etc/group /etc/services /etc/vfstab ${collect_path}
crontab -l > ${collect_path}/crontab-l.txt
df -k > ${collect_path}/df_k.txt
dladm show-aggr -L > ${collect_path}/dladm-show-aggr.txt
dladm show-dev > ${collect_path}/dladm-show-dev.txt
dladm show-phys > ${collect_path}/dladm-show-phys.txt
echo |format > ${collect_path}/format.txt
eeprom > ${collect_path}/eeprom.txt
fcinfo hba-port > ${collect_path}/fcinfo-hba.txt
ifconfig -al > ${collect_path}/ifconfig.txt
ipadm show-addr > ${collect_path}/ipadm-show-addr.txt
ipadm show-\if > ${collect_path}/ipadm-show-if.txt
ldm list > ${collect_path}/ldm-list.txt
ldm list-devices > ${collect_path}/ldm-list-devices.txt
ldm list-services > ${collect_path}/ldm-list-services.txt
ldm ls -l > ${collect_path}/ldm-ls-l.txt
luxadm -e port > ${collect_path}/luxadm-port.txt
mount > ${collect_path}/mount.txt
mpathadm list LU > ${collect_path}/mpathadm-list.txt
mpathadm show LU > ${collect_path}/mpathadm-show.txt
netstat -an > ${collect_path}/netstat-an.txt
netstat -rn > ${collect_path}/netstat-rn.txt
powermt display > ${collect_path}/powermt.txt
powermt display dev=all > ${collect_path}/powermt_all.txt
prtdiag -v > ${collect_path}/prtdiag-v.txt
ps -ef > ${collect_path}/processos.txt
ps -ef | grep -i pmon > ${collect_path}/pmon.txt
rpcinfo > ${collect_path}/rpcinfo.txt
svcs -av > ${collect_path}/svcs-av.txt
svcs -l > ${collect_path}/svcs-l.txt
svcs -xv > ${collect_path}/svcs-xv.txt
uname -a > ${collect_path}/uname.txt
/usr/bin/ls -l /dev/rdsk > ${collect_path}/ls-rdsk.txt
vmstat 5 5 > ${collect_path}/vmstat.txt
zfs list > ${collect_path}/zfs-list.txt
zpool list > ${collect_path}/zpool-list.txt
zpool status -v > ${collect_path}/zpool-status.txt

# compress than delete the current job directory.
[ -d ${collect_path} ] && cd ${collect_path}/../ && mv $(date +"%d%m%Y") $(uname -n)_$(date +"%d%m%Y") && tar -cf collect_$(uname -n)_$(date +"%d%m%Y").tar $(uname -n)_$(date +"%d%m%Y") && rm -rf $(uname -n)_$(date +"%d%m%Y")

}

# function to run on platform HP-UX only.
sys_hpux () {
bdf > ${collect_path}/bdf.txt
cp -pr /etc/hosts /etc/passwd /etc/group /etc/services /etc/lvmpvg /etc/lvmtab /etc/fstab ${collect_path}/
cp -pr /etc/shadow /etc/rc.config.d/netconf /etc/dfs /etc/rc.config.d/nddconf /etc/exports ${collect_path}/
cp -pr /.profile /etc/profile ${collect_path}/
cp /usr/local/bin/*.sh ${collect_path}/
crashconf -v > ${collect_path}/crashconf.txt
exportfs  > ${collect_path}/exportfs.txt
ioscan -fnC disk > ${collect_path}/ioscan_fnC_disks.txt
ioscan -fnC lan > ${collect_path}/ioscan_fnC_lan.txt
ioscan -fn > ${collect_path}/ioscan_fn.txt
ioscan -m dsf > ${collect_path}/ioscan_m_dsf.txt
ioscan -m lun > ${collect_path}/ioscan_m_lun.txt
kctune > ${collect_path}/kctune.txt
kmtune > ${collect_path}/kmtune.txt
lanscan >  ${collect_path}/lanscan.txt
lvdisplay -v /dev/vg*/lvol* > ${collect_path}/lvdisplay.txt
lvlnboot -R > ${collect_path}/lvlnboot_R.txt
lvlnboot -v > ${collect_path}/lvlnboot_v.txt
mount -p > ${collect_path}/mount_p.txt
netstat -in > ${collect_path}/netstat_in.txt
netstat -rn > ${collect_path}/netstat_rn.txt
powermt display > ${collect_path}/powermt_display.txt
powermt display dev=all > ${collect_path}/powermt_dispaly_devall.txt
ps -ef > ${collect_path}/ps_ef.txt
ps -ef | grep -i pmon > ${collect_path}/pmon.txt
setboot > ${collect_path}/setboot.txt
swapinfo -tam > ${collect_path}/swapinfo_tam.txt
swlist -l bundle > ${collect_path}/swlist_l_bundle.txt
swlist -l fileset > ${collect_path}/swlist_l_fileset.txt
swlist -l product > ${collect_path}/swlist_l_product.txt
sysdef > ${collect_path}/sysdef.txt
uname -a > ${collect_path}/uname_a.txt
vgdisplay -v > ${collect_path}/vgdisplay_v.txt
vparenv > ${collect_path}/vparenv.txt
vparstatus -A > ${collect_path}/vparstatus_A.txt
vparstatus > ${collect_path}/vparstatus.txt
vparstatus -v > ${collect_path}/vparstatus_v.txt

[ ! -d ${collect_path}/crontabs/ ] && mkdir -p ${collect_path}/crontabs
cp -pr /var/spool/cron/crontabs/* ${collect_path}/crontabs/

if  [ -d /etc/cmcluster ] ; then
  tar cvf ${collect_path}/cmcluster.tar  /etc/cmcluster
  cmviewcl > ${collect_path}/cmviewcl.txt
  cmviewcl -v > ${collect_path}/cmviewcl_v.txt
fi

# compress than delete the current job directory.
[ -d ${collect_path} ] && cd ${collect_path}/../ && mv $(date +"%d%m%Y") $(uname -n)_$(date +"%d%m%Y") && tar -cf collect_$(uname -n)_$(date +"%d%m%Y").tar $(uname -n)_$(date +"%d%m%Y") && rm -rf $(uname -n)_$(date +"%d%m%Y")
}

# function to check platform.
my_verify_plat () {

plat="$(uname)";
rt="0";

[ ${plat} = "Linux" ] && sys_linux ; rt=0
[ ${plat} = "AIX" ] && sys_aix ; rt=0
[ ${plat} = "SunOS" ] && sys_sunos ; rt=0
[ ${plat} = "HP-UX" ] && sys_hpux ; rt=0
[ ${rt} -ne 0 ] && exit 1

} > /dev/null 2>&1

# check the platform than run the correct function.
my_verify_plat
