class ParticipationsController < ApplicationController
  def create
    @game = Game.find(params[:game_id])

    @game.rounds.each do |round|
      @participation = Participation.new
      @participation.user  = current_user
      @participation.round = round

      @participation.save!
    end

    # Refresh user COMPLETED kata when joining a game ( through participations )
    current_user.json_completed_katas = CodewarsApiFetch.completed_kata(
      current_user.codewars_username,
      current_user.codewars_api_key
    )
    current_user.save!

    redirect_to game_path(@game)
  end

  private

  def participation_params
    params.require(:participation).permit(:user_id, :round_id, :active, :done)
  end
end
