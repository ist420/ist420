class StaticPagesController < ApplicationController
    def home
        redirect_to "/timestamps" if signed_in?
    end
end
