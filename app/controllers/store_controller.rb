# -*- coding: utf-8 -*-
class StoreController < ApplicationController

  def index
    reset_session if session[:started_at].is_a?(Time) and session[:started_at] > Time.now - 5.hours
  end

  def authenticate
    if params[:password].to_s.mb_chars.upcase == "LISBOA2013"
      session[:started_at] = Time.now
      redirect_to :action => :select_product
    else
      redirect_to :action => :index
    end
  end

  def select_product
    unless session[:started_at]
      redirect_to :action => :index
      return
    end
    @products = Product.all
  end

  def fill
    product = Product.find(params[:product_id])
    @sale = Sale.new(:product_id => product.id)
    @sale.product.resident_number.times { @sale.residents.build }
  end

  def pay
    @sale = Sale.new(params[:sale])
    unless @sale.save
      render :action => :fill
      return
    end
    # Paybox...
    # redirect_to "https://boutique.rotary1690.org/site/modulev3.cgi?" + {
    redirect_to "https://www.rotex1690.org/site/modulev3.cgi?" + {
      :PBX_MODE => 1, 
      :PBX_SITE => "0840363", 
      :PBX_RANG => "01", 
      :PBX_TOTAL => (@sale.amount*100).to_i, 
      :PBX_DEVISE => 978, 
      :PBX_CMD => @sale.number, 
      :PBX_PORTEUR => @sale.residents.first.email, 
      :PBX_RETOUR => Sale.payment_infos.collect{|k,v| "#{v}:#{v}"}.join(";"),
      :PBX_IDENTIFIANT => "315034123", 
      :PBX_LANGUE => "FRA", 
      :PBX_EFFECTUE => finish_url(@sale), 
      :PBX_REFUSE => refuse_url(@sale), 
      :PBX_ANNULE => cancel_url(@sale)
    }.collect{|k,v| "#{k}=#{URI.encode(v.to_s)}"}.join('&')
  end

  def cancel
    flash[:warning] = "La transaction a été annulée."
    sale = Sale.find_by_number(params[:id])
    redirect_to sale_url(sale)
  end

  def refuse
    flash[:error] = "La transaction a été refusée."
    sale = Sale.find_by_number(params[:id])
    redirect_to sale_url(sale)
  end

  def finish
    validate_payment
    sale = Sale.find_by_number(params[:id])
    redirect_to root_url
  end

  def check
    validate_payment(true)
    render :text=>""
  end

  protected

  def validate_payment(no_redirect = false)
    unless @sale = Sale.find_by_number(params["R"])
      flash[:error] = "Une erreur est survenue lors de la précédente opération. Veuillez réeessayer."
      redirect_to root_url unless no_redirect
      return 
    end
    @sale.payment_infos = params.to_yaml
    @sale.save
    if @sale.error_code == "00000"
      flash[:notice] = "La transaction a été validée."
      @sale.state = "paid"
      @sale.save
    else
      flash[:error] = "Une erreur s'est produite"
    end
  end


end
