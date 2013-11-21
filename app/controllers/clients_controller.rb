class ClientsController < ApplicationController
    def index
        @clients = Client.all
    end
    def new
        @client = Client.new
    end
    def create
        @client = Client.new(client_params)
        if @client.save
            flash.now[:success] = "New Client Created Successfully"
            render :new
        else
            flash.now[:error] = "Could not create new Client"
            redirect_to new_client_path
        end
            
    end


    private
        def client_params
            params.require(:client).permit(:name)
        end
end
