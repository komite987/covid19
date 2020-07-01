module Errors
  class BadRequest < Errors::StandardError
    def initialize(detail)
      super(
        title: "Bad Request",
        status: 400,
        detail: detail
      )
    end
  end
end
