defmodule PdfyWeb.PdfController do
  use PdfyWeb, :controller

  alias Pdfy.Document
  alias Pdfy.Document.Pdf

  action_fallback PdfyWeb.FallbackController

  def create(conn, %{"html" => html}) do
    with {:ok, %Pdf{} = pdf} <- Document.generate_pdf(html) do
      conn
      |> put_status(:created)
      |> json(%{"created" => "yes"})
    end
  end
end
