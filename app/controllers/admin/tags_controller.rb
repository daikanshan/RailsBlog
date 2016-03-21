class Admin::TagsController < AdminController
  before_action :set_admin_tag, only: [:show, :edit, :update, :destroy]

  # GET /admin/tags
  # GET /admin/tags.json
  def index
    @admin_tags = @login_author.tags
  end

  # GET /admin/tags/1
  # GET /admin/tags/1.json
  def show
  end

  # GET /admin/tags/new
  def new
    @admin_tag = Admin::Tag.new
  end

  # GET /admin/tags/1/edit
  def edit
  end

  # POST /admin/tags
  # POST /admin/tags.json
  def create
    @admin_tag = Admin::Tag.new(admin_tag_params)
    @admin_tag.author_id = @login_author.id
    respond_to do |format|
      if @admin_tag.save
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully created.' }
        format.json { render :show, status: :created, location: @admin_tag }
      else
        format.html { render :new }
        format.json { render json: @admin_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tags/1
  # PATCH/PUT /admin/tags/1.json
  def update
    respond_to do |format|
      if @admin_tag.update(admin_tag_params)
        format.html { redirect_to admin_tags_path, notice: 'Tag was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_tag }
      else
        format.html { render :edit }
        format.json { render json: @admin_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tags/1
  # DELETE /admin/tags/1.json
  def destroy
    @admin_tag.destroy
    respond_to do |format|
      format.html { redirect_to admin_tags_url, notice: 'Tag was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_tag
      @admin_tag = @login_author.tags.find_by_id(params[:id])
      if @admin_tag.nil?
        render html: "<strong>Not Found</strong>".html_safe and return
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_tag_params
      params.require(:admin_tag).permit(:name)
    end
end
