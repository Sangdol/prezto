#!/bin/bash

STACK_NAME=$1
REASON=$2

if [[ -z $STACK_NAME || -z $REASON ]];then
  echo "Usage: $0 <stack name> '<reason>'"
  exit 0
fi

#zaws
LINE=$(senza inst | grep $STACK_NAME)
REAL_STACK_NAME=$(echo $LINE | awk '{ print $1; }')
IP=$(echo $LINE | awk '{ print $5; }')

echo "Connecting to $REAL_STACK_NAME ($IP) ..."

piu $IP "$REASON" -O odd-eu-central-1.dc.zalan.do --connect
