#!/bin/sh

#if [ $# -ne 1 ]; then
#    echo "Syntax: $0 <pvc name>"
#    echo "Eg:  $0 awesome-webserver-e9847e22d033
#    exit 1
#fi
PVC=workshop-base-c80ea6216401
DS=workshop-base
DV=${PVC}

oc label pvc ${PVC} \
   instancetype.kubevirt.io/default-instancetype=u1.small \
   instancetype.kubevirt.io/default-preference=fedora

oc label datasource ${DS} \
   instancetype.kubevirt.io/default-instancetype=u1.small \
   instancetype.kubevirt.io/default-preference=fedora

oc label datasource ${DS}-amd64 \
   instancetype.kubevirt.io/default-instancetype=u1.small \
   instancetype.kubevirt.io/default-preference=fedora

oc label datavolume ${DV} \
   instancetype.kubevirt.io/default-instancetype=u1.small \
   instancetype.kubevirt.io/default-preference=fedora \
