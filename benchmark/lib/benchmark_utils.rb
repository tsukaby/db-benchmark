require 'securerandom'

module BenchmarkUtils
  CAPITALS = [
    "Tokyo",
    "London",
    "Paris",
    "Berlin",
    "Washington",
    "Beijing",
    "Moscow",
    "Rome",
    "Madrid",
    "Seoul",
  ].freeze

  def self.generate_temperature_log(i)
    {
      device_id: "device_#{SecureRandom.hex(4)}",
      location: CAPITALS[i % CAPITALS.size],
      temperature: rand(-5..40.0).round(1),
      unit: 'C',
      created_at: Time.now - i # minus seconds
    }
  end
end 