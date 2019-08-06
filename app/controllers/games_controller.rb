class GamesController < ApplicationController

  before_action :set_game, only: [:show, :edit, :update, :destroy]

  def index
    @games = Game.all.reverse
  end

  def show
  end

  def new
    @game = Game.new
  # max_rounds.times do
    @game.rounds.build
  # end
  end

  def edit
    @game.rounds.build
  end

  def create
    @game = Game.new(game_params)

    respond_to do | format |
      if @game.save!
        format.html { redirect_to @game, info: 'Game was successfully created.' }
        # format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        # format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do | format |
      if @game.update!(game_params)
        format.html { redirect_to @game, info: 'Game was successfully updated.' }
        # format.json { render :show, status: :created, location: @game }
      else
        format.html { render :edit }
        # format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game.destroy

    redirect_to :root
  end

  # def scrape_kata
  #   collection  = ScraperKataCollection.filter_by_kyu(8, 7)
  #   @katas_array = collection.map do |scraped_kata_url|
  #     ScraperKataCollection.get_titles_and_hrefs(scraped_kata_url)
  #   end
  # end

  private

  def set_game
    @game = Game.find(params[:id])
  end

  def game_params
    # params.require(:game).permit(:title,:max_rounds, rounds_attributes: [:id, :kata_id, :notes, :_destroy])
    params.require(:game).permit(:title, :max_rounds, rounds_attributes: Round.attribute_names.map(&:to_sym).push(:_destroy))
  end

end
