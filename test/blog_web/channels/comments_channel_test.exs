defmodule BlogWeb.CommentsChannelTest do
  use BlogWeb.ChannelCase
  alias BlogWeb.UserSocket

  @valid_post %{
    title: "Phoenix Framework",
    description: "Loren"
  }

  setup do
    user = Blog.Accounts.get_user!(1)

    {:ok, post} = Blog.Posts.create_post(user, @valid_post)

    {:ok, socket} = connect(UserSocket, %{})

    {:ok, socket: socket, post: post}
  end

  test "deve ser conectar ao socket", %{socket: socket, post: post} do
    {:ok, comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    assert post.id == socket.assigns.post_id
    assert [] == comentarios.comments
  end

  test "deve criar um comentário", %{socket: socket, post: post} do
    {:ok, _comentarios, socket} = subscribe_and_join(socket, "comments:#{post.id}", %{})

    ref = push(socket, "comment:add", "abcd")

    msg = %{comment: %{content: "abcd"}}
    assert_reply ref, :ok, %{}

    broadcast_event = "comments:#{post.id}:new"

    assert_broadcast broadcast_event, msg
    refute is_nil(msg)
  end
end
