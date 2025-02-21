defmodule PhoenixGistClone.Comments.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "comments" do
    field :markup_text, :string
    belongs_to :user, PhoenixGistClone.Accounts.User
    belongs_to :gist, PhoenixGistClone.Gists.Gist

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:user_id, :gist_id, :markup_text])
    |> validate_required([:user_id, :gist_id, :markup_text])
  end
end
