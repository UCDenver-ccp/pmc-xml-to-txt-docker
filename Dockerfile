FROM amazoncorretto:8

RUN yum update -y \
  && yum install -y \
  git \
  less \
  vim \
  maven \
  wget \
  tar \
  && yum clean all

# set up dev user
ARG UID=1000
ARG GID=1000
RUN groupadd -o -g $GID dev
RUN useradd -m -u $UID -g $GID -s /bin/bash dev

# install CRAFT resources
WORKDIR /home/dev
RUN git clone https://github.com/UCDenver-ccp/ccp-nlp.git ./ccp-nlp.git
WORKDIR /home/dev/ccp-nlp.git
RUN mvn clean install
WORKDIR /home/dev
RUN mkdir input && mkdir output


ENV MAVEN_OPTS="-Xmx6G"

CMD ["/bin/sh", "-c", "mvn -f /home/dev/ccp-nlp.git/ccp-nlp-doc2txt/pom.xml exec:java -Dexec.mainClass=edu.ucdenver.ccp.nlp.doc2txt.pmc.PmcDocumentConverter -Dexec.args='-i /home/dev/input -o /home/dev/output -l NULL'"]

### To Build the image
# docker build -t nxml2txt .


### To convert nxml files to text:
# 1. create a local directory that contains the nxml files you want to convert to text: /path/to/nxml
# 2. create a local directory where the resulting text files wil be stored: /path/to/txt
# 3. then run the following:
#
# docker run --rm -v /path/to/nxml:/home/dev/input  -v /path/to/txt:/home/dev/output nxml2txt
#
# 4. After running, converted text files should be in /path/to/txt/
