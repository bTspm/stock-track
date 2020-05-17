module ApiExceptions
  class BadRequest < StandardError; end 

  class Forbidden < StandardError; end 

  class InternalServerError < StandardError; end 

  class NotFound < StandardError; end 

  class PremiumDataError < StandardError; end 

  class RequestBig < StandardError; end

  class TooManyRequests < StandardError; end 

  class Unauthorized < StandardError; end 
end
