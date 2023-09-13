build:
    cd image && \
    packer build .

deploy:
    terraform apply

ssh:
    ssh root@raw.digraph.me \
      -i secrets/id_rsa \
      -o UserKnownHostsFile=/dev/null \
      -o StrictHostKeyChecking=no

put source target:
    rsync -rL {{source}} root@raw.digraph.me:{{target}} \
      -e "ssh -i secrets/id_rsa \
              -o UserKnownHostsFile=/dev/null \
              -o StrictHostKeyChecking=no" \
      --info "progress2"
