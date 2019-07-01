FROM gzupark/jupyterlab:xenial-gpu-py3

RUN apt-get update

# Install packages
RUN curl -sSL https://raw.githubusercontent.com/gzupark/jupyterlab-docker/master/assets/requirements-ml.txt -o requirements.txt
RUN /bin/bash -c "source ~/.bashrc && pip --no-cache-dir install -r requirements.txt"
RUN rm requirements.txt

# Install deep learning packages
RUN /bin/bash -c "source ~/.bashrc && pip install tensorflow-gpu"
RUN /bin/bash -c "source ~/.bashrc && conda install pytorch torchvision cudatoolkit=10.0 -c pytorch"

# Clean up
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Expose port & cmd
EXPOSE 8888

CMD /bin/bash -c "source ~/.bashrc && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root"
