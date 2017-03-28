#!/bin/bash
make gcc
./prog | hexdump -C
