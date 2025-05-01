require 'influxdb-client'
require 'net/http'
require 'benchmark'
require_relative '../benchmark_utils'

module DB
  class InfluxDB
    def initialize
      host = ENV.fetch('INFLUXDB_HOST', 'localhost')
      port = ENV.fetch('INFLUXDB_PORT', '8086')
      @client = InfluxDB2::Client.new(
        "http://#{host}:#{port}",
        ENV.fetch('INFLUXDB_TOKEN', 'benchmark-token'),
        org: ENV.fetch('INFLUXDB_ORG', 'benchmark'),
        bucket: ENV.fetch('INFLUXDB_BUCKET', 'user_actions'),
        precision: InfluxDB2::WritePrecision::SECOND,
        use_ssl: ENV.fetch('INFLUXDB_USE_SSL', 'false') == 'true'
      )
      @write_api = @client.create_write_api
    end

    def wait_for_connection
      max_retries = 30
      retry_count = 0
      sleep_time = 2
      host = ENV.fetch('INFLUXDB_HOST', 'localhost')
      port = ENV.fetch('INFLUXDB_PORT', '8086')
      uri = URI("http://#{host}:#{port}/health")

      loop do
        begin
          response = Net::HTTP.get_response(uri)
          if response.is_a?(Net::HTTPSuccess)
            puts "InfluxDB is ready!"
            break
          end
        rescue StandardError => e
          retry_count += 1
          if retry_count >= max_retries
            puts "Failed to connect to InfluxDB after #{max_retries} attempts"
            raise e
          end
          puts "Waiting for InfluxDB... (attempt #{retry_count}/#{max_retries})"
          sleep sleep_time
        end
      end
    end

    def insert_actions(count)
      time = Benchmark.realtime do
        count.times do |i|
          action = BenchmarkUtils.generate_user_action(i)
          point = InfluxDB2::Point.new(name: 'user_action')
            .add_tag('user_id', action[:user_id])
            .add_field('action', action[:action])
            .time(action[:performed_at], InfluxDB2::WritePrecision::SECOND)

          @write_api.write(data: point)
        end
      end
      time.round(4)
    end

    def close
      @client.close!
    end
  end
end
