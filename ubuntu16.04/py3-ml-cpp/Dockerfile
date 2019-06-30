FROM gzupark/jupyterlab:xenial-py3-ml

ENV PYTHON_VERSION 3.7
ENV CONDA_ENV_NAME jupyterlab
ENV LANG C.UTF-8

RUN apt-get update

RUN /bin/bash -c "source activate ${CONDA_ENV_NAME}"

# Install C++ kernel
# https://github.com/QuantStack/xeus-cling
RUN conda install xeus-cling -c conda-forge

# Clean up
RUN apt-get update \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN conda clean --all --yes

# Expose port & cmd
EXPOSE 8888

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--notebook-dir=/workspace", "--allow-root"]
