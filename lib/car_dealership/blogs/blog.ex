defmodule CarDealership.Blogs.Blog do
  use Ecto.Schema
  import Ecto.Changeset

  schema "blogs" do
    field :tag, :string
    field :title, :string
    field :content, :string

    timestamps()
  end

  @doc false
  def changeset(blog, attrs) do
    blog
    |> cast(attrs, [:title, :content, :tag])
    |> validate_required([:title, :content, :tag])
  end
end
