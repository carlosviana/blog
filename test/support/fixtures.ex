defmodule Blog.Fixtures do
  alias Blog.Posts

  @valid_post %{
    title: "Phoenix Framework",
    description: "Loren"
  }

  def post_fixture(_attrs \\ %{}) do
    user = Blog.Accounts.get_user!(1)
    {:ok, post} = Posts.create_post(user, @valid_post)
    post
  end
end
