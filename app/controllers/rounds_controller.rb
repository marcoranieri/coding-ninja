class RoundsController < ApplicationController

  before_action :set_round, only: [:show]

  def show
    @participations = Participation.where(round: @round)
  end

  private

  def set_round
    @round = Round.find(params[:id])
  end
end
