class Developers::BaseController < ApplicationController
  layout 'developers'

  protected
    helper_method :highlight, :highlight?

    def highlight page
      @highlight_page = page
    end

    def highlight? page
      "active" if @highlight_page == page
    end
end
