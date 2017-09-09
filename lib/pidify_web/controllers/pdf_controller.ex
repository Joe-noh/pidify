defmodule PidifyWeb.PdfController do
  use PidifyWeb, :controller

  require Base
  alias Pidify.Document

  action_fallback PidifyWeb.FallbackController

  def create(conn, params) do
    {html, params} = Map.pop(params, "html")

    with {:ok, path} <- Document.generate_pdf(html, params) do
      conn
      |> put_status(:created)
      |> put_resp_header("content-type", "application/pdf")
      |> send_file(201, path)
    end
  end
end
