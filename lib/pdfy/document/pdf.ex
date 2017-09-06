defmodule Pdfy.Document.Pdf do
  @attrs ~w[
    dpi
    grayscale
    image_dpi
    image_quality
    lowquality
    margin_bottom
    margin_left
    margin_right
    margin_top
    page_size
    page_height
    page_width
    title
  ]a

  defstruct @attrs

  def to_options(pdf) do
    Enum.reduce @attrs, [], fn (attr, acc) ->
      case Map.get(pdf, attr) do
        nil -> acc
        false -> acc
        true -> [optionize(attr) | acc]
        val -> [optionize(attr), to_string(val) | acc]
      end
    end
  end

  Enum.map(@attrs, fn attr ->
    def unquote(attr)(pdf, nil), do: pdf
    def unquote(attr)(pdf, val), do: pdf |> Map.put(unquote(attr), val)
  end)

  defp optionize(attr) do
    attr
    |> Atom.to_string()
    |> String.replace("_", "-")
    |> prepend_dashes()
  end

  defp prepend_dashes(str), do: "--" <> str
end
