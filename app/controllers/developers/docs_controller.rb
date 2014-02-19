class Developers::DocsController < Developers::BaseController
  before_filter :find_doc, except: [:index, :new, :create]

  def index
    @docs_api = Doc.api
    @docs_other = Doc.other
  end

  def new
    @doc = Doc.new
  end

  def create
    @doc = Doc.new doc_params
    if @doc.save
      redirect_to developers_doc_url(@doc)
    else
      render :new
    end
  end

  def update
    if @doc.update_attributes doc_params
      redirect_to developers_doc_url(@doc)
    else
      render :edit
    end
  end

  def edit
  end

  def destroy
    flash[:notice] = "Dokumentet borttaget" if @doc.destroy
    redirect_to developers_docs_url
  end

  def show
  end

  private

    def find_doc
      @doc = Doc.find params[:id]
    end

    def doc_params
      params.require(:doc).permit(:title, :content, :method)
    end
end
