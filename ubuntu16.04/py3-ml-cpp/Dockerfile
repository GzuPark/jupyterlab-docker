FROM gzupark/jupyterlab:xenial-py3-ml

RUN apt-get update

# Install C++ kernel
# https://github.com/QuantStack/xeus-cling
RUN /bin/bash -c "source ~/.bashrc && conda install xeus-cling -c conda-forge"

# Clean up
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

CMD /bin/bash -c "source ~/.bashrc && jupyter lab --ip=0.0.0.0 --port=8888 --no-browser --notebook-dir=/workspace --allow-root"
