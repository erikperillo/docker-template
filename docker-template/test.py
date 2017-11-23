from tensorflow.python.client import device_lib
import tensorflow as tf
import subprocess as sp
import os

def test_tf():
    print("----TENSORFLOW TEST----")
    local_device_protos = device_lib.list_local_devices()
    devices = [x.name for x in local_device_protos if x.device_type == "GPU"]
    print("tensorflow version:", tf.__version__)
    print("tensorflow devices:", devices)
    print("----TENSORFLOW TEST DONE----")

def test_gpu():
    print("----GPU TEST----")
    print("running nvidia-smi...")
    sp.check_call(["nvidia-smi"])
    print("recommended GPU driver version:",
        os.environ["NVIDIA_RECOMMENDED_DRIVER_VERSION"])
    print("----GPU TEST DONE----")

def main():
    test_gpu()
    test_tf()

if __name__ == "__main__":
    main()
