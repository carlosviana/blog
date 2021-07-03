defmodule BlogWeb.AuthControllerTest do
  use BlogWeb.ConnCase

  @ueberauth %Ueberauth.Auth{
    credentials: %{
      token: "123"
    },
    info: %{
      email: "teste@teste.com",
      first_name: "Carlos",
      last_name: "Viana",
      image: "3444444444"
    },
    provider: "google"
  }

  test "callback sucess", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth)
      |> get(Routes.auth_path(conn, :callback, "google"))

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "Bem vindo!!! #{@ueberauth.info.email}"

  end
end
