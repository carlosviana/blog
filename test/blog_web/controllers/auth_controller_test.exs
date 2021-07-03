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

  @ueberauth_error %Ueberauth.Auth{
    credentials: %{
      token: nil
    },
    info: %{
      email: "teste@teste.com",
      first_name: nil,
      last_name: nil,
      image: nil
    },
    provider: nil
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

  test "callback error", %{conn: conn} do
    conn =
      conn
      |> assign(:ueberauth_auth, @ueberauth_error)
      |> get(Routes.auth_path(conn, :callback, "google"))

      assert redirected_to(conn) == Routes.page_path(conn, :index)

      conn = get(conn, Routes.page_path(conn, :index))
      assert html_response(conn, 200) =~ "Algo deu errado"

  end

  test "logout sucess", %{conn: conn} do
    conn =
      conn
      |> Plug.Test.init_test_session(user_id: 2)
      |> get(Routes.auth_path(conn, :logout))

      assert redirected_to(conn) == Routes.page_path(conn, :index)
  end
end
