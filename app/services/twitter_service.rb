# see http://stackoverflow.com/questions/5460862/caching-twitter-api-calls-in-rails
class TwitterService

  def self.get_timeline
    account = ENV['TWITTER_ACCOUNT']

    client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end

    Rails.cache.fetch("#{account}_tweets", :expires_in => 5.minutes) do
      begin
        # Note the Twitter API applies the 'count' filter before any other filters,
        # therefore, the below may return anything between 0 and 10 tweets.
        tweets = client.user_timeline(account, :count => 10, :exclude_replies => true)

        tweets = tweets[0..1]
      rescue => e
        return [Twitter::Tweet.new({:id => -1, :text => "Error fetching tweets: #{e.message}"})]
      end
    end
  end

end
