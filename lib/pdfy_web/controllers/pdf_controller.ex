defmodule PdfyWeb.PdfController do
  use PdfyWeb, :controller

  require Base
  alias Pdfy.Document

  action_fallback PdfyWeb.FallbackController

  def create(conn, %{"html" => html}) do
    with {:ok, pdf} <- Document.generate_pdf(html),
         {:ok, binary} <- File.read(pdf.path) do
      conn
      |> put_status(:created)
      |> put_resp_header("content-type", "application/pdf")
      |> send_file(201, pdf.path)
    end
  end
end
