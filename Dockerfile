# 1) choose base container
# generally use the most recent tag

# data science notebook
# https://hub.docker.com/repository/docker/ucsdets/datascience-notebook/tags
ARG BASE_CONTAINER=ucsdets/datascience-notebook:2020.2-stable

# scipy/machine learning (tensorflow)
# https://hub.docker.com/repository/docker/ucsdets/scipy-ml-notebook/tags
# ARG BASE_CONTAINER=ucsdets/scipy-ml-notebook:2020.2-stable

FROM $BASE_CONTAINER

LABEL maintainer="UC San Diego ITS/ETS <ets-consult@ucsd.edu>"

# 2) change to root to install packages
USER root

RUN	apt-get install htop
RUN apt_get -y install aria2
RUN apt_get -y install nmap
RUN apt_get -y install traceroute

# 3) install packages
RUN pip install --no-cache-dir networkx scipy python-louvain
RUN pip install --no-cache-dir babypandas
RUN conda clean -tipy

# 4) change back to notebook user
COPY /run_jupyter.sh /
USER $NB_UID

# Override command to disable running jupyter notebook at launch
# CMD ["/bin/bash"]
