class Admin::RulesController < AdminController
  before_action :require_super_admin
  before_action :set_admin_rule, only: [:show, :edit, :update, :destroy]

  # GET /admin/rules
  def index
    @rules = Rule.all
  end

  # GET /admin/rules/1
  def show
  end

  # GET /admin/rules/new
  def new
    @rule = Rule.new
  end

  # GET /admin/rules/1/edit
  def edit
  end

  # POST /admin/rules
  def create
    @rule = Rule.new(rule_params)

    if @rule.save
      redirect_to admin_rules_path, notice: '规则类型创建成功'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/rules/1
  def update
    if @rule.update(rule_params)
      redirect_to @rule, notice: '规则类型更新成功'
    else
      render :edit
    end
  end

  # DELETE /admin/rules/1
  def destroy
    @rule.destroy
    redirect_to admin_rules_url, notice: '规则类型删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_rule
      @rule = Rule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rule_params
      params.require(:rule).permit(:case)
    end

end
