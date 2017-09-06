defmodule Pdfy.Document do

  def generate_pdf(html) do
    html_path = tempfile_path(:html)
    pdf_path  = tempfile_path(:pdf)

    options = ["--quiet", html_path, pdf_path]

    with :ok <- File.write(html_path, html),
         {_, 0} <- System.cmd("wkhtmltopdf", options) do
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
