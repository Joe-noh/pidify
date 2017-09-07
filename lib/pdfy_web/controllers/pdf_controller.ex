defmodule PdfyWeb.PdfController do
  use PdfyWeb, :controller

  require Base
  alias Pdfy.Document

  action_fallback PdfyWeb.FallbackController

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
