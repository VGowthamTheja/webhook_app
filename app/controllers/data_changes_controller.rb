class DataChangesController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @data_change = DataChange.new(data_change_params)
    if @data_change.save
      notify_third_parties(@data_change)
      render json: @data_change, status: :created
    else
      render json: @data_change.errors, status: :unprocessable_entity
    end
  end

  def update
    @data_change = DataChange.find(params[:id])
    if @data_change.update(data_change_params)
      notify_third_parties(@data_change)
      render json: @data_change, status: :ok
    else
      render json: @data_change.errors, status: :unprocessable_entity
    end
  end

  private

  def data_change_params
    params.require(:data_change).permit(:name, :data)
  end

  def notify_third_parties(data_change)
    WebhookEndpoint.all.each do |endpoint|
      WebhookNotifierJob.perform_later(endpoint.url, data_change)
    end
  end
end
