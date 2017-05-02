defmodule TerminalInYourBrowser.Web.PageController do
  use TerminalInYourBrowser.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
