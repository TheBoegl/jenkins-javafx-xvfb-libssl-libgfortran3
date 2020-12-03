FROM theboegl/jenkins-javafx-xvfb
LABEL maintainer="info@sebastianboegl.de"

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="theboegl/jenkins-javafx-xvfb"
LABEL org.label-schema.description="Official jenkins LTS version with JavaFX, xvfbm, libssl1.0.0, and libgfortran3"
LABEL org.label-schema.vcs-url="https://github.com/TheBoegl/jenkins-javafx-xvfb-libssl-libgfortran3"


# Switching from jenkins to root user...
USER root

RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb \
    && dpkg -i libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb \
    && rm  libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb
    
# libgfortran3
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           libgfortran3 \
        && rm -rf /var/lib/apt/lists/* 

# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
