module Errors
  class NotFound < Errors::StandardError
    def initialize(detail)
      super(
        title: "not Found",
        status: 404,
        detail: detail
      )
    end
  end
end
