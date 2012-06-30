express = require('express')
redis = require('redis-url').connect(process.env.REDISTOGO_URL);

app = express.createServer();

app.configure () ->
  app.use express.bodyParser()
  app.use express.methodOverride()

app.get '/',(req, res) ->
  res.send 'project info'

app.put '/api/:key',(req, res) ->
  redis.set req.params.key, JSON.stringify(req.body)
  res.end()

app.get '/api/:key',(req, res) ->
  redis.get req.params.key, (err, value) ->
    if err?
      res.writeHead 500
      res.end "api error"
    else if not value?
      res.writeHead 404
      res.end "no data"
    else
      res.writeHead 200, {'Content-Type': 'application/json'}
      res.end value


app.listen(3000);
