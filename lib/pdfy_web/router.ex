defmodule PdfyWeb.Router do
  use PdfyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PdfyWeb do
    pipe_through :api
  end
end
