require("src/HTTP")
require("src/BasicServer")

function test_app(req, res)
  if isequal(req.path, "/")
    return "Body"
  elseif isequal(req.path, "/error")
    return [500, "Special error\n"]
  else
    return false
  end
end

function test_middleware1(app)
  return function(req, res)
    ret = HTTP.Util.wrap_app(app, req, res)
    res.body *= " (Middlewar1'ed!)"
    return ret
  end
end

function test_middleware2(app)
  return function(req, res)
    ret = HTTP.Util.wrap_app(app, req, res)
    res.body *= " (Middlewar2'ed!)"
    return ret
  end
end


BasicServer.bind(8000, test_middleware1(test_middleware2(test_app)), true)

