module Cacheable
  def fetch_cached(key:, opts: {}, &block)
    opts[:expires_in] ||= _expiry
    Rails.cache.fetch(key, opts, &block)
  end

  protected

  def _expiry
    8.hours
  end
end
