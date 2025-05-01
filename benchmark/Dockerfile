FROM ruby:3.4.3

WORKDIR /app

# Install packages
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

COPY Gemfile* ./

RUN bundle install

# Copy application code
COPY . .

# Run a script
CMD ["ruby", "lib/insert_benchmark.rb"] 
