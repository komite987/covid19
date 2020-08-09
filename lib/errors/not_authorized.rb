module Errors
  class NotAuthorized < Errors::StandardError
    def initialize(detail)
      super(
        title: "Not Authorized",
        status: 401,
        detail: detail
      )
    end
  end
end
