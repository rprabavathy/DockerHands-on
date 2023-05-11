FROM  centos:7 AS builder
WORKDIR /root
RUN yum -y install epel-release
RUN yum -y install git
RUN yum -y install gnucobol
RUN git clone https://github.com/harenber/sieve_of_eratosthenes && \
    cd sieve_of_eratosthenes && \
    cobc -x -o era era.cobol && \
    ls -l
FROM alpine:latest
USER "1085"
COPY --from=builder /root/sieve_of_eratosthenes/era /usr/local/bin/sieve_of_eratosthenes
WORKDIR /tmp
CMD ["yum -y install epel-release","yum -y install libcob","cobc -x -o era era.cobol"]