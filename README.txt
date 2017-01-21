Bootstraps a baremetal CoreOS Container Linux server with the initial
cloud-init file. Said file has a single service defined which is responsible
for downloading the actual cloud-init from a given local IP address.

Run with:

    curl -L https://bit.ly/coreos-bootstrap | bash -s 10.10.10.10 /dev/sda

Where:

    - 10.10.10.10 is the IP address where the cloud-init server is running

    - /dev/sda is the target device where you want to install CoreOS CL


Tips:

To get started:

    1. Download the CL ISO from https://coreos.com/os/docs/latest/booting-with-iso.html

    2. Burn it to disk or a USB

    3. Boot the machine to the disk or USB

    4. Run the above command
