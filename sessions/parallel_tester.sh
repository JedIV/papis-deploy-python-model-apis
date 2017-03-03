#!/bin/sh

ab -n 10   -c 10 -p /users/jediv/data.json -T application/json 127.0.0.1:5000/predict &
ab -n 1000 -c 10 -q 127.0.0.1:5000/
