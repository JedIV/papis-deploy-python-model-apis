# Lets run the flask app using the power of UNICORN
cd ~/repos/papis-deploy-python-model-apis

gunicorn -w 3 -b :5000 api:app &

echo


# Lets test how fast it takes to be scored 10 times
ab -n 10 -p ~/data.json -T application/json 127.0.0.1:5000/predict

# Lets test how fast it takes to be scored 10 times while allowing for concurrency.
ab -n 10 -c 10 -p ~/data.json -T application/json 127.0.0.1:5000/predict

# How about 1000 at our base app while allowing for concurrency?
ab -n 1000 -c 10 -T application/json 127.0.0.1:5000/

# Cool! That's super speedy. But wait... What if some customers are asking for only
# the base response, while others are asking for the actual prediction? What happens then?

# Lets make a file that tests both the predict and the base endpoint
# in parallel
vim ~/repos/sessions/parallel_tester.sh

# Run that baby
sh  ~/repos/sessions/parallel_tester.sh > ~/repos/sessions/test_unicorn.txt

# Check the results
vim ~/repos/sessions/test_unicorn.txt

# We have to kill gunicorn in kind of a clumsy fashion since it's running in the background
# A more optimal way to do it would be to use a supervisor but that's for a different talk.
ps aux | grep gunicorn | awk '{print $2;}' | xargs kill -9 2>/dev/null
