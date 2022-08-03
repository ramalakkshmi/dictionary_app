class WordsController < ApplicationController
  before_action :set_word, only: %i[ show edit update destroy ]

  # GET /words or /words.json
  def index
    @words = Word.all
  end
  def error; end

  # GET /words/1 or /words/1.json
  def show
    @word = Word.find_by(id: params[:id])

  end

  # GET /words/new
 
  def new
    @word = Word.find_by(name: params[:q])
    if @word
      redirect_to action: "show", id: @word.id
    else
      if DictionarySearch.new(word_params).call
        @word = DictionarySearch.new(word_params).call
        redirect_to action: "show", id: @word.id
      else
        redirect_to error_path
      end
    end
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words or /words.json
  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to word_url(@word), notice: "Word was successfully created." }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1 or /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to word_url(@word), notice: "Word was successfully updated." }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1 or /words/1.json
  def destroy
    @word.destroy

    respond_to do |format|
      format.html { redirect_to words_url, notice: "Word was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def word_params
      params.require(:word).permit(:word, :definition, :tags)
      params.permit(:endpoint, :q, :authenticity_token, :commit)
    end
end
