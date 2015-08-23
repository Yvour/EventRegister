class EventsController < ApplicationController
  before_action :not_authenticated
  before_action :set_event, only: [:show, :edit, :update, :destroy, :dates, :generate_dates]
  before_action :recalculate_dates, only: [:own]

  # GET /events
  # GET /events.json
  def own
    @events = Event.where(user: current_user).order('last_date desc')
    render 'index'
  end
  
  def generate_dates
    @event.generate_dates
    redirect_to event_path(@event)

  end
  
  
  def index
    @events = Event.all.order('last_date desc')
  end
  
  def dates
    logger.debug "The_event is " + @event.to_json.to_s
    
    @event_dates = EventDate.where(event_id: @event.id).order('date desc')
    
    logger.info "the_dates is " + @event_dates.to_json.to_s
       render 'dates'
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end


  
  
  def new
    @event = Event.new
  end

  # GET /events/1/edit
  def edit
 
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    @event.user = current_user
    @event.last_date = @event.initial_date
    @event.event_dates << EventDate.new(date: @event.initial_date)
    logger.info "created"

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    
    def recalculate_dates
      Event.where(user: current_user).order('last_date desc').map do |event|
        if event.event_type.name != 'once'
          controldate = Date.today + 7
      
          while event.last_date < controldate # Горизонт планирования неделя
             event.generate_dates(controldate)
             event = Event.find(event.id)
          end
        end
      end
    end
    
    
    
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :initial_date, :event_date_day, :comment, :last_date, :user_id, :event_type_id)
    end
end
