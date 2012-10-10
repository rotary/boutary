class ProductNaturesController < AdminController

  def index
    @product_natures = ProductNature.all
  end

  def show
    @product_nature = ProductNature.find(params[:id])
    respond_to do |format|
      format.html { session[:current_product_nature_id] = @product_nature.id }
      format.json { render :json => @product_nature }
      format.xml  { render :xml => @product_nature }
    end
  end

  
  def new
    @product_nature = ProductNature.new
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
      format.json { render :json => @product_nature }
      format.xml  { render :xml => @product_nature }
    end
  end
  
  def create
    @product_nature = ProductNature.new(params[:product_nature])
    respond_to do |format|
      if @product_nature.save
        format.html { redirect_to (params[:redirect] || product_natures_url) }
        format.json { render json => @product_nature, :status => :created, :location => @product_nature }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @product_nature.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @product_nature = ProductNature.find(params[:id])
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
    end
  end
  
  def update
    @product_nature = ProductNature.find(params[:id])
    respond_to do |format|
      if @product_nature.update_attributes(params[:product_nature])
        format.html { redirect_to (params[:redirect] || product_natures_url) }
        format.json { head :no_content }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @product_nature.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @product_nature = ProductNature.find(params[:id])
    @product_nature.destroy
    respond_to do |format|
      format.html { redirect_to (params[:redirect] || product_natures_url) }
      format.json { head :no_content }
    end
  end

end
