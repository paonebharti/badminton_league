class PlayersController < ApplicationController

  before_action :set_player, only: %i[show edit update destroy]

  def index
    @pagy, @players = pagy(Player.active, items: 10)
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
