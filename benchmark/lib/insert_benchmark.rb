require_relative 'db/postgres'
require_relative 'db/influxdb'

# Init database
postgres = DB::Postgres.new
influxdb = DB::InfluxDB.new
postgres.wait_for_connection
influxdb.wait_for_connection

insert_count = ENV.fetch('INSERT_COUNT', '1000').to_i

# Run
pg_time = postgres.insert_actions(insert_count)
influx_time = influxdb.insert_actions(insert_count)

puts "PostgreSQL total execution time: #{pg_time} seconds"
puts "InfluxDB total execution time: #{influx_time} seconds"

# Release resources
postgres.close
influxdb.close
