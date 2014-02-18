class Api::TagsController < ApiController
  doorkeeper_for :all, except: [:index, :show]
  before_filter :restrict_access_with_token, except: [:create, :update, :destroy]

  before_filter :find_tag, except: [:index, :create]
  around_filter :render_error, except: [:index]

  def index
    @tags = Tag.all
  end

  def show
  end

  def create
    @tag = Tag.create! tag_params
    render 'api/tags/show'
  end

  def update
    @tag.update_attributes! tag_params
    render 'api/tags/show'
  end

  def destroy
    @tag.destroy!
    render 'api/tags/show'
  end

  private

    def tag_params
      params.permit(:tag)
    end
end
