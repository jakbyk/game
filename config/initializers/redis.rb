require "redis"

if ENV["REDIS_URL"]
  uri = URI.parse(ENV["REDIS_URL"])
  $redis = Redis.new(
    host: uri.host,
    port: uri.port,
    password: uri.password,
    ssl: uri.scheme == "rediss"
  )
else
  $redis = Redis.new(host: "localhost", port: 6379, db: 1)
end
