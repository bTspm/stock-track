module Cacheable
  def expiry
    1.hour
  end

  def fetch_cached(key, opts = {}, &block)
    opts[:expires_in] ||= expiry
    Rails.cache.fetch(key, opts, &block)
  end
end
