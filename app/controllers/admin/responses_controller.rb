class Admin::ResponsesController < AdminController
  before_action :set_admin_response, only: [:show, :edit, :update, :destroy]

  # GET /admin/responses
  def index
    if params[:rule_id]
      @responses = Rule.find(params[:rule_id]).responses
    else
      @responses = Response.all
    end
  end

  # GET /admin/responses/1
  def show
  end

  # GET /admin/responses/new
  def new
    @response = Response.new
  end

  # GET /admin/responses/1/edit
  def edit
  end

  # POST /admin/responses
  def create
    @response = Response.new(response_params)

    if @response.save
      redirect_to admin_responses_path, notice: '自动回复创建成功'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/responses/1
  def update
    if @response.update(response_params)
      redirect_to @response, notice: '自动回复更新成功'
    else
      render :edit
    end
  end

  # DELETE /admin/responses/1
  def destroy
    @response.destroy
    redirect_to admin_responses_url, notice: '自动回复删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_response
      @response = Response.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def response_params
      params.require(:response).permit(:msgtype, :message)
    end
end
