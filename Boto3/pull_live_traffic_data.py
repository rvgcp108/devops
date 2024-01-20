import requests


url_api = 'https://www.credilio.in'

us_req = requests.get(url_api)

us_json = usa_req.json()


# Do something with the json response to prove it works. 

print(us_json)


## please install requests
## pip3 install requests

