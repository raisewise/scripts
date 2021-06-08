#!/bin/sh

### 1-01 disable root connection
/usr/bin/sed -i -e 's/auth\ \[user_unknown=ignore\ success=ok\ ignore=ignore\ default=bad\]\ pam_securetty.so/#auth\ \[user_unknown=ignore\ success=ok\ ignore=ignore\ default=bad\]\ pam_securetty.so/g' /etc/pam.d/login
/usr/bin/sed -i -e '3 i\auth       required     pam_securetty.so' /etc/pam.d/login

### 1-02 complex password, 1-07, 1-08, 1-09
/usr/bin/sed -i -e 's/# minlen = 9/minlen = 8/g' -e 's/# dcredit = 1/dcredit = -1/g' -e 's/# ucredit = 1/ucredit = -1/g' -e 's/# lcredit = 1/lcredit = -1/g' -e 's/# ocredit = 1/ocredit = -1/g'  /etc/security/pwquality.conf
/usr/bin/sed -i -e 's/PASS_MAX_DAYS\t99999/PASS_MAX_DAYS\t90/g' -e 's/PASS_MIN_DAYS\t0/PASS_MIN_DAYS\t1/g' -e 's/PASS_MIN_LEN\t5/PASS_MIN_LEN\t8/g' /etc/login.defs

### 1-03 account lock
/usr/bin/sed -i -e 's/auth        required      pam_faildelay.so delay=2000000/auth        required      pam_tally2.so deny=3 unlock_time=120/g' -e '11 iaccount     required      pam_tally2.so' /etc/pam.d/password-auth
/usr/bin/sed -i -e 's/auth        required      pam_faildelay.so delay=2000000/auth        required      pam_tally2.so deny=3 unlock_time=120/g' -e '12 iaccount     required      pam_tally2.so' /etc/pam.d/system-auth

### 1-04 remember password
/usr/bin/sed -i -e 's/password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok/password    sufficient    pam_unix.so sha512 shadow nullok try_first_pass use_authtok remember=5/g' /etc/pam.d/system-auth

### 1-10 timeout session
/usr/bin/echo 'TMOUT=600' >> /etc/profile
/usr/bin/echo 'export TMOUT' >> /etc/profile
/usr/bin/echo 'autologout=10' >> /etc/csh.login

### 2-* permission directory, file
/usr/bin/chmod 600 /var/log/wtmp /var/log/lastlog /usr/bin/lastcomm
for i in `ls -lh /home/ | awk '{print $9}'` ; do chmod 600 /home/$i/.bash_history ; done
/usr/bin/chmod 640 /etc/cron.deny /etc/at.deny
/usr/bin/chmod 771 /etc /usr/bin /sbin
/usr/bin/chmod 754 /etc/rc.d/init.d /etc/rc.d/rc*.d

### 3-06 SMTP disable
/usr/bin/systemctl stop postfix
/usr/bin/systemctl disable postfix

### 4-01 banner
/usr/bin/echo '******************************************************************************' > /etc/issue
/usr/bin/echo '                                  Warning                                     ' >> /etc/issue
/usr/bin/echo 'This system has to be accessed by authorized user and only use for officially.' >> /etc/issue
/usr/bin/echo 'During using equipment, privacy of indibiduals is not guaranteed.             ' >> /etc/issue
/usr/bin/echo 'All access and usage is monitored and recoreded and can be provided evidence  ' >> /etc/issue
/usr/bin/echo 'as court or related organization.                                             ' >> /etc/issue
/usr/bin/echo 'Use of this system constitutes consent to monitoring for these purposes.      ' >> /etc/issue
/usr/bin/echo '******************************************************************************' >> /etc/issue
/usr/bin/sed -i -e 's/#Banner none/Banner \/etc\/issue/g' /etc/ssh/sshd_config
/usr/bin/systemctl restart sshd

### 5-01 system log settings
/usr/bin/sed -i -e '55 i*.alert                                                 /var/log/messages' /etc/rsyslog.conf
/usr/bin/sed -i -e '56 i*.alert                                                 /dev/console' /etc/rsyslog.conf
/usr/bin/sed -i -e '57 i*.alert                                                 root' /etc/rsyslog.conf
/usr/bin/systemctl restart rsyslog

