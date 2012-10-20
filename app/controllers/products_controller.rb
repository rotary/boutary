class ProductsController < AdminController

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { session[:current_product_id] = @product.id }
      format.json { render :json => @product }
      format.xml  { render :xml => @product }
    end
  end

  
  def new
    @product = Product.new(:nature_id => params[:nature_id])
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
      format.json { render :json => @product }
      format.xml  { render :xml => @product }
    end
  end
  
  def create
    @product = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        format.html { redirect_to (params[:redirect] || product_natures_url) }
        format.json { render json => @product, :status => :created, :location => @product }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
    end
  end
  
  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to (params[:redirect] || product_natures_url) }
        format.json { head :no_content }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @product.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to (params[:redirect] || product_natures_url) }
      format.json { head :no_content }
    end
  end

end
