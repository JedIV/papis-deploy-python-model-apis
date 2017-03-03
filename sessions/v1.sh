#doitlive commentecho: true

# Move to working directory and set up our python virtual environment
cd ~/repos/papis-deploy-python-model-apis

# Lets look at the api file we will use with flask
vim api.py

# Now lets activate flask
FLASK_APP=api.py flask run &

echo

# And test our API:
curl -X POST localhost:5000/predict -H "Content-Type: application/json" -d '{"text": "I will NEVER stay in this hotel again!"}'

curl localhost:5000/

# And Shutdown the flask server
curl -X POST localhost:5000/shutdown

# Now that we know everything works, lets reactivate flask and do some more testing
FLASK_APP=api.py flask run &

echo

# Set up a basic data file
vim ~/data.json

# Lets test that file
curl -X POST localhost:5000/predict -H "Content-Type: application/json" -d @/users/jediv/data.json

# Lets test how fast it takes to be scored 10 times
ab -n 10 -p ~/data.json -T application/json 127.0.0.1:5000/predict

# How long does it take to return the simple response 10 times?
ab -n 10 -T application/json 127.0.0.1:5000/

# How about 1000 times?
ab -n 1000 -T application/json 127.0.0.1:5000/

# Don't forget to shut down the server when we're done with again
curl -X POST localhost:5000/shutdown


# All of this is well and good but where can we go from here?
