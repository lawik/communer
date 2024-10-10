defmodule Communer.Ecosystem do
  use Ash.Domain, extensions: [AshAdmin.Domain]

  admin do
    show? true
  end

  resources do
    resource Communer.Ecosystem.Package
    resource Communer.Ecosystem.PackageVersion
    resource Communer.Ecosystem.Repo
  end
end
