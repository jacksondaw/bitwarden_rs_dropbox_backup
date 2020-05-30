FROM alpine:latest

# install sqlite, curl, bash (for script)
RUN apk add --no-cache \
    sqlite \
    curl \
    bash \
    openssl

# install dropbox uploader script
RUN curl "https://raw.githubusercontent.com/jacksondaw/Dropbox-Uploader/master/dropbox_uploader.sh" -o dropbox_uploader.sh && \
    chmod +x dropbox_uploader.sh

# copy backup script to crond daily folder
COPY backup.sh /

# copy entrypoint to usr bin
COPY entrypoint.sh /

# give execution permission to scripts
RUN chmod +x /entrypoint.sh && \
    chmod +x /backup.sh

RUN echo "0 1 * * * /backup.sh" > /etc/crontabs/root

ENTRYPOINT ["/entrypoint.sh"]
