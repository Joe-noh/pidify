defmodule Pdfy.Document do
  alias Pdfy.Document.Pdf

  def generate_pdf(html) do
    with :ok <- File.write("/tmp/a.html", html),
         {_, 0} <- System.cmd("wkhtmltopdf", ["--quiet", "/tmp/a.html", "/tmp/a.pdf"]) do

      {:ok, %Pdf{path: "/tmp/a.pdf"}}
    end
  end
end
