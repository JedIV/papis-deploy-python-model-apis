#!/bin/sh

ab -n 10   -c 10 -p /users/jediv/data.json -T application/json 104.236.221.231:5000/predict &
ab -n 1000 -c 10 -q 104.236.221.231:5000/
