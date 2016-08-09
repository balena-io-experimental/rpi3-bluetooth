# rpi3-bluetooth
Raspberry Pi 3 on-board Bluetooth example

This project enables bluetooth and demonstrates some simple commands to interract
with a bluetooth device.

To get this project up and running, you will need to signup for a [resin.io](https://resin.io/) account [here](https://dashboard.resin.io/signup) and set up a Raspberry Pi 3, have a look at our [Getting Started Tutorial](http://docs.resin.io/raspberrypi/nodejs/getting-started/) if you haven't already. Once you are set up with resin.io, you will need to clone this repo locally:

```
$ git clone https://github.com/resin-io-projects/rpi3-bluetooth.git
```
Then add your resin.io application's remote repository to your local repository:

```
$ git remote add resin username@git.resin.io:username/myapp.git
```
and push the code to the newly added remote:

```
$ git push resin master
```
It should take a few minutes for the code to push. Once the code has pushed the `scan.sh` script will enable the on-board Bluetooth, you should see this in your logs:

![Alt text](logs.png?raw=true "Logs")

To test everything works you will need to run some simple commands to scan for devices, connect to a device, discover characteristics and write to a characteristic.

Scan for devices:
```
$ hcitool lescan
LE Scan ...
18:B4:30:51:4C:E5 (unknown)
66:53:B2:89:24:D3 (unknown)
66:53:B2:89:24:D3 (unknown)
EE:50:F0:F8:3C:FF resin
EE:50:F0:F8:3C:FF (unknown)
18:B4:30:51:4C:E5 Nest Cam
```
the output shows 6 devices found, we are going to connect to the `EE:50:F0:F8:3C:FF resin` device:
```
$ gatttool -b EE:50:F0:F8:3C:FF -t random -I
[EE:50:F0:F8:3C:FF][LE]>
```
at the prompt enter `connect` to connect to the device:
```
[EE:50:F0:F8:3C:FF][LE]>connect
Attempting to connect to EE:50:F0:F8:3C:FF
Connection successful
[EE:50:F0:F8:3C:FF][LE]>
```
at the prompt enter `char-desc` to discover characteristics advertised by the device:
```
[EE:50:F0:F8:3C:FF][LE]> char-desc
handle: 0x0001, uuid: 00002800-0000-1000-8000-00805f9b34fb
handle: 0x0002, uuid: 00002803-0000-1000-8000-00805f9b34fb
handle: 0x0003, uuid: 00002a00-0000-1000-8000-00805f9b34fb
handle: 0x0004, uuid: 00002803-0000-1000-8000-00805f9b34fb
```
the output shows 4 characteristics found, we are going to write to the characteristic at `handle: 0x0004, uuid: 00002803-0000-1000-8000-00805f9b34fb`. At the prompt enter `char-write-req 04 01` to write a `1` to the characteristic:
```
[EE:50:F0:F8:3C:FF][LE]> char-write-req 04 01
Characteristic value was written successfully
```
finally we need to close the connection, enter `disconnect` at the prompt:
```
[EE:50:F0:F8:3C:FF][LE]> disconnect
[EE:50:F0:F8:3C:FF][LE]>
```
followed by `Ctrl + D` to exit gatttool.
