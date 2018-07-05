#!/bin/bash
echo "Starting trainer.py on Targets!"
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow3 'python3 ~/Tensorflow/trainer.py --ps_hosts="tensorflow3:2222" --worker_hosts="tensorflow0:2222,tensorflow1:2222,tensorflow2:2222" --job_name="ps" --task_index=0 &'
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow2 'python3 ~/Tensorflow/trainer.py --ps_hosts="tensorflow3:2222" --worker_hosts="tensorflow0:2222,tensorflow1:2222,tensorflow2:2222" --job_name="worker" --task_index=2 &'
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow1 'python3 ~/Tensorflow/trainer.py --ps_hosts="tensorflow3:2222" --worker_hosts="tensorflow0:2222,tensorflow1:2222,tensorflow2:2222" --job_name="worker" --task_index=1 &'
python3 ~/Tensorflow/trainer.py \
    --ps_hosts="tensorflow3:2222" \
    --worker_hosts="tensorflow0:2222,tensorflow1:2222,tensorflow2:2222" \
    --job_name="worker" \
    --task_index=0 &
echo "Done!"