class RoundsController < ApplicationController

  before_action :set_round, only: [:show, :update]

  def show
    @participations = Participation.where(round: @round)
  end

  def update
    respond_to do | format |
      if @round.update!(round_params)
        format.html { redirect_to @round, info: 'Game was successfully updated.' }
        # format.json { render :show, status: :created, location: @round }
      else
        format.html { render :edit }
        # format.json { render json: @round.errors, status: :unprocessable_entity }
      end
    end
  end

  # Ajax call to toggle ACTIVE
  def toggle
    @round = Round.find(params[:round_id])
    @round.active = !@round.active
    @round.save!

    # @game = Game.find(params[:game_id])

    respond_to do |format|
      format.js  # <-- will render `app/views/games/toggle.js.erb`
    end
  end

  private

  def round_params
    params.require(:round).permit(:kata_id, :duration, :notes, :active)
  end

  def set_round
    @round = Round.find(params[:id])
  end
end
