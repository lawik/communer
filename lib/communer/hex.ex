defmodule Communer.Hex do
  alias Communer.Hexer
  alias Communer.Ecosystem.Package

  def fetch_popular do
    Hexer.request!(:hex_api_package, :search, ["", [sort: "recent_downloads"]], fn data ->
      data
      |> Enum.map(fn entry ->
        dbg(entry)
        Package.create(entry["name"], entry["latest_stable_version"])
        |> dbg()
      end)
    end)
  end
end
