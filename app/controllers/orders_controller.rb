class OrdersController < ApplicationController

  before_action :set_order, only: [:destroy, :edit, :update]

  def index
    if current_user.admin?
      @orders = Order.order(:user_id).all
    else
      @orders = Order.where("user_id = ?", current_user.id.to_s)
    end

  end

  def create
    @supply = Supply.find(params[:order][:supply_id])

    @total = @supply.price * params[:order][:count].to_f
    if current_user.discount.nil?
      if @total > 2000
        current_user.discount = 20
        User.find_by(:id => current_user.id).update(:discount => 20)
      end
    end

    @order = Order.new({
         :supply_id => params[:order][:supply_id],
         :user_id => current_user.id,
         :count => params[:order][:count].to_f,
         :total => @total * (1 - current_user.discount*0.01),
         :status => params[:order][:status],
         :deliveryDate => params[:order][:deliveryDate]
     })


    respond_to do |format|
      if @order.save
        format.html { render action: :show }
      else
        redirect_to('/supplies')
      end
    end
  end

  def edit
    if !current_user.admin?
      redirect_to('/orders')
    end
  end


  def update

    if params[:order][:status] == 'Ready'
      params[:order][:deliveryDate] = Date.today
    elsif params[:order][:status] == 'Rejected'
      params[:order][:deliveryDate] = ''
    end

    respond_to do |format|
      if @order.update(:status => params[:order][:status], :deliveryDate => params[:order][:deliveryDate] )
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
      else
        redirect_to('/orders')
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def new
    @order = Order.new
    @supply = Supply.find(params[:supply_id])
    @user = User.find(current_user.id)
  end

  def show
    @order = Order.find(params[:id])
  end

  def info

  end

  private
    def set_order
      @order = Order.find(params[:id])
    end

end
