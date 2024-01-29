ssh := "ssh -i secrets/id_rsa -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no"

build:
    cd image && \
    packer build .

deploy:
    terraform apply

ssh:
    {{ssh}} root@raw.digraph.me

put source target:
    rsync -rL {{source}} root@raw.digraph.me:{{target}} -e "{{ssh}}" --info "progress2"
