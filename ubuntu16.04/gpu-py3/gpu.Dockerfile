FROM nvidia/cuda:10.1-cudnn7-runtime-ubuntu16.04

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
RUN /bin/bash -c "source ~/.bashrc && conda install -y jupyter ipywidgets && jupyter nbextension enable --py widgetsnbextension"

# Install jupyterlab
RUN /bin/bash -c "source ~/.bashrc && conda install -y jupyterlab && jupyter serverextension enable --py jupyterlab"

# Install packages
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/requirements.txt -o requirements.txt
RUN /bin/bash -c "source ~/.bashrc && pip --no-cache-dir install -r requirements.txt"
RUN rm requirements.txt

# Copy jupyter password
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/jupyter_notebook_config.py -o /root/.jupyter/jupyter_notebook_config.py

# Clean up
RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

# Set default work directory
RUN mkdir /workspace
WORKDIR /workspace

RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/tutorial_change_passwd.ipynb -o /workspace/tutorial_change_passwd.ipynb

CMD /bin/bash -c "source ~/.bashrc && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root"
