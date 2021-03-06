class TicketsController < ApplicationController
  before_action :set_project
  before_action :set_ticket, only: [:show, :edit, :update, :destroy]

  def show
    authorize @ticket
  end

  def new
    @ticket = @project.tickets.build
    authorize @ticket, :create?
  end

  def edit
    authorize @ticket, :update?
  end

  def create
    @ticket = @project.tickets.build(ticket_params)
    @ticket.author = current_user
    authorize @ticket

    if @ticket.save
      flash[:notice] = 'Ticket has been created.'
      redirect_to [@project, @ticket]
    else
      flash[:alert] = 'Ticket has not been created.'
      render :new
    end
  end

  def update
    authorize @ticket

    if @ticket.update(ticket_params)
      flash[:notice] = 'Ticket has been updated.'
      redirect_to [@project, @ticket]
    else
      flash.now[:alert] = 'Ticket has not been updated.'
      render :edit
    end
  end

  def destroy
    authorize @ticket

    @ticket.delete
    flash[:notice] = 'Ticket has been deleted.'

    redirect_to @project
  end

  private
    def ticket_params
      params.require(:ticket).permit(:name, :description, :attachment, :attachment_cache)
    end

    def set_project
      @project = Project.find(params[:project_id])
    end

    def set_ticket
      @ticket = @project.tickets.find(params[:id])
    end
end
