inherit extrausers

USER_ID ?= "1100"
USER_NAME ??= "kai"
USER_PASSWORD ??= "dotnet"
USER_PASSWORD_ENCRYPTED ??= "$(openssl passwd -6 ${USER_PASSWORD})"

USERADD_COMMAND ?= "\
  --create-home \
  --groups sudo,dotnet,gpio,i2c,spi,usb,video \
  --uid ${USER_ID} \
  --home /home/${USER_NAME} \
  ${USER_NAME} \
"

EXTRA_USERS_PARAMS = "\
  groupadd -g 680 sudo; \
  groupadd -g 780 dotnet; \
  groupadd -g 880 gpio; \
  groupadd -g 881 i2c; \
  groupadd -g 882 spi; \
  groupadd -g 883 usb; \
  groupadd -g 884 video; \
  useradd  ${USERADD_COMMAND}; \
  usermod -p '${USER_PASSWORD_ENCRYPTED}' ${USER_NAME}; \
  usermod --shell /sbin/nologin root; \
  usermod -L -e 1 root; \
"