#!/bin/bash

REASON=$1
STACK_NAME=$2
VERSION=$3

if [[ -z $STACK_NAME || -z $REASON ]];then
  echo "Usage: $0 '<reason>' <stack name> <version (optional)>"
  exit 0
fi

LINES=$(senza inst | grep $STACK_NAME)

if [[ "$VERSION" ]]; then
  LINES=$(echo -e "$LINES" | awk '$2 == '$VERSION' { print $0 }')
fi

LINE=$(echo -e "$LINES" | head -1)
REAL_STACK_NAME=$(echo $LINE | awk '{ print $1; }')
IP=$(echo $LINE | awk '{ print $5; }')

if [[ -z $IP ]]; then
  echo "No matching instance"
  exit 1
fi

echo "Connecting to $REAL_STACK_NAME ($IP) ..."

piu $IP "$REASON" -O odd-eu-central-1.dc.zalan.do --connect
