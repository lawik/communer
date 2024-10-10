defmodule Communer.Ecosystem.Package do
  use Ash.Resource, domain: Communer.Ecosystem, data_layer: AshPostgres.DataLayer

  actions do
    defaults [:read, :create, :update, :destroy]
  end

  postgres do
    table "packages"
    repo Communer.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :name, :string
    attribute :latest_version, :string
  end

  relationships do
    has_many :versions, Communer.Ecosystem.PackageVersion
    has_many :repos, Communer.Ecosystem.Repo
  end
end
