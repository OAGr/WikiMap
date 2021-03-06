class CardsController < ApplicationController
  # GET /cards
  # GET /cards.json
  def index
    @cards = Card.root_cards
    @user = current_user
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cards }
    end
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
    @card = Card.find(params[:id])
    @cards = @card.children
    if (params[:level])
      if (params[:level] == '1')
        @cards = @card.parent.children
        @card = @card.parent
      elsif (params[:level] == '2')
        if @card.parent.parent.nil?
          @cards = [@card.parent]
        else
          @cards = @card.parent.parent.children
          @card = @card.parent.parent
        end
      end
    end

    
    @user = current_user
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @card }
    end
  end

  # GET /cards/new
  # GET /cards/new.json
  def new
    @card = Card.new(:parent_id => params[:parent_id])

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @card }
      format.js
    end
  end

  # GET /cards/1/edit
  def edit
    @card = Card.find(params[:id])
    
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(params[:card])
    @card.user = current_user
    
    if @card.parent_id != nil
      @card.grandparent_id = @card.parent.parent_id
    else
      @card.grandparent_id = nil
    end
    
    respond_to do |format|
      if @card.save
        format.html { redirect_to cards_path, notice: 'Card was successfully created.' }
        format.json { render json: @card, status: :created, location: @card }
      else
        format.html { render action: "new" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
      end
      format.js
    end
  end

  # PUT /cards/1
  # PUT /cards/1.json
  def update
    @card = Card.find(params[:id])

    respond_to do |format|
      if @card.update_attributes(params[:card])
        format.html { redirect_to @card, notice: 'Card was successfully updated.' }
        format.json { head :ok }
        format.js
      else
        format.html { render action: "edit" }
        format.json { render json: @card.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    respond_to do |format|
      format.html { redirect_to cards_url }
      format.json { head :ok }
      format.js
    end
  end
end
