require 'securerandom'

module BenchmarkUtils
  def self.generate_user_action(i)
    {
      user_id: SecureRandom.uuid,
      action: i % 10,
      performed_at: Time.now - i # minus seconds
    }
  end
end 