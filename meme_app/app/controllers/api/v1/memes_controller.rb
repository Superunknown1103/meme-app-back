require 'pry'

class Api::V1::MemesController < ApplicationController
  before_action :set_meme, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, :only => [:index, :create]

  # GET /memes
  def index
    @memes = Meme.all
    render json: @memes
  end

  # GET /memes/1
  # GET /memes/1.json
  def show
    render json: @meme
  end

  # GET /memes/1/edit
  def edit
  end

  # POST /memes
  # POST /memes.json
  def create
    @meme = Meme.new(meme_params)
    binding.pry
    @meme.link.attach(params[:link])
    if @meme.save
      render json: @meme, status: :created, location: api_v1_meme_url(@meme)
    else 
      render json: @meme.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /memes/1
  # # PATCH/PUT /memes/1.json
  # def update
  #     if @meme.update(meme_params)
  #       format.html { redirect_to @meme, notice: 'Meme was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @meme }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @meme.errors, status: :unprocessable_entity }
  #     end
  # end

  # DELETE /memes/1
  # DELETE /memes/1.json
  def destroy
      @meme.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_meme
      @meme = Meme.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def meme_params
      params.require(:meme).permit(:link, :user_id, :votes)
    end
end
