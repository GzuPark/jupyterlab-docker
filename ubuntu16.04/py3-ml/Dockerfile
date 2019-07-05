FROM gzupark/jupyterlab:xenial-py3

RUN apt-get update

# Install packages
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/requirements-ml.txt -o requirements.txt
RUN /bin/bash -c "source ~/.bashrc && pip --no-cache-dir install -r requirements.txt"
RUN rm requirements.txt

# Install deep learning packages
RUN /bin/bash -c "source ~/.bashrc && \
    pip --no-cache-dir install tensorflow~=1.14.0 keras~=2.2.4"
RUN /bin/bash -c "source ~/.bashrc && \
    conda install -y pytorch-cpu~=1.1.0 torchvision-cpu~=0.3.0 -c pytorch"

# Install jupyterlab tensorboard
RUN /bin/bash -c "source ~/.bashrc && \
    pip --no-cache-dir install -U tensorboard~=1.14.0 jupyter-tensorboard~=0.1.10 && \
    jupyter labextension install jupyterlab_tensorboard"

# Clean up
RUN apt-get update && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

CMD /bin/bash -c "source ~/.bashrc && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root"
