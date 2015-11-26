class Api::TodoListsController < Api::ApiController
  before_action :set_lits, only: [:show, :destroy, :update]

  def index
    render json: @lists = TodoList.all
  end

  def show
      render json: @list.as_json(include:[:todo_items])
  end

  def create
    @list = TodoList.new(todo_list_params)
    if @list.save
      render status: 200, json: {
                 message: "Successfully created To-do List.",
                 todo_list: @list
             }.to_json
    else
      render status: 422, json: {
                 errors: @list.errors
             }.to_json
    end
  end

  def destroy
    @list.destroy
    render status: 200, json: {
               message: "Successfully deleted To-do List."
           }.to_json
  end

  def update
    if @list.update(todo_list_params)
      render status: 200, json: {
                 message: "Successfully updated",
                 todo_list: @list
             }.to_json
    else
      render status: 500, json: {
                 message: "The To-do list could not be updated.",
                 todo_list: @list
             }.to_json
    end
  end


  private
    def set_lits
      @list = TodoList.find(params[:id])
    end


    def todo_list_params
      params.require(:todo_list).permit(:title, :description)
    end

end