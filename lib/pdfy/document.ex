defmodule Pdfy.Document do
  alias Pdfy.Document.Pdf

  @wkhtmltopdf_path Application.get_env(:pdfy, :wkhtmltopdf_path)

  def generate_pdf(html) do
    with :ok <- File.write("/tmp/a.html", html),
         {_, 0} <- System.cmd(@wkhtmltopdf_path, ["--quiet", "/tmp/a.html", "/tmp/a.pdf"]) do

      {:ok, %Pdf{path: "/tmp/a.pdf"}}
    end
  end
end
