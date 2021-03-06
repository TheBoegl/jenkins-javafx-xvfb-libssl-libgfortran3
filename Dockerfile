FROM theboegl/jenkins-javafx-xvfb
LABEL maintainer="info@sebastianboegl.de"

# Labels.
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="theboegl/jenkins-javafx-xvfb"
LABEL org.label-schema.description="Official jenkins LTS version with JavaFX, xvfbm, libssl1.0.0, and libgfortran3"
LABEL org.label-schema.vcs-url="https://github.com/TheBoegl/jenkins-javafx-xvfb-libssl-libgfortran3"


# Switching from jenkins to root user...
USER root
# multiarch-support for libssl
RUN mkdir /var/lib/apt/lists/partial \
        && apt-get update && apt-get install -y --no-install-recommends \
           multiarch-support libquadmath0 \
        && rm -rf /var/lib/apt/lists/*

#libssl
RUN wget http://security.debian.org/debian-security/pool/updates/main/o/openssl/libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb \
    && dpkg -i libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb \
    && rm  libssl1.0.0_1.0.1t-1+deb8u12_amd64.deb

# gcc-6-base for libgfortran3
RUN wget http://http.us.debian.org/debian/pool/main/g/gcc-6/gcc-6-base_6.3.0-18+deb9u1_amd64.deb \
    && dpkg -i gcc-6-base_6.3.0-18+deb9u1_amd64.deb \
    && rm gcc-6-base_6.3.0-18+deb9u1_amd64.deb

# libgfortran3
RUN wget http://http.us.debian.org/debian/pool/main/g/gcc-6/libgfortran3_6.3.0-18+deb9u1_amd64.deb \
    && dpkg -i libgfortran3_6.3.0-18+deb9u1_amd64.deb \
    && rm libgfortran3_6.3.0-18+deb9u1_amd64.deb
    
# Switching back from root to jenkins user for any further RUN/CMD/ENTRYPOINT...
USER jenkins
