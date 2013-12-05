class TimestampsController < ApplicationController
    require 'massupload.rb'
    before_action :signed_in_user

    def index
        @timestamps = Timestamp.all
    end
    def new
            redirect_to edit_timestamp_path(last_timestamp) if !last_timestamp.closed?
        @timestamp = Timestamp.new
    end
    def create
        @timestamp = current_user.timestamps.new(timestamp_params)
        if @timestamp.save
            flash.now[:success] = "New Timestamp Added"
            redirect_to new_timestamp_path
        else
            flash.now[:error] = "Could not add Timestamp"
            redirect_to new_timestamp_path
        end
    end
    def edit
        @timestamp = last_timestamp
        @employee = current_user
    end
    def update
        @timestamp = last_timestamp
        if @timestamp.update_attributes(timestamp_params)
            flash[:success] = "Timestamp ended"
            redirect_to new_timestamp_path
        else
            render 'edit'
        end
    end

    def upload
        @timestamp = Timestamp.new
    end

    def insert
        file = params[:uploaded_file][:uploaded_file]
        if file.content_type == "text/xml"
          convert_xml(file)
        elsif file.content_type == "application/vnd.ms-excel"
            convert_xls(file)
        end
      render 'upload'
    end

      def last_timestamp
          current_user.timestamps.order('created_at DESC').first
      end

    private
    def timestamp_params
        params.require(:timestamp).permit(:project_id, :client_id, :start_time, :end_time)
    end
end
