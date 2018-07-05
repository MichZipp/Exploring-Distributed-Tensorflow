#!/bin/bash
echo "Start Copy!"
scp -i key.pem -oStrictHostKeyChecking=no trainer.py clouduser@tensorflow0:~/Tensorflow
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow0 'sudo rm key.pem'
scp -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow0:~/Tensorflow
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow0 'chmod 400 ~/Tensorflow/key.pem'
scp -i key.pem -oStrictHostKeyChecking=no run_2worker_1ps.sh clouduser@tensorflow0:~/Tensorflow
scp -i key.pem -oStrictHostKeyChecking=no run_3worker_1ps.sh clouduser@tensorflow0:~/Tensorflow
scp -i key.pem -oStrictHostKeyChecking=no trainer.py clouduser@tensorflow1:~/Tensorflow
scp -i key.pem -oStrictHostKeyChecking=no trainer.py clouduser@tensorflow2:~/Tensorflow
scp -i key.pem -oStrictHostKeyChecking=no trainer.py clouduser@tensorflow3:~/Tensorflow
echo "End Copy!"