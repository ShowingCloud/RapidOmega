class Admin::KeywordRulesController < AdminController
  before_action :set_rule, only: [:show, :edit, :update, :destroy]

  def index
    @rules = Rule.where(:event => 'text').where.not(:keyword => nil)
  end

  def show
  end

  def new
    @rule = Rule.new
  end

  def edit
  end

  def create
    @rule = Rule.new(rule_params)

    if @rule.save
      redirect_to admin_keyword_rules_path, notice: '规则类型创建成功'
    else
      render :new
    end
  end

  def update
    if @rule.update(rule_params)
      redirect_to admin_keyword_rules_path, notice: '规则类型更新成功'
    else
      render :edit
    end
  end

  def destroy
    @rule.destroy
    redirect_to admin_keyword_rules_url, notice: '规则类型删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rule_params
      params.require(:rule).permit(:keyword,:name,:fullmatch).merge(:event => "text")
    end

end
