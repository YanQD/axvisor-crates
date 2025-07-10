#!/bin/bash

cmd=$1

if [ -z $cmd ]; then
    echo "Usage: $0 <init|pull>"
    exit 1
fi

ROOT=https://github.com/arceos-hypervisor
REPOS=(
    "arm_vcpu"
    "arm_vgic"
    "arm_gicv2"
    "x86_vcpu"
    "x86_vlapic"
    "riscv_vcpu"
    "axvisor_api"
    "axaddrspace"
)

mkdir -p crates

for repo in ${REPOS[@]};
do
    if [ $cmd == "init" ]; then
        git submodule add $ROOT/$repo.git crates/$repo
    elif [ $cmd == "pull" ]; then
        pushd crates/$repo > /dev/null
        git pull origin main
        popd > /dev/null
    else
        echo "Invalid command: $cmd"
        exit 1
    fi
done
