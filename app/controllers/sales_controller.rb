class SalesController < AdminController

  def index
    @sales = Sale.all
  end

  def show
    @sale = Sale.find(params[:id])
    respond_to do |format|
      format.html { session[:current_sale_id] = @sale.id }
      format.json { render :json => @sale }
      format.xml  { render :xml => @sale }
    end
  end

  
  def new
    @sale = Sale.new
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
      format.json { render :json => @sale }
      format.xml  { render :xml => @sale }
    end
  end
  
  def create
    @sale = Sale.new(params[:sale])
    respond_to do |format|
      if @sale.save
        format.html { redirect_to (params[:redirect] || sale_url(@sale)) }
        format.json { render json => @sale, :status => :created, :location => @sale }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def edit
    @sale = Sale.find(params[:id])
    respond_to do |format|
      format.html { render_restfully_form(:multipart => true) }
    end
  end
  
  def update
    @sale = Sale.find(params[:id])
    respond_to do |format|
      if @sale.update_attributes(params[:sale])
        format.html { redirect_to (params[:redirect] || sale_url(@sale)) }
        format.json { head :no_content }
      else
        format.html { render_restfully_form(:multipart => true) }
        format.json { render :json => @sale.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @sale = Sale.find(params[:id])
    @sale.destroy
    respond_to do |format|
      format.html { redirect_to (params[:redirect] || sale_url(@sale)) }
      format.json { head :no_content }
    end
  end

end
