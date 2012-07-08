express = require('express')
redis = require('redis-url').connect(process.env.REDISTOGO_URL);

app = express.createServer();

app.configure () ->
  app.use express.bodyParser()
  app.use express.methodOverride()

app.get '/',(req, res) ->
  #do 301 to the repo
  res.writeHead(301, {'Location':'https://github.com/gotbadger/simple-notification-server', 'Expires': (new Date).toGMTString()});
  res.end();
  

app.put '/api/:key',(req, res) ->
  console.log req.params.key
  console.log req.body
  res.send 'ok'

app.get '/api/:key',(req, res) ->
  redis.get req.params.key, (err, value) ->
    if err? then return res.send ""
    res.send value 

# put
# get

app.listen(3000);
