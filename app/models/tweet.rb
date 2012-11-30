class Tweet
  require 'twitter'
  
  Twitter.configure do |config|
    config.consumer_key = "EB0Dziomtr6sbbgqZT6Jg"
    config.consumer_secret = "VsAzXKkPGwhyQDv4noGF2CwQxiwa7mwQQxgqiBXhBA"
    config.oauth_token = "521825690-chCnkvedrvoR6UffKhhdsVElSYfCh9snSKn2LPZY"
    config.oauth_token_secret = "VAWlAbzFp1b0pDKZJ5iuJReTu0guMViCeFZKEWKuA"
  end
  
  def self.recent(entries=nil)
    begin
      tweets = Twitter.user_timeline("gesdoc", :count => entries)
    rescue
      tweets = []
    end
    
    tweets
  end
end