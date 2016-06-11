class PlayWorker
	include Sidekiq::Worker
	include Sidetiq::Schedulable
	sidekiq_options retry: false
	tiq { hourly.minute_of_hour(0,3,6,9,12,15,18,21,24,27,30,33,36,39,42,45,48,51,54,57) }

	def perform
		Play.start_play
	end
end