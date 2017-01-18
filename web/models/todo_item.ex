defmodule NestedFormsExample.TodoItem do
  use NestedFormsExample.Web, :model
  @required_fields ~w(body)
  @optional_fields ~w(delete)

  schema "todo_items" do
    field :body, :string
    field :delete, :boolean, virtual: true
    belongs_to :todo_list, NestedFormsExample.TodoList

    timestamps()
  end

  def changeset(todo_item, params \\ :empty) do
    todo_item
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:body, min: 3)
    |> mark_for_deletion() # 2. Call mark for deletion
  end

  defp mark_for_deletion(changeset) do
    # If delete was set and it is true, let's change the action
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
