class RefillMoneyWorker
	include Sidekiq::Worker
	sidekiq_options retry: false

	def perform
		Player.refill_money
	end
end