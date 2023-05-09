require "typhoeus/cache/rails"

Typhoeus::Config.cache = Typhoeus::Cache::Rails.new(Rails.cache, default_ttl: 1800)
