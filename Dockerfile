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

# kubectl
ADD https://dl.k8s.io/release/v1.34.11/bin/linux/amd64/kubectl /usr/bin/kubectl
RUN chmod +x /usr/bin/kubectl

# AWS CLI
RUN apk add --no-cache aws-cli

# add only redis cli from redis suite
COPY --from=redis:7-alpine /usr/local/bin/redis-cli /usr/local/bin/redis-cli
RUN chmod +x /usr/local/bin/redis-cli

COPY motd /etc/motd
COPY entrypoint.sh ./

ENTRYPOINT ["./entrypoint.sh"]
