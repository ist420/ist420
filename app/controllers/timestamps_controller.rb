class TimestampsController < ApplicationController
    def index
        @timestamps = Timestamp.all
    end
    def new
        @timestamp = Timestamp.new
    end
    def create
        @timestamp = Timestamp.new(timestamp_params)
        if @timestamp.save
            flash.now[:success] = "New Timestamp Added"
            render :new
        else
            flash.now[:error] = "Could not add Timestamp"
            redirect_to new_timestamp_path
        end
    end
    def edit
    end
    def show
    end

    private
    def timestamp_params
            params.require(:timestamp).permit(:employee_id)
    end
end
