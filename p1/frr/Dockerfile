# Image of frrouting
FROM frrouting/frr
# Copy the configuration file from the local repo to the image.
COPY ./daemons.conf /etc/frr/daemons.conf
# Modify the owner group of the file.
RUN chown frr:frr /etc/frr/daemons.conf