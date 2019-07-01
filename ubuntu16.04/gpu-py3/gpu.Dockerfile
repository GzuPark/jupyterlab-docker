FROM nvidia/cuda:9.0-cudnn7-runtime-ubuntu16.04

RUN apt-get update && apt-get install -y \
    apt-utils \
    wget \
    unzip \
    curl \
    bzip2 \
    git

ENV PYTHON_VERSION 3.7
ENV CONDA_ENV_NAME jupyterlab
ENV LANG C.UTF-8

# Python installation with useful pakages automatically
RUN apt-get install -y \
    python3 \
    python3-pip

RUN pip3 --no-cache-dir install --upgrade \
    pip \
    setuptools

RUN ln -s $(which python3) /usr/local/bin/python

# Installation miniconda3
RUN curl -sSL http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh
RUN bash /tmp/miniconda.sh -bfp /usr/local
RUN rm -rf /tmp/miniconda.sh

ENV PATH=/miniconda/bin:${PATH}

# Set up conda environment
RUN conda update -y conda
RUN conda create -n ${CONDA_ENV_NAME} python=${PYTHON_VERSION}
RUN echo "source activate ${CONDA_ENV_NAME}" > ~/.bashrc
ENV PATH /opt/conda/envs/${CONDA_ENV_NAME}/bin:$PATH
RUN /bin/bash -c "source activate ${CONDA_ENV_NAME}"

# Install jupyter and notebook extension
RUN conda install jupyter ipywidgets
RUN jupyter nbextension enable --py widgetsnbextension

# Install jupyterlab
RUN conda install jupyterlab
RUN jupyter serverextension enable --py jupyterlab

# Install packages
RUN pip --no-cache-dir install \
    numpy \
    pandas \
    matplotlib \
    pillow

# Copy jupyter password
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/jupyter_notebook_config.py -o /root/.jupyter/jupyter_notebook_config.py

# Clean up
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

# Set default work directory
RUN mkdir /workspace
WORKDIR /workspace

RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/tutorial_change_passwd.ipynb -o /workspace/tutorial_change_passwd.ipynb

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/workspace", "--allow-root"]
