class PlayWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform
		Play.start_play
	end
end