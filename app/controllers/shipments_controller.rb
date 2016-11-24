class ShipmentsController < ApplicationController
  before_action :authenticate!

  def index
    if admin_user || staff_user
    @shipments= Shipment.all.order(created_at: :desc)
    else
    @shipments= current_user.shipments.all.order(created_at: :desc)
    end
  end

  def show
    @shipments= current_user.shipments.all.order(created_at: :desc)
    @shipment = Shipment.find_by(id: params[:id])
    authorize @shipment
  end

  def new
    @shipment= Shipment.new
    @parcels = current_user.parcels
  end

  def create
    @parcels= Parcel.where(id: params[:parcel_id])
    @shipment= current_user.shipments.build(shipment_params)
    authorize @shipment
    if @shipment.save
      # @shipment.create_activity :create, owner: current_user
      @parcels.each do |parcel|
      @shipment.ordered_parcels.create( {:parcel_id => parcel.id})
      parcel.update({:status => :"Ready To Ship"})
      end

      redirect_to shipments_path
    else
      redirect_to new_shipment_path
    end
  end

  def edit
    @shipment = Shipment.find(params[:id])
    authorize @shipment
  end

  def update
      @shipment = Shipment.find(params[:id])
      authorize @shipment
      if @shipment.update(shipment_params)
        if @shipment.totalprice != nil
        # flash[:success]
        @bill = Billplz.create_bill_for(@shipment)
        @shipment.update_attributes(bill_id: @bill.parsed_response['id'], bill_url: @bill.parsed_response['url'], status: :"Awaiting Payment")
        # @shipment.create_activity :update, owner: current_user
        # redirect_to @bill.parsed_response['url']
        redirect_to shipment_path
        else
          redirect_to shipments_path
        end
      else
        redirect_to shipments_path
        # flash[:danger]
      end
    end

    def destroy
      @shipment = Shipment.find(params[:id])
      authorize @shipment
      if @shipment.destroy
        # @shipment.create_activity :destroy, owner: current_user
        redirect_to shipments_path
        # flash[:success]
      end
    end

  private

    def shipment_params
      params.require(:shipment).permit(:status, :remark, :weight, :volume, :charge, :bill_id, :bill_url, :due_at, :paid_at)
    end

end