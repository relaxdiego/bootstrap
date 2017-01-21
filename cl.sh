#!/usr/bin/env bash
echo $1

if [[ -z $1  || -z $2 ]]; then
    echo "ERROR: You must provide a local IP and target drive as arguments. Example:"
    echo "curl https://bit.ly/bootstrap-coreos | bash -s 10.10.10.10 /dev/sda"
    exit 1
fi

local_ip=$1
target_drive=$2
keys_url="${3:-https://github.com/relaxdiego.keys}"

echo "Downloading authorized keys"
IFS=$'\n' keys=($(curl -L $keys_url))

authorized_keys=""
newline=$'\n'

for key in "${keys[@]}"; do
    authorized_keys="${authorized_keys}  - ${key}${newline}"
done

cat > bootstrap.yml <<EOF
# cloud-config

ssh_authorized_keys:
${authorized_keys}

coreos:
  units:
    - name: oem-cloudinit.service
      command: restart
      runtime: yes
      content: |
        [Unit]
        Description=Cloudinit from relaxdiego-style metadata
        [Service]
        Type=oneshot
        ExecStart=/usr/bin/coreos-cloudinit -from-url=http://$local_ip/cloudinit
EOF

sudo coreos-install -d $target_drive -C stable -c ./bootstrap.yml
sudo shutdown -r now
