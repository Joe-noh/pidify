defmodule Pidify.Document do

  alias Pidify.Document.Pdf

  @wkhtmltopdf_path Application.get_env(:pidify, :wkhtmltopdf_path)

  def generate_pdf(html, opts) do
    html_path = tempfile_path(:html)
    pdf_path  = tempfile_path(:pdf)

    options = Pdf.from_map(opts) |> Pdf.to_options()
    options = options ++ ["--quiet", html_path, pdf_path]

    with :ok <- File.write(html_path, html),
         {_, 0} <- System.cmd(@wkhtmltopdf_path, options) do
      Pidify.FileRemover.remove_after(html_path, 5 * 60 * 1000)
      Pidify.FileRemover.remove_after(pdf_path,  5 * 60 * 1000)

      {:ok, pdf_path}
    end
  end

  defp tempfile_path(:html), do: "/tmp/#{random_string()}.html"
  defp tempfile_path(:pdf),  do: "/tmp/#{random_string()}.pdf"

  def random_string do
    :crypto.strong_rand_bytes(24)
    |> Base.url_encode64
    |> binary_part(0, 24)
  end
end
