require 'twitter'
require 'yaml'

class TwitterApi
  attr_reader :client

  def initialize
    keys = YAML.load_file('application.yml')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = keys['CONSUMER_KEY']
      config.consumer_secret     = keys['CONSUMER_SECRET']
      config.access_token        = keys['ACCESS_TOKEN']
      config.access_token_secret = keys['ACCESS_TOKEN_SECRET']
    end
  end

  def most_recent_friend
    client.friends.first.name
  end

  def find_user_for(username)
    client.user(username).name
  end

  def find_followers_for(username)
    client.followers(username).take(10).collect { |user_data| user_data.name }
  end

  def homepage_timeline
    client.home_timeline.collect { |tweet_data| tweet_data.text}
  end

end

#Bonus:

# uncomment out the following and read the bonus instructions.
# remember to comment out the WebMock line of your spec_helper, as the instructions dictate.

tweet_client = TwitterApi.new
puts tweet_client.most_recent_friend
puts tweet_client.find_user_for("otherworldly_ao")
puts tweet_client.find_followers_for("otherworldly_ao")
puts tweet_client.homepage_timeline
