require 'rubygems'
require 'sinatra'
require 'json'
require 'mysql2'

=begin
class API < Sinatra::Base

  beacon_id = "B9407F30-F5F8-466E-AFF9-25556B57FE6D" 

  configure do
    if ENV["REDISCLOUD_URL"] 
      uri = URI.parse(ENV["REDISCLOUD_URL"])
      $redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
    else
      $redis = Redis.new
    end
    $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:43875:58414", "Green")
    $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:61334:32857", "Purple")
    $redis.set("B9407F30-F5F8-466E-AFF9-25556B57FE6D:21137:30314", "Blue")
  end
=end
  get '/' do
    '<html><body><h1>Place-it!</h1></body></html>'
  end
=begin
  # Test locally w/ 'curl -i http://localhost:5000/rooms.json'
  #                 'curl -i http://localhost:5000/rooms.json\?beacon_id=abc\&maj_val\=1\&min_val\=1'
  get '/beacons.json' do
    content_type :json

    key = "#{params[:beacon_id]}:#{params[:maj_val]}:#{params[:min_val]}"
    beacon_name = $redis.get(key)
    if beacon_name.nil? 
      beacon_name = "Unknown"
    end

 
    # if params[:beacon_id] == beacon_id && params[:maj_val].to_i == 43875 && params[:min_val].to_i == 58414
    #   beacon_name = "Green"
    # elsif params[:beacon_id] == beacon_id && params[:maj_val].to_i == 61334 && params[:min_val].to_i == 32857
    #   beacon_name = "Purple"
    # elsif params[:beacon_id] == beacon_id && params[:maj_val].to_i == 21137 && params[:min_val].to_i == 30314
    #   beacon_name = "Blue"
    # else
    #   beacon_name = "Unknown"
    # end
 
    {:name => beacon_name,
     :beacon_id => params[:beacon_id],
     :maj_val => params[:maj_val].to_i,
     :min_val => params[:min_val].to_i}.to_json
  end

  get '/command' do
    @res= ''

    begin
      case params[:a]
        when 'set'
          @res = $redis.set('welcome_msg', 'Hello from Redis!')
        when 'get'
          @res = $redis.get('welcome_msg') || 'undefined'
        when 'info'
          $redis.info.each { |k, v| 
            @res += "#{k}: #{v}<br />" 
          }
        when 'flush'
          @res = $redis.flushall
      end
      
    rescue Redis::BaseConnectionError => e
      puts e.message
      @res = nil
    rescue SocketError => e
      puts e.message
      @res = nil
    end

    @res  
  end

end
 =end
 
