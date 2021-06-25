defmodule Blog.Fixtures do

  alias Blog.Posts

  @valid_post %{
    title: "Phoenix Framework",
    description: "Loren"
  }

  def post_fixture(_attrs \\ %{}) do
    {:ok, post} = Posts.create_post(@valid_post)
    post
  end
end
