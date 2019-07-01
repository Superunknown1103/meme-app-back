require 'pry'

class Api::V1::MemesController < ApplicationController
  before_action :set_meme, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, :only => [:index, :create, :increase_vote]

  # GET /memes
  def index
    @memes = Meme.all
    @meme_array = []
    @memes.map do | meme |
      if (meme.link.attached?)
       link = Rails.application.routes.url_helpers.rails_blob_path(meme.link, only_path: true)
       @meme_array.push({ :meme => meme, :link => link})
      end
    end

    render json: @meme_array
  end

  def increase_vote
    meme = Meme.find_by_id(params[:id])
    # if current user has voted on this meme, do not allow them to continue voting
    meme.votes += 1
    meme.save
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
    @meme.link.attach(params[:meme][:link])
    # @meme.link.attach(io: File.open("/path/to/#{[:me]}.jpg"), filename: "pic.jpg", content_type: "image/jpg")
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
