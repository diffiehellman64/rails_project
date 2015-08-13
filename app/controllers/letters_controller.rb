class LettersController < ApplicationController

  load_and_authorize_resource 

  respond_to :html, :pdf

  def index
    @letters = Letter.all.order(:id)
    #render text: 'index'
  end

  def show
    prawnto prawn: { margin: [34, 20, 20, 77], page_size: "A4"}
    @letter = Letter.find(params[:id])
    respond_with do |format|
      format.html
      format.pdf
    end
  end

  def new
    @letter = Letter.new
  end

  def edit
    @letter = Letter.find(params[:id])
  end

  def create
    @letter = Letter.create(letter_params)
    redirect_to @letter
  end

  def update
    @letter = Letter.find(params[:id])
    @letter.update(letter_params)
    redirect_to @letter
  end

  def destroy
  end

  def add_director
    @director = Director.new
    respond_with(@director) do |format|
      format.html
      format.js
    end
  end

  private
  
  def letter_params
    params.require(:letter).permit(:text, :date_incomming, :number_incomming, :date_outgoing_out, :number_outgoing_out, :incomming_letter)
  end

end
