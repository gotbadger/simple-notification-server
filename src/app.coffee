express = require('express')

app = express.createServer();

app.configure () ->
    app.use express.bodyParser()
    app.use express.methodOverride()

app.get '/',(req, res) ->
    res.send 'hello world'

app.listen(3000);
