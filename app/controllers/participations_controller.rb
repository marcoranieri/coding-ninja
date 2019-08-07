class ParticipationsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    @game.rounds.each do |round|
      @participation = Participation.new
      @participation.user  = current_user
      @participation.round = round

      @participation.save!
    end

    redirect_to game_path(@game)
  end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :round_id, :active, :done)
  end
end
