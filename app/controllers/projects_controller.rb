class ProjectsController < ApplicationController
    def index
        @projects = Project.all
    end
    def new
        @project = Project.new
    end
    def create
        @project = Project.new(project_params)
        if @project.save
            flash.now[:success] = "New Project Created Successfully"
            render :new
        else
            flash.now[:error] = "Could not create new Project"
            redirect_to new_project_path
        end
            
    end


    private
        def project_params
            params.require(:project).permit(:name)
        end
end
