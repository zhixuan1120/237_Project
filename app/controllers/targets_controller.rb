class TargetsController < ApplicationController
  def index
    @targets = User.order(:name).where("name like ?", "%#{params[:term]}%")
    render json: @targets.map(&:name)
  end
end
