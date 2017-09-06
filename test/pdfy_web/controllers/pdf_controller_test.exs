defmodule PdfyWeb.PdfControllerTest do
  use PdfyWeb.ConnCase

  @params %{html: "<h1>こんにちわ</h1>"}

  setup %{conn: conn} do
    conn = conn |> put_req_header("accept", "application/json")

    %{conn: conn}
  end

  describe "create pdf" do
    test "normal case", %{conn: conn} do
      json = conn
        |> post(pdf_path(conn, :create), @params)
        |> json_response(201)

      assert json["pdf"] |> is_binary
    end
  end
end
