defmodule Communer.Ecosystem.PackageVersion do
  use Ash.Resource, domain: Communer.Ecosystem, data_layer: AshPostgres.DataLayer

  actions do
    defaults [:read, :create, :update, :destroy]
  end

  postgres do
    table "package_versions"
    repo Communer.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :version, :string
  end

  relationships do
    belongs_to :package, Communer.Ecosystem.Package
  end

end
