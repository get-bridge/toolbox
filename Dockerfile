FROM nicolaka/netshoot:latest

RUN apk add --update \
    jq \
    postgresql-client \
    groff \
  && rm -rf /var/cache/apk/*

# HashiCorp Vault
COPY --from=hashicorp/vault:latest /bin/vault /usr/bin/vault

ENV VAULT_ADDR https://vault.vault.svc:8200
ENV VAULT_SKIP_VERIFY true

# HashiCorp Consul
COPY --from=hashicorp/consul:latest /bin/consul /usr/bin/consul
ENV CONSUL_HTTP_ADDR http://consul.vault.svc:8500

# kubectl
COPY --from=bitnami/kubectl:1.33.2 /opt/bitnami/kubectl/bin/kubectl /usr/bin/kubectl

# AWS CLI
RUN apk add --no-cache aws-cli

# add only redis cli from redis suite
COPY --from=redis:7-alpine /usr/local/bin/redis-cli /usr/local/bin/redis-cli

RUN chmod +x /usr/local/bin/redis-cli

COPY motd /etc/motd
COPY entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
