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
      |> json(%{"pdf" => Base.encode64(binary)})
    end
  end
end
