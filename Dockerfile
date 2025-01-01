FROM ubuntu:jammy

LABEL maintainer="sameer@damagehead.com"

RUN apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    ca-certificates \
    gnupg \
 && apt-key adv --fetch-keys "https://dl-ssl.google.com/linux/linux_signing_key.pub" \
 && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list \
 && apt-get update \
 && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
    file \
    locales \
    dbus-x11 \
    pulseaudio \
    dmz-cursor-theme \
    sudo \
    fonts-dejavu \
    fonts-liberation \
    fonts-indic \
    hicolor-icon-theme \
    libcanberra-gtk3-0 \
    libcanberra-gtk-module \
    libcanberra-gtk3-module \
    libasound2 \
    libglib2.0-0 \
    libgtk-3-0 \
    libdbus-glib-1-2 \
    libxt6 \
    libexif12 \
    libgl1 \
    libstdc++6 \
    nvidia-driver-525 \
    gstreamer1.0-plugins-base \
    gstreamer1.0-plugins-good \
    gstreamer1.0-plugins-bad \
    gstreamer1.0-plugins-ugly \
    gstreamer1.0-libav \
    google-chrome-stable \
    firefox \
 && update-locale LANG=C.UTF-8 LC_MESSAGES=POSIX \
 && rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y curl \
    && echo "Downloading Firefox..." \
    && curl -L "https://download.mozilla.org/?product=firefox-latest&os=linux64&lang=en-US" -o firefox.tar.bz2 \
    && echo "Extracting Firefox..." \
    && tar -xjf firefox.tar.bz2 -C /opt/ \
    && ln -s /opt/firefox/firefox /usr/local/bin/firefox

COPY scripts/ /var/cache/browser-box/
COPY entrypoint.sh /sbin/entrypoint.sh
COPY confs/local.conf /etc/fonts/local.conf

RUN chmod 755 /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
