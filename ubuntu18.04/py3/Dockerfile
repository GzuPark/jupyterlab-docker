FROM ubuntu:18.04

RUN apt-get update && apt-get install -y \
    apt-utils \
    ca-certificates \
    apt-transport-https \
    gnupg2 \
    wget \
    unzip \
    curl \
    bzip2 \
    git \
    sudo \
    fonts-liberation

ENV PYTHON_VERSION 3.7
ENV CONDA_ENV_NAME jupyterlab
ENV LANG C.UTF-8

# Installation miniconda3
RUN curl -sSL http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh && \
    bash /tmp/miniconda.sh -bfp /usr/local && \
    rm -rf /tmp/miniconda.sh

# Set up conda environment
RUN conda update -y conda && \
    conda create -n ${CONDA_ENV_NAME} python=${PYTHON_VERSION}
ENV PATH /opt/conda/envs/${CONDA_ENV_NAME}/bin:$PATH
RUN echo "source activate ${CONDA_ENV_NAME}" > ~/.bashrc

# Install jupyter and notebook extension
RUN /bin/bash -c "source ~/.bashrc && conda install -q -y jupyter ipywidgets~=7.4.2 && \
    jupyter nbextension enable --py widgetsnbextension && \
    jupyter notebook --generate-config"

# Install jupyterlab
RUN /bin/bash -c "source ~/.bashrc && conda install -q -y jupyterlab~=0.35.5 && jupyter serverextension enable --py jupyterlab"

# Install git extension on jupyterlab
RUN /bin/bash -c "source ~/.bashrc && conda install -q -y nodejs~=10.13.0 && \
    jupyter labextension install @jupyterlab/git && \
    pip --no-cache-dir install jupyterlab-git~=0.6.1 && \
    jupyter serverextension enable --py jupyterlab_git"

# Install github extension on jupyterlab
RUN /bin/bash -c "source ~/.bashrc && \
    jupyter labextension install @jupyterlab/github && \
    pip --no-cache-dir install jupyterlab_github~=0.7.0 && \
    jupyter serverextension enable --sys-prefix jupyterlab_github"

# Install packages
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/requirements.txt -o requirements.txt
RUN /bin/bash -c "source ~/.bashrc && pip --no-cache-dir install -r requirements.txt"
RUN rm requirements.txt

# Copy jupyter password
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/jupyter_notebook_config.py -o /root/.jupyter/jupyter_notebook_config.py

RUN apt-get update && apt-get install -yq --no-install-recommends \
    build-essential \
    emacs \
    inkscape \
    jed \
    libsm6 \
    libxext-dev \
    libxrender1 \
    lmodern \
    nano \
    netcat \
    pandoc \
    python-dev \
    ffmpeg

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

# Set default work directory
RUN mkdir /workspace
WORKDIR /workspace

RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/tutorial_change_passwd.ipynb -o /workspace/tutorial_change_passwd.ipynb

CMD /bin/bash -c "source ~/.bashrc && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root"
