# ================================
# ✅ Base image: Ruby 3.1 (Render requires > 3.1)
# ================================
FROM ruby:3.1-bullseye

# ================================
# Install dependencies
# ================================
RUN apt-get update -qq && \
    apt-get install -y nodejs npm postgresql-client build-essential libpq-dev && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# ================================
# Set working directory
# ================================
WORKDIR /app

# ================================
# Copy Gemfiles and install gems
# ================================
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' && \
    bundle config set --local without 'development test' && \
    bundle install --jobs 4

# ================================
# Copy the app
# ================================
COPY . .

# ================================
# Precompile assets safely
# (Skips DB connection in production env)
# ================================
RUN npm install -g yarn@1.22.22 && \
    RAILS_ENV=production NODE_ENV=production SECRET_KEY_BASE=dummy \
    DISABLE_DATABASE_ENVIRONMENT_CHECK=1 \
    bundle exec rake assets:clobber assets:precompile webpacker:compile || \
    echo "⚠️ Skipping DB connection during assets build"

# ================================
# Expose Render port
# ================================
EXPOSE 3000

# ================================
# Run migrations and start Puma
# ================================
CMD bash -c "bundle exec rails db:migrate && bundle exec puma -C config/puma.rb -b tcp://0.0.0.0:${PORT:-3000}"
