FROM buildpack-deps:bionic-scm
MAINTAINER Martin Kvapil <martin@qapil.cz>

# Gradle version
ENV GRADLE_VERSION 4.7

# Install JDK, unzip
RUN apt-get update && \
	apt-get install -y openjdk-8-jdk unzip

# Download and install Gradle
RUN cd /usr/lib \
	&& curl -fl https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -o gradle-bin.zip \
	&& unzip "gradle-bin.zip" \
	&& ln -s "/usr/lib/gradle-${GRADLE_VERSION}/bin/gradle" /usr/bin/gradle \
	&& rm "gradle-bin.zip"

# Export some environment variables
ENV GRADLE_HOME /usr/lib/gradle
ENV PATH $PATH:$GRADLE_HOME/bin

# Define volume: your local app code directory can be mounted here
VOLUME ["/data/app"]
VOLUME ["/root/.gradle/caches/"]

# Define working directory
WORKDIR /data/app

# Define entrypoint and default command
ENTRYPOINT ["gradle"]
CMD ["-version"]
