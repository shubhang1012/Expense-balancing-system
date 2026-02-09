# Puma configuration file for Render

max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }
min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
threads min_threads_count, max_threads_count

port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { "development" }

# ✅ Use single mode in production (no workers)
if ENV["RAILS_ENV"] == "production"
  workers 0
else
  workers ENV.fetch("WEB_CONCURRENCY") { 1 }
end

preload_app!

plugin :tmp_restart
