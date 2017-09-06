defmodule PdfyWeb.Router do
  use PdfyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PdfyWeb do
    pipe_through :api

    post "/generate", PdfController, :create
  end
end
