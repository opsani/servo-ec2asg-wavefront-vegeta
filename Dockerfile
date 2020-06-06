FROM python:3-slim

LABEL maintainer="support@opsani.com"
LABEL description="A servo for opsani.com optimization"
LABEL plugins="servo-ec2asg, servo-magg, servo-wavefront, servo-vegeta"
LABEL version="0.9.0"
LABEL vegeta-version="v12.8.3"

WORKDIR /servo

ARG VEGETA_VER
ENV VEGETA_VER=v12.8.3

# Install dependencies
RUN apt update && apt -y install procps tcpdump curl wget
RUN pip3 install requests PyYAML python-dateutil awscli boto3

RUN mkdir -p measure.d

# Install servo
ADD https://raw.githubusercontent.com/opsani/servo/master/servo \
    https://raw.githubusercontent.com/opsani/servo/master/adjust.py \
    https://raw.githubusercontent.com/opsani/servo/master/measure.py \
    https://raw.githubusercontent.com/opsani/servo-ec2asg/master/adjust \
    https://raw.githubusercontent.com/opsani/servo-magg/master/measure \
    /servo/

# Install measure aggregated connectors
ADD https://raw.githubusercontent.com/opsani/servo-vegeta/master/measure measure.d/measure-vegeta
ADD https://raw.githubusercontent.com/opsani/servo-wavefront/master/measure measure.d/measure-wavefront
ADD https://raw.githubusercontent.com/opsani/servo/master/measure.py measure.d/

RUN curl -sL https://github.com/tsenart/vegeta/releases/download/v12.8.3/vegeta-12.8.3-linux-amd64.tar.gz| tar xfz - -C /usr/local/bin/
RUN chmod a+rwx /servo/adjust /servo/measure /servo/servo /usr/local/bin/vegeta \
  && chmod a+rwx /servo/measure.d/measure-wavefront /servo/measure.d/measure-vegeta \
  && chmod a+r /servo/adjust.py /servo/measure.py /servo/measure.d/measure.py

ENV PYTHONUNBUFFERED=1

ENTRYPOINT [ "python3", "servo" ]
CMD [""]

