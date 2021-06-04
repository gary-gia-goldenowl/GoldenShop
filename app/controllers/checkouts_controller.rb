class CheckoutsController < ApplicationController
  before_action :set_checkout, only: %i[show edit update destroy]

  # GET /checkouts or /checkouts.json
  def index
    @checkouts = Checkout.all
  end

  # GET /checkouts/1 or /checkouts/1.json
  def show; end

  # GET /checkouts/new
  def new
    @checkout = Checkout.new
    @order_items = current_order.order_items if current_order.present?
    @order = current_user.orders
  end

  # GET /checkouts/1/edit
  def edit; end

  # POST /checkouts or /checkouts.json
  def create
    @checkout = Checkout.new(checkout_params)
    current_user.orders.create
    redirect_to checkouts_path if @checkout.save
  end

  # PATCH/PUT /checkouts/1 or /checkouts/1.json
  def update
    respond_to do |format|
      if @checkout.update(checkout_params)
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1 or /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_checkout
    @checkout = Checkout.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def checkout_params
    params.require(:checkout).permit(:name, :phonenumber, :email, :address)
  end
end