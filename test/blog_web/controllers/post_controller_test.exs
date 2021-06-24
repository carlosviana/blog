defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Postgres Database",
    description: "Loren"
  }

  test "Listar todos os Posts /", %{conn: conn} do
    Blog.Posts.create_post(@valid_post)
    conn = get(conn, Routes.post_path(conn, :index))
    assert html_response(conn, 200) =~ "Postgres Database"
    assert "/posts" = conn.request_path
  end
end
