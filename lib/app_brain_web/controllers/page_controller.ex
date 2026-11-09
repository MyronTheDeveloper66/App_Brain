defmodule AppBrainWeb.PageController do
  use AppBrainWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
