defmodule RocketpayWeb.WelcomeController do
  use RocketpayWeb, :controller

  alias Rocketpay.Numbers

  def index(conn, %{"filename" => filename}) do
    filename
      |> Numbers.sum_from_file()
      |> handle_response(conn)
    text(conn, "Welcome to the Rocketpay API")
  end

  defp handle_response({:ok, %{result: result}}, conn) do
    conn
     |> put_status(:ok)
     |> json(%{message: "welcome to rocketpay api, Here is your number #{result}"})
  end

  defp handle_response({:error, reason}, conn) do
    conn
     |> put_status(:bad_request)
     |> json(reason)
  end
end
