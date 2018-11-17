# Docker image for SAP HANA Express Edition
## Usage
```
docker run -t --name hxe --hostname hxehost --env MASTER_PWD=AdmPass1 \
    -p 39013:39013 -p 39015:39015 -p 39017:39017 -p 39041-39045:39041-39045 -p 1128-1129:1128-1129 -p 59013-59014:59013-59014 \
    muxob/hana-express
```
The installation takes about 20 min. It is done, when you see in the console
```
#########################################################################
# Summary after execution 						#
#########################################################################
Server Installation...(OK)
XSC Installation...(OK)
HXE Optimization...(OK)


Congratulations! SAP HANA, express edition 2.0 is installed.
See https://www.sap.com/developer/tutorials/hxe-ua-getting-started-binary.html to get started.
```
then the container exits and you can start it as usual.
```
docker start hxe
```
