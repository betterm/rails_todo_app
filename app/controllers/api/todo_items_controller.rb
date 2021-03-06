class Api::TodoItemsController < Api::ApiController
  before_filter :find_todo_list
  before_action :set_todo_items, only: [:destroy, :update, :complete, :not_complete]

  def create
    @item = @list.todo_items.new(item_params)
    if @item.save
      render status: 200, json: {
                            message: "Successfully created To-do Item.",
                            todo_list: @list,
                            todo_item: @item
                        }.to_json
    else
      render status: 422, json: {
                            message: "To-do Item creation failed.",
                            errors: @item.errors
                        }.to_json
    end
  end

  def update
    if @item.update(item_params)
      render status: 200, json: {
                            message: "Successfully updated To-do Item.",
                            todo_list: @list,
                            todo_item: @item
                        }.to_json
    else
      render status: 422, json: {
                            message: "To-do Item update failed.",
                            errors: @item.errors
                        }.to_json
    end
  end

  def destroy
    @item.destroy
    render status: 200, json: {
                          message: "Todo-Item successfully deleted.",
                          todo_list: @list,
                          todo_item: @item
                      }.to_json
  end

  def complete
    if @item.update_attribute(:completed_at, Time.now)
      render status: 200, json: {
                            message: "Item complete",
                            todo_list: @list,
                            todo_item: @item
                        }.to_json
    else
      render status: 422, json: {
                            message: "Error",
                            errors: @item.errors
                        }.to_json
    end
  end

  def not_complete
    if @item.update_attribute(:completed_at, nil)

        render status: 200, json: {
                              message: "Todo item non-complete",
                              todo_list: @list,
                              todo_item: @item
                          }.to_json
    else
        render status: 422, json: {
                              message: "To-do Item update failed.",
                              errors: @item.errors
                          }.to_json
    end
  end


  private


  def item_params
    params.require("todo_item").permit("content")
  end

  def find_todo_list
    @list = TodoList.find(params[:todo_list_id])
  end

  def set_todo_items
    @item = @list.todo_items.find(params[:id])
  end
end