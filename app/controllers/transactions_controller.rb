class TransactionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  # GET /transactions
  # GET /transactions.json
  def index
    transaction_service = TransactionsService.new(params)
    @store_names ||= transaction_service.store_names
    @transactions ||= transaction_service.list
    @transactions = @transactions.page(params[:page] || 1).per(params[:per] || 20) unless @transactions.blank?
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end


  # POST /transactions
  # POST /transactions.json
  def create
    respond_to do |format|
      if TransactionsService.new(params).create_transactions
        flash[:alert] = "file sucessfully processed"
        format.html { redirect_to action: "index" }
      else
        flash[:alert] = "strange things are happening, maybe you already imported this file? please double check the file..."
        format.html { redirect_to action: "new" }
      end
    end
  end

end
