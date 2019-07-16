class RoundsController < ApplicationController

  before_action :set_round, only: [:show]

  def show
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end
end
