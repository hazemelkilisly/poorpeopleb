class HomeController < ApplicationController
	def index
		twitter_feeds = Feedzirra::Feed.fetch_and_parse("http://search.twitter.com/search.rss?q=%23charity")
		if twitter_feeds == 0 || twitter_feeds == nil
			@twitter_feeds = nil
		else
			if(twitter_feeds.entries.count >= 3)
				@twitter_feeds = twitter_feeds.entries.sort {|a,b| a.published <=> b.published}.take(3)
			else
				@twitter_feeds = twitter_feeds.entries.sort {|a,b| a.published <=> b.published}
			end
		end
		@most_given_cases = Case.all.sort {|a,b| b.loans.count <=> a.loans.count}.take(3)
		@newest_cases = Case.all.sort {|a,b| b.created_at <=> a.created_at}.take(3)
		# @twitter_feeds = "hello world"
	end
end
