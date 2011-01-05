require 'rubygems'
require 'redis'

class RedisEg
  def self.run
    redis = Redis.new

    puts '#---[ Strings ]---------------------------------------------------------'

    print "* Set key 'mystring' to value 'myvalue': "
    redis.set :mystring, 'myvalue'
    puts redis.get :mystring
    # => myvalue

    print "* Type of key 'mystring': "
    puts redis.type :mystring
    # => string

    print "* Exists key 'mystring': "
    puts redis.exists :mystring
    # => true

    print "* Delete key 'mystring': "
    puts redis.del :mystring
    # => 1

    puts '#---[ Lists ]-----------------------------------------------------------'

    print "* Add items to list: "
    redis.del :mylist
    redis.rpush :mylist, 'a'
    redis.rpush :mylist, 'b'
    redis.rpush :mylist, 'c'
    p redis.lrange(:mylist, 0, -1)
    # => ["a", "b", "c"]

    print "* Pop item from list: "
    p redis.lpop :mylist
    # => "a"

    print "* Length of list: "
    p redis.llen :mylist
    # => 2

    puts '#---[ Sets ]------------------------------------------------------------'

    print "* Add items to set: "
    redis.del :myset
    redis.sadd :myset, 'apple'
    redis.sadd :myset, 'banana'
    redis.sadd :myset, 'cherry'
    p redis.smembers :myset
    # => ["cherry", "banana", "apple"]

    print "* Item 'cherry' exists in set: "
    p redis.sismember :myset, 'cherry'
    # => true

    print "* Insert duplicate item into set: "
    p redis.sadd :myset, 'cherry'
    # => false

    puts '#---[ Sorted sets ]-----------------------------------------------------'

    print "* Add scored items: "
    redis.del :myzset
    redis.zadd :myzset, 30, 'thirty'
    redis.zadd :myzset, 10, 'ten'
    redis.zadd :myzset, 20, 'twenty'
    p redis.zrange :myzset, 0, -1
    # => ["ten", "twenty", "thirty"]

    print "* Items with scores from 0 to 20: "
    p redis.zrangebyscore :myzset, 0, 20
    # => ["ten", "twenty"]

    puts '#---[ Hash ]------------------------------------------------------------'

    print "* Add hash item: "
    redis.del :myhash
    redis.mapped_hmset 'myhash', {
      :name => 'Portland Ruby Brigade', 
      :abbreviation => 'pdxruby'
    }
    p redis.hgetall :myhash
    # => {"name"=>"Portland Ruby Brigade", "abbreviation"=>"pdxruby"}

    print "* Get field for item: "
    puts redis.hget :myhash, 'abbreviation'
    # => pdxruby
  end
end
