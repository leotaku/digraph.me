ssh := "ssh -i secrets/id_rsa -o PasswordAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

build:
    cd image && \
    packer build .

apply:
    terraform apply

ssh *args:
    {{ssh}} root@raw.digraph.me {{args}}

put source target *args:
    rsync -rL "{{source}}" root@raw.digraph.me:"{{target}}" -e "{{ssh}}" --info "progress2" {{args}}
