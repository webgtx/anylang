local curl = require("cURL")

c = curl.easy{
  url        = "http://dsx.ninja"
}

c:perform()
