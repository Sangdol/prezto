#!/bin/bash

set -e

REASON=$1
STACK_NAME=$2
VERSION=$3

if [[ -z $STACK_NAME || -z $REASON ]];then
  echo "Usage: $0 '<reason>' <stack name> <version (optional)>"
  exit 0
fi

echo "Senza instant..."
LINES=$(senza inst | awk '$1 ~ "'$STACK_NAME'" { print $0 }')
echo "$LINES"

if [[ "$VERSION" ]]; then
  LINES=$(echo -e "$LINES" | awk '$2 == '$VERSION' { print $0 }')
fi

LINE=$(echo -e "$LINES" | head -1)
REAL_STACK_NAME=$(echo $LINE | awk '{ print $1 }')
IP=$(echo $LINE | awk '{ print $5 }')

if [[ -z $IP ]]; then
  echo "No matching instance"
  exit 1
fi

echo "Connecting to $REAL_STACK_NAME ($IP) ..."

piu $IP "$REASON" -O odd-eu-central-1.dc.zalan.do --connect
