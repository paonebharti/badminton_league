class PlayersController < ApplicationController

  before_action :set_player, only: %i[show edit update destroy]

  def index
    players_data = Player.find_by_sql("SELECT p.id, p.name, p.age, p.email, p.phone, COUNT(DISTINCT wins.id) as win_count, COUNT(DISTINCT losses.id) as loss_count 
                          FROM players as p LEFT JOIN matches as wins on p.id = wins.winner_id LEFT JOIN matches as losses on p.id = losses.loser_id WHERE p.active = true 
                          GROUP BY p.id ORDER BY win_count DESC, loss_count ASC;")
    @pagy, @players = pagy_array(players_data, items: 10)
  end

  def new
    @player = Player.new
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      redirect_to players_path, notice: 'Player added successfully!'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @player.update(player_params)
      redirect_to players_path, notice: 'Player updated successfully!'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @player.soft_delete
    redirect_to players_path, notice: 'Player removed successfully!'
  end

  private

  def player_params
    params.require(:player).permit(:name, :age, :email, :phone)
  end

  def set_player
    @player = Player.find_by(id: params[:id])
    redirect_to root_path, notice: "Player not found." if @player.nil?
  end
end
