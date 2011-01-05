require 'rubygems'
require 'redis'

class RedisEg
  def self.run
    redis = Redis.new

    puts '#---[ Strings ]---------------------------------------------------------'

    print "* Set key 'mystring' to value 'myvalue': "
    redis.set :mystring, 'myvalue'
    puts redis.get :mystring

    print "* Type of key 'mystring': "
    puts redis.type :mystring

    print "* Exists key 'mystring': "
    puts redis.exists :mystring

    print "* Delete key 'mystring': "
    puts redis.del :mystring

    puts '#---[ Lists ]-----------------------------------------------------------'

    print "* Add items to list: "
    redis.del :mylist
    redis.rpush :mylist, 'a'
    redis.rpush :mylist, 'b'
    redis.rpush :mylist, 'c'
    p redis.lrange(:mylist, 0, -1)

    print "* Pop item from list: "
    p redis.lpop :mylist

    print "* Length of list: "
    p redis.llen :mylist

    puts '#---[ Sets ]------------------------------------------------------------'

    print "* Add items to set: "
    redis.del :myset
    redis.sadd :myset, 'apple'
    redis.sadd :myset, 'banana'
    redis.sadd :myset, 'cherry'

    print "* Item 'cherry' exists in set: "
    p redis.sismember :myset, 'cherry'

    print "* Insert duplicate item into set: "
    p redis.sadd :myset, 'cherry'

    puts '#---[ Sorted sets ]-----------------------------------------------------'

    print "* Add scored items: "
    redis.del :myzset
    redis.zadd :myzset, 30, 'thirty'
    redis.zadd :myzset, 10, 'ten'
    redis.zadd :myzset, 20, 'twenty'
    p redis.zrange :myzset, 0, -1

    print "* Items with scores from 0 to 20: "
    p redis.zrangebyscore :myzset, 0, 20

    puts '#---[ Hash ]------------------------------------------------------------'

    print "* Add hash item: "
    redis.del :myhash
    redis.mapped_hmset 'myhash', {
      :name => 'Benjamin Willard', 
      :rank => 'Captain'
    }
    p redis.hgetall :myhash

    print "* Get field for item: "
    puts redis.hget :myhash, 'name'
  end
end
