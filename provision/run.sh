function distro_id () {
    lsb_release -is 2> /dev/null | awk '{print tolower($0)}'
}

function is_ubuntu () {
    [ $(distro_id) == "ubuntu" ]
}

function is_debian () {
    [ $(distro_id) == "debian" ]
}

### Commmands

if command -v ansible-playbook > /dev/null 2>&1; then
    echo "Ansible already installed."

elif is_ubuntu; then
    echo "Ubuntu detected"
    echo "Installing ansible"
    sudo apt-get update
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository -y ppa:ansible/ansible
    sudo apt-get update
    sudo apt-get install -y ansible
elif is_debian; then
    echo "Debian detected"
    if [ ! -f /etc/apt/sources.list.d/ansible.list ]; then
        echo "Creating source.list file"
        repo_line="deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main"
        echo "$repo_line" | sudo tee /etc/apt/sources.list.d/ansible.list
        sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
        sudo apt-get update
    else
        echo "Source.list file already exists"
    fi
    echo "Installing ansible"
    sudo apt-get install -y ansible

else
    echo "Unsuported distro" $(distro_id)
    exit 1
fi

echo "Running playbook"

exec sudo -u "root" -- "ansible-playbook" "setup.yml" "$@"
