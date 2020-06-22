module Errors
  class BadRequest < StandardError
    def initialize (detail, source: {})
      super(
        status: 400,
        detail: detail,
        source: source.deep_stringify_keys
        )
    end
  end

  class PageNotFound < StandardError
    def initialize (detail, source: {})
      super(
        status: 404,
        detail: detail,
        source: source.deep_stringify_keys
        )
    end
  end



end