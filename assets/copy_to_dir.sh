#!/bin/bash

path=$(cd "$(dirname "$1")" && pwd)

xenial=ubuntu16.04
bionic=ubuntu18.04
python=py3

BASEPATH="$path/$xenial/$python/ $path/$xenial/gpu-$python/ $path/$bionic/$python/ $path/$bionic/gpu-$python/"
MLPATH="$path/$xenial/$python-ml/ $path/$xenial/gpu-$python-ml/"

echo "$BASEPATH" | xargs -n 1 cp -v $path/assets/jupyter_notebook_config.py
echo "$BASEPATH" | xargs -n 1 cp -v $path/assets/tutorial_change_passwd.ipynb
echo "$BASEPATH" | xargs -n 1 cp -v $path/assets/requirements.txt
echo "$MLPATH" | xargs -n 1 cp -v $path/assets/requirements-ml.txt
