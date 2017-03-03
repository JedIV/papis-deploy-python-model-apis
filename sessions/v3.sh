# Lets run the flask app using the power of UNICORN
cd ~/repos/papis-deploy-python-model-apis

gunicorn -w 3 -b 127.0.0.1:5000 -k gevent api:app &

echo

redis-server &

echo

CELERY_WORKER=true celery worker -A predict_celery:celery -c 3 &

echo

# lets do our speed check
ab -n 10 -c 10 -p ~/data.json -T application/json 127.0.0.1:5000/predict


# A little slower... but did we improve when taking multiple types of requests?
# Run that baby
sh  ~/repos/sessions/parallel_tester.sh > ~/repos/sessions/test_celery.txt

# Check the results
vim ~/repos/sessions/test_celery.txt

# Shut everything down
ps aux | grep -e gunicorn -e redis -e celery | awk '{print $2;}' | xargs kill -9 2>/dev/null
