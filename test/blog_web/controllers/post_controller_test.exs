defmodule BlogWeb.PostControllerTest do
  use BlogWeb.ConnCase

  @valid_post %{
    title: "Postgres Database",
    description: "Loren"
  }

  @update_post %{
    title: "update",
    description: "update"
  }

  def fixture(:post) do
    user = Blog.Accounts.get_user!(1)

    {:ok, post} = Blog.Posts.create_post(user, @valid_post)
    post
  end

  test "entrar no formulario de criacao de posts", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> get(Routes.post_path(conn, :new))

    assert html_response(conn, 200) =~ "Novo post"
  end

  test "criar um posts através do formulario COM VALORES INVALIDOS", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 1)
      |> post(Routes.post_path(conn, :create), post: %{})

    assert html_response(conn, 200) =~ "Campo obrigatório!"
  end

  describe "depende do post criado os testes abaixo" do
    setup [:criar_post]

    test "criar um post", %{conn: conn} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> post(Routes.post_path(conn, :create), post: @valid_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Postgres Database"
    end

    test "Pegar um post por id", %{conn: conn, post: post} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post} = Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :show, post.id))
      assert html_response(conn, 200) =~ "Postgres Database"
    end

    test "Listar todos os Posts /", %{conn: conn} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post} = Blog.Posts.create_post(user, @valid_post)
      conn = get(conn, Routes.post_path(conn, :index))
      assert html_response(conn, 200) =~ "Postgres Database"
      assert "/posts" = conn.request_path
    end

    test "entrar no formulario de alteracao de posts", %{conn: conn, post: post} do
      user = Blog.Accounts.get_user!(1)
      {:ok, post} = Blog.Posts.create_post(user, @valid_post)

      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> get(Routes.post_path(conn, :edit, post))

      assert html_response(conn, 200) =~ "Editar Post"
    end

    test "alterar um posts através do formulario", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: @update_post)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.post_path(conn, :show, id)

      conn = get(conn, Routes.post_path(conn, :show, id))
      assert html_response(conn, 200) =~ "update"
    end

    test "alterar um posts através do formulario COM VALORES INVALIDOS", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> put(Routes.post_path(conn, :update, post), post: %{title: nil, description: nil})

      assert html_response(conn, 200) =~ "Editar Post"
    end

    test "apagar um post", %{conn: conn, post: post} do
      conn =
        conn
        |> Plug.Test.init_test_session(user_id: 1)
        |> delete(Routes.post_path(conn, :delete, post.id))

      assert redirected_to(conn) == Routes.post_path(conn, :index)

      assert_error_sent 404, fn -> get(conn, Routes.post_path(conn, :show, post)) end
    end
  end

  defp criar_post(_) do
    %{post: fixture(:post)}
  end
end
