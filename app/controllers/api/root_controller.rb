module API
  class RootController < Api::BaseController
    def test
      @now = Time.now
    end
  end
end