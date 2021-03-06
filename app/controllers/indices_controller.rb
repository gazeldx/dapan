class IndicesController < ApplicationController
  
  before_filter :admin
  
  before_action :set_index, only: [:show, :edit, :update, :destroy]

  def index
    @indices = Index.order('id DESC')
  end

  def show
  end

  def new
    @index = Index.new
  end

  def edit
  end

  def create
    @index = Index.new(index_params)
    if @index.save
      redirect_to @index, notice: t('index.created_succ')
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @index.update(index_params)
        format.html { redirect_to @index, notice: 'Index was successfully updated.' }
        format.json { render :show, status: :ok, location: @index }
      else
        format.html { render :edit }
        format.json { render json: @index.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @index.destroy
    respond_to do |format|
      format.html { redirect_to indices_url, notice: 'Index was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_index
      @index = Index.find(params[:id])
    end

    def index_params
      params.require(:index).permit(:current_date, :closing_price, :opening_price, :advance, :decline)
    end
end
