defmodule PidifyWeb.PdfControllerTest do
  use PidifyWeb.ConnCase

  @params %{html: "<h1>こんにちわ</h1>", grayscale: true}

  setup %{conn: conn} do
    conn = conn |> put_req_header("accept", "application/json")

    %{conn: conn}
  end

  describe "create pdf" do
    @tag :skip
    test "normal case", %{conn: conn} do
      res = conn
        |> post(pdf_path(conn, :create), @params)
        |> response(201)

      assert res |> is_binary
    end
  end
end
