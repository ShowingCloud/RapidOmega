class Admin::ResponseRulesController < AdminController
  before_action :set_admin_response_rule, only: [:show, :edit, :update, :destroy]

  # GET /admin/response_rules/workbench
  def workbench
    @rules = Rule.all
  end

  # GET /admin/response_rules
  def index
    @response_rules = ResponseRule.all.order(:rule_id).includes(:rule,:response)
  end

  # GET /admin/response_rules/1
  def show
  end

  # GET /admin/response_rules/new
  def new
    @response_rule = ResponseRule.new
  end

  # GET /admin/response_rules/1/edit
  def edit
  end

  # POST /admin/response_rules
  def create
    @response_rule = ResponseRule.new(rule_params)

    if @response_rule.save
      redirect_to admin_response_rules_path, notice: '规则类型创建成功'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/response_rules/1
  def update
    if @response_rule.update(rule_params)
      redirect_to admin_response_rules_path, notice: '规则类型更新成功'
    else
      render :edit
    end
  end

  # DELETE /admin/response_rules/1
  def destroy
    @response_rule.destroy
    redirect_to admin_response_rules_url, notice: '规则类型删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_response_rule
      @response_rule = ResponseRule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rule_params
      params.require(:response_rule).permit(:rule_id,:response_id)
    end

end
