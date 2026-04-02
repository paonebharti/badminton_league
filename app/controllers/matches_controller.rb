class MatchesController < ApplicationController
  before_action :fetch_players, only: %i[new create edit]
  before_action :set_match, only: %i[edit update destroy]

  def index
    @pagy, @matches = pagy(Match.includes(:winner, :loser).order(played_at: :desc), items: 10)
  end

  def new
    @match = Match.new
  end

  def create
    @match = Match.new(match_params)

    if @match.save
      redirect_to matches_path, notice: 'Match recorded successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @match.update(match_params)
      redirect_to matches_path, notice: 'Match updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @match.destroy
    redirect_to matches_path, notice: 'Match deleted successfully!'
  end

  private

  def match_params
    params.require(:match).permit(:winner_id, :loser_id, :played_at)
  end

  def fetch_players
    @players = Player.active.order(:name)
  end

  def set_match
    @match = Match.find_by(id: params[:id])
    redirect_to matches_path, notice: "Match not found." if @match.nil?
  end
end
