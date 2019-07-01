# JupyterLab Dockerfiles

This is JupyterLab's Dockerfiles, create and deploy them to [my Docker Hub](https://hub.docker.com/r/gzupark/jupyterlab/).

Check the [full list of tags](https://hub.docker.com/r/gzupark/jupyterlab/tags/) for the available images.

## Image Description

Base OS is Ubuntu and use the Miniconda3 environment.

- Ubuntu
  - 16.04
  - (expected) 18.04
- GPU
  - CUDA 10.1
- Miniconda3
  - Python 3.7.3
    - numpy
    - pandas
    - matplotlib
    - pillow
- Machine Learning (ml)
  - scipy
  - scikit-learn
  - nltk
  - opencv-python
  - tensorflow==1.14.0
  - pytorch==1.1.0
- C++
  - xeus-cling

## Tag Rules

- `xenial`: Ubuntu16.04
- `-py3`: Python 3.7.3
- `-gpu`: enable to use CUDA
- `-ml`: pre-installed machine learning packages
- `-cpp`: enable to use C++ environment

## Running Containers

```sh
$ docker run -it --rm -p 8888:8888 gzupark/jupyterlab
```

Run a JupyterLab server, navigate to `localhost:8888` in your browser. Then, type default jupyter password which is `"jupyterlab"`, you can see the guide if you want to change it through `tutorial_change_passwd.ipynb` in the workspace.


Start a machine learning packages and C++ environment:
```sh
$ docker run -it --rm -p 8888:8888 gzupark/jupyerlab:py3-ml-cpp
```

Want to mount with your local machine:
```sh
$ docker run -it --rm -v $(realpath ~/project):/workspace -p 8888:8888 gzupark/jupyterlab
```

Want to use GPU version:
```sh
$ docker run -it --rm --runtime=nvidia -p 8888:8888 gzupark/jupyterlab:latest-gpu
```
