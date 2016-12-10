**[Technical overview](#technical-overview)** |
**[Installation](#installation)** |
**[Configuration](#configuration)** |
**[Running](#running)** |
**[License](#license)**

# [collect-exec](https://github.com/kdiegorsantos/collect-exec)

This shell script collects configuration and diagnostic information from *nix operation systems.


----

## Installation

Fork and give permission.

```bash
cd /var/tmp && git clone https://github.com/kdiegorsnatos/collect-exec.git
chmod u+x /var/tmp/collect-exec/bin/collect-exec.sh
```

----

## Configuration

- cron job

Create a cron job to execute the script every day.

```bash
cat <<EOF>> /var/spool/cron/crontabs/root
00 22 * * * timeout 30m /var/tmp/collect-exec/bin/collect-exec.sh
EOF
```

- ansible-playbook

If you want to automate the deploy of this shell script, feel free to use these ansible tasks.

Deploy the shell script to your servers.
```bash
ansible-playbook /var/tmp/collect/ansible/deploy_collect-exec.yml
```

Fetch tar files from your servers.
```bash
ansible-playbook /var/tmp/collect/ansible/fetch_collect-exec.yml
```

----

## Running

To run the shell script.

```bash
./var/tmp/collect-exec/bin/collect-exec.sh
```

Uncompress the tar file and check the collected information.

```bash
tar -xvf /var/tmp/collect/collect_ubuntu_09122016.tar.bz2 -C /var/tmp/collect
ls /var/tmp/collect/ubuntu_09122016
arp_a.txt                haclus_engineversion.txt     last_boot.txt       ps_alxwww.txt               vxddladm_listsupport.txt
cfscluster_status.txt    had_version.txt              lltconfig_W.txt     ps_auxwwwm.txt              vxddladm_namingscheme.txt
chkconfig.txt            hares_list.txt               lltstat.txt         pstree.txt                  vxdg_list.txt
crontab.txt              hastatus_summ.txt            lltstat_active.txt  pvs.txt                     vxdisk_e_list.txt
date.txt                 hasys_list.txt               lltstat_n.txt       pvscan.txt                  vxdisk_list.txt
df_alP.txt               hasys_nodeid.txt             lsblk.txt           redhat-release.txt          vxdisk_o_alldgs_list.txt
df_h.txt                 hasys_state.txt              lsmod.txt           rhncfg-client_channels.txt  vxdisk_s_list.txt
df_i.txt                 hatype_display.txt           lsof_bMnl.txt       route.txt                   vxdmpadm_gettune_all.txt
df_k.txt                 hatype_list.txt              lspci.txt           rpcinfo_p_localhost.txt     vxdmpadm_listapm_all.txt
dmesg.txt                hauser_display.txt           lspci_v.txt         rpm_qa.txt                  vxdmpadm_listctlr_all.txt
dmidecode.txt            hauser_list.txt              lsscsi.txt          rpm_qai.txt                 vxdmpadm_listenclosure_all.txt
dmsetup_info.txt         hostid.txt                   lvm_dumpconfig.txt  runlevel.txt                vxdmpadm_stat_restored.txt
dmsetup_ls.txt           hostname.txt                 lvm_version.txt     showmount.txt               vxdmpdbprint.txt
dmsetup_status.txt       ifconfig.txt                 lvmdiskscan.txt     swapon.txt                  vxfenadm_d.txt
dmsetup_table.txt        ifenslave_a.txt              lvs.txt             ulimit.txt                  vxlicense_p.txt
exportfs_v.txt           ip_address.txt               lvs_segments.txt    uname.txt                   vxlicrep.txt
fdisk.txt                ip_link.txt                  multipath.txt       vgdisplay.txt               vxlicrep_e.txt
files                    ip_link_show.txt             netstat_agn.txt     vgs.txt                     vxlist.txt
free.txt                 ip_maddr_show.txt            netstat_antpl.txt   vgscan.txt                  vxprint_AGts.txt
gabconfig_W.txt          ip_mroute_show.txt           netstat_anupl.txt   vxclustadm_nidmap.txt       vxprint_Athq.txt
gabconfig_a.txt          ip_neigh_show.txt            netstat_neopa.txt   vxclustadm_nodestate.txt    vxprint_ht.txt
getconf_long_bit.txt     ip_route_show_table_all.txt  netstat_nr.txt      vxclustadm_v_nodestate.txt  vxprint_m_rootdg.txt
getconf_page_size.txt    ipcs_a.txt                   netstat_s.txt       vxdctl_c_mode.txt           yum_repolist.txt
hacf_verify_display.txt  java.txt                     nfsstat.txt         vxdctl_mode.txt
haclus_display.txt       java_version.txt             ntpstat.txt         vxddladm_listjbod.txt
```

- ansible tasks

If you want to automate the deploy of this shell script, feel free to use these ansible tasks.

Deploy the shell script to your servers.
```bash
ansible-playbook /var/tmp/collect/ansible/deploy_collect-exec.yml
```

Fetch tar files from your servers.
```bash
ansible-playbook /var/tmp/collect/ansible/fetch_collect-exec.yml
```

----

## License

This project is licensed under the MIT license. See included LICENSE.md.
