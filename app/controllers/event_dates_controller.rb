class EventDatesController < ApplicationController

  before_action :not_authenticated
  before_action :set_event_date, only: [:show, :edit, :update, :destroy]
  # GET /event_dates
  # GET /event_dates.json
  def index
    @event = Event.find(params[:event])
    @event_dates = EventDate.all
  end

  # GET /event_dates/1
  # GET /event_dates/1.json
  def show
  end

  # GET /event_dates/new
  # GET /events/new
  def new_with_data
    params_obj = JSON.parse(params[:data])
    event = Event.find(params_obj['event_id'])
    @event_date = EventDate.new(event: event)
    render 'new'
  end

  def new
    @event_date = EventDate.new
  end

  # GET /event_dates/1/edit
  def edit
  end

  # POST /event_dates
  # POST /event_dates.json
  def create
    @event_date = EventDate.new(event_date_params)
    

    respond_to do |format|
      if @event_date.save
        format.html { redirect_to @event_date, notice: 'Event date was successfully created.' }
        format.json { render :show, status: :created, location: @event_date }
      else
        format.html { render :new }
        format.json { render json: @event_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_dates/1
  # PATCH/PUT /event_dates/1.json
  def update
    respond_to do |format|
      if @event_date.update(event_date_params)
        format.html { redirect_to @event_date, notice: 'Event date was successfully updated.' }
        format.json { render :show, status: :ok, location: @event_date }
      else
        format.html { render :edit }
        format.json { render json: @event_date.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_dates/1
  # DELETE /event_dates/1.json
  def destroy
    @event = Event.find(@event_date.event_id)
    @event_date.destroy
    respond_to do |format|
      format.html { redirect_to event_dates_url, notice: 'Event date was successfully destroyed.' }
      format.json { head :no_content }
    end
    redirect_to events_dates_path(@event)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_event_params
    @event = Event.find(params[:event_id])

  end

  def set_event_date
    @event_date = EventDate.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_date_params
    params.require(:event_date).permit(:date, :event_id, :comment)
  end

  def data_params
    params.require(:data)
  end
end
