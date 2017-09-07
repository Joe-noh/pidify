defmodule Pdfy.Document.PdfTest do
  use ExUnit.Case, async: true

  alias Pdfy.Document.Pdf

  describe "generated functions" do
    test "set given value to corresponding attribute" do
      pdf = %Pdf{}
        |> Pdf.image_quality(96)

      assert pdf.image_quality == 96
    end

    test "set nothing if nil given" do
      pdf = %Pdf{}
        |> Pdf.image_quality(96)
        |> Pdf.image_quality(nil)

      assert pdf.image_quality == 96
    end
  end

  describe "from_map/1" do
    test "build Pdf struct with given map which key is atom" do
      pdf = Pdf.from_map(%{grayscale: true})

      assert pdf.grayscale == true
      assert pdf.page_size == nil
    end

    test "build Pdf struct with given map which key is string" do
      pdf = Pdf.from_map(%{"grayscale" => true})

      assert pdf.grayscale == true
      assert pdf.page_size == nil
    end
  end

  describe "to_options/1" do
    test "returns wkhtmltopdf options list" do
      opts = %Pdf{}
        |> Pdf.dpi(72)
        |> Pdf.image_quality(96)
        |> Pdf.page_size("A4")
        |> Pdf.lowquality(true)
        |> Pdf.grayscale(false)
        |> Pdf.to_options()

      assert opts == [
        "--page-size", "A4",
        "--lowquality",
        "--image-quality", "96",
        "--dpi", "72"
      ]
    end
  end
end
