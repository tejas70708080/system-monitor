#BASE image
FROM ubuntu:22.04

#Set Env variables for timezone and no prompts during apt install
ENV TZ=Asia/Kolkata \
    DEBIAN_FRONTEND=noninteractive

#Set current working directory
WORKDIR /app

#copy files to the container at work directory
COPY monitor.sh .
COPY logs/ ./logs/

#updates the list of what packages and versions are available.
RUN apt-get update \
#install only required packages for timezone data
    && apt-get install -y --no-install-recommends tzdata \
#clean the metadata as it is no longer used by apt
    && rm -rf /var/lib/apt/lists/* \
#make the script executable
    && chmod +x monitor.sh

#mount point for log files from the host
VOLUME ["/app/logs"]

#always run ./monitor.sh
ENTRYPOINT ["./monitor.sh"]

#supplies default log file, can be overwritten from CLI
CMD ["logs/sample.log"]
