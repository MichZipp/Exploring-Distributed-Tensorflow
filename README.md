# Exploring Distributed Tensorflow
## Virtuelle Maschinen mit Ubuntu
* Änderungen des VM Namen:
    * `sudo nano /etc/hostname`
    * `sudo nano /etc/hosts`
    * Füge folgenede Zeilen ein:
        ```
        141.28.106.55 tensorflow0
        141.28.106.56 tensorflow1
        141.28.106.6 tensorflow2
        141.28.106.6 tensorflow3
        ```
* Installation von Python:
    * `sudo apt-get update` 
    * `sudo apt-get install python3-pip python3-dev` 
* Installation von Tensorflow:
    * `pip3 install tensorflow`


## Quellen:
* https://mesosphere.com/blog/tensorflow-gpu-support-deep-learning/