defmodule Communer.Ecosystem do
  use Ash.Domain

  resources do
    resource Communer.Ecosystem.Package
    resource Communer.Ecosystem.PackageVersion
    resource Communer.Ecosystem.Repo
  end
end
