defmodule PidifyWeb.PdfView do
  use PidifyWeb, :view
  alias PidifyWeb.PdfView

  def render("index.json", %{pdfs: pdfs}) do
    %{data: render_many(pdfs, PdfView, "pdf.json")}
  end

  def render("show.json", %{pdf: pdf}) do
    %{data: render_one(pdf, PdfView, "pdf.json")}
  end

  def render("pdf.json", %{pdf: pdf}) do
    %{id: pdf.id,
      name: pdf.name}
  end
end
