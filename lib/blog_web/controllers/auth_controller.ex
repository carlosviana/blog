defmodule BlogWeb.AuthController do
  use BlogWeb, :controller

  plug Ueberauth

  alias Blog.Accounts

  def logout(conn, _) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  def request(conn, _params) do
    render(conn, "index.html")
  end

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, %{"provider" => provider}) do
    user = %{
      token: auth.credentials.token,
      email: auth.info.email,
      first_name: auth.info.first_name,
      last_name: auth.info.last_name,
      image: auth.info.image,
      provider: provider
    }

    case Accounts.create_user(user) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Bem vindo!!! #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:error, "Algo deu errado")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end
end
