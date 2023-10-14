defmodule CarDealership.BlogsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `CarDealership.Blogs` context.
  """

  @doc """
  Generate a blog.
  """
  def blog_fixture(attrs \\ %{}) do
    {:ok, blog} =
      attrs
      |> Enum.into(%{
        tag: "some tag",
        title: "some title",
        content: "some content"
      })
      |> CarDealership.Blogs.create_blog()

    blog
  end
end
