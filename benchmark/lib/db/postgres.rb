require 'pg'
require 'benchmark'
require_relative '../benchmark_utils'

module DB
  class Postgres
    def initialize
      @conn = PG.connect(
        host: ENV.fetch('POSTGRES_HOST', 'localhost'),
        port: ENV.fetch('POSTGRES_PORT', '5432'),
        dbname: ENV.fetch('POSTGRES_DB', 'benchmark'),
        user: ENV.fetch('POSTGRES_USER', 'postgres'),
        password: ENV.fetch('POSTGRES_PASSWORD', 'postgres')
      )
    end

    def wait_for_connection
      max_retries = 30
      retry_count = 0
      sleep_time = 2

      loop do
        begin
          @conn.exec('SELECT 1')
          puts "PostgreSQL is ready!"
          break
        rescue PG::Error => e
          retry_count += 1
          if retry_count >= max_retries
            puts "Failed to connect to PostgreSQL after #{max_retries} attempts"
            raise e
          end
          puts "Waiting for PostgreSQL... (attempt #{retry_count}/#{max_retries})"
          sleep sleep_time
        end
      end
    end

    def insert_actions(count)
      time = Benchmark.realtime do
        count.times do |i|
          action = BenchmarkUtils.generate_user_action(i)
          @conn.exec_params(
            'INSERT INTO user_actions (performed_at, user_id, action) VALUES ($1, $2, $3)',
            [action[:performed_at], action[:user_id], action[:action]]
          )
        end
      end
      time.round(4)
    end

    def close
      @conn.close
    end
  end
end
