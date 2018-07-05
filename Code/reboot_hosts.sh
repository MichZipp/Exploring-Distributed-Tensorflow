#!/bin/bash
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow0 'sudo reboot'
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow1 'sudo reboot'
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow2 'sudo reboot'
ssh -i key.pem -oStrictHostKeyChecking=no clouduser@tensorflow3 'sudo reboot'
