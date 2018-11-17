#!/bin/bash

# This script is the command for the container, defined in the Dockerfile as "CMD /start.sh"

# The first time the container is run, the /hxe_install_done file does not exist.
# The HXE_INSTALLER_URL is the URL which SAP's HXEDownloadManager.jar uses to download files from.
# So instead of installing java and running the HXEDownloadManager.jar, we are just going to use wget
# to download HANA's "Server only installer" - hxe.tgz (it is about 1.6 GB).
# The hxe.tgz contains the SAP HANA Express Edition installation files and the setup_hxe.sh.
# The setup_hxe.sh script takes several user inputs. Default values are provided for all but the master password.
# The MASTER_PWD environment variable must be at least 8 characters in length. It must contain at least 1 uppercase letter, 1 lowercase letter, and 1 number.
# When the installer is done, the system can be cleaned up and the /hxeinstall folder can be removed.
# The /hxe_install_done file is created, so the next time the container is started, the installation part is skipped
# and only HANA DB is started - su -l hxeadm HDB start.

if [ ! -f /hxe_install_done ]; then

    # HXE_INSTALLER_URL="https://d149oh3iywgk04.cloudfront.net/hanaexpress/HANA2latest/tar/linuxx86_64/hxe.tgz"
    HXE_INSTALLER_URL="https://d149oh3iywgk04.cloudfront.net/hanaexpress/2.0/2.00.033.00.20180925.2/tar/linuxx86_64/hxe.tgz"

    # download HANA installer hxe.tgz and untar it in the /hxeinstall folder
    mkdir /hxeinstall
    wget --referer="https://go.sap.com/" -O /hxeinstall/hxe.tgz $HXE_INSTALLER_URL
    tar -xvzf /hxeinstall/hxe.tgz -C /hxeinstall

    # install HANA
    /hxeinstall/setup_hxe.sh <<EOF
${INSTALLER_PATH}
${SID}
${INSTANCE}
${HOST_NAME}
${MASTER_PWD}
${MASTER_PWD}
y
EOF

    touch /hxe_install_done

else
    # start HANA each time the container starts
    su -l hxeadm HDB start
    # cat makes the container run infinitely (or until stopped)
    cat
fi