# DB Benchmark

A benchmarking tool for comparing the performance of various database systems.

## Overview

This project is a benchmarking tool for comparing the performance of different database systems. It can be easily executed in a Docker environment and simulates various workload patterns (write, read, update, etc.) to compare and analyze the characteristics of each database system.

## Features

- Performance comparison of multiple database systems
- Easy setup in Docker environment
- Customizable test parameters

## Supported Databases

- PostgreSQL
- InfluxDB

## Prerequisites

- Docker
- Docker Compose

## Setup and Execution

1. Clone the repository:
```bash
git clone https://github.com/yourusername/db-benchmark.git
cd db-benchmark
```

2. Configure environment variables (optional):
Create a `.env` file and set the following environment variables as needed:
```
INSERT_COUNT=10000  # Number of operations to execute
```

3. Start DB containers:
```bash
docker compose up --build
```

4. Run benchmarks:
```bash
docker compose run benchmark
```

5. (Option) If you want to delete your DB data, please execute the following command:
```bash
docker compose down --volumes
```

## Environment Variables

| Variable | Description | Default Value |
|----------|-------------|---------------|
| INSERT_COUNT | Number of data entries to insert | 1000 |

## License

This project is licensed under the [MIT License](LICENSE).

## Contributing

1. Fork this repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## Author

https://github.com/tsukaby
