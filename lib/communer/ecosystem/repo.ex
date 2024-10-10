defmodule Communer.Ecosystem.Repo do
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
    attribute :type, :string # always "github" for now
    attribute :url, :string
  end

  relationships do
    belongs_to :package, Communer.Ecosystem.Package
  end
end
