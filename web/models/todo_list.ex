defmodule NestedFormsExample.TodoList do
  use NestedFormsExample.Web, :model

  schema "todo_lists" do
    has_many :todo_items, NestedFormsExample.TodoItem
    field :title, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(todo_list, params \\ %{}) do
    todo_list
    |> cast(params, [:title])
    |> cast_assoc(:todo_items, required: true)
  end
end
