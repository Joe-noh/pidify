defmodule PidifyWeb.Router do
  use PidifyWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PidifyWeb do
    pipe_through :api

    post "/generate", PdfController, :create
  end
end
