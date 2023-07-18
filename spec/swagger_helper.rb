# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.swagger_root = Rails.root.join('swagger').to_s

  SWAGGER_SUPPORT_PATH = Rails.root.join('spec', 'support', 'swagger')
  SWAGGER_DEFINITIONS_PATH = File.join(SWAGGER_SUPPORT_PATH, 'definitions', '*')
  SECURITIES = [{
    accessToken: [],
    tokenType: [],
    client: [],
    expiry: [],
    uid: []
  }]

  def fetch_definitions
    definitions_files = Dir[SWAGGER_DEFINITIONS_PATH]
    components = definitions_files.map { |f| File.basename(f, '.yml').to_sym }
    defs = {}

    definitions_files.each_with_index do |f, i|
      defs[components[i]] = YAML.safe_load(ERB.new(File.read(f)).result)
    end

    defs
  end
  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under swagger_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a swagger_doc tag to the
  # the root example_group in your specs, e.g. describe '...', swagger_doc: 'v2/swagger.json'
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      swagger: '2.0',
      info: {
        title: 'Cinema API V1',
        version: 'v1'
      },
      components: fetch_definitions,
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: 'localhost:3000'
            }
          }
        }
      ],
      securityDefinitions: {
        accessToken: {
          description: "Access Token",
          type: :apiKey,
          name: 'access-token',
          in: :header
        },
        tokenType: {
          name: 'token-type',
          type: :apiKey,
          in: :header
        },
        client: {
          description: 'Client side token',
          type: :apiKey,
          name: 'client',
          in: :header
        },
        expiry: {
          description: 'Acces token expiration',
          type: :apiKey,
          name: 'expiry',
          in: :header
        },
        uid: {
          description: 'User email',
          type: :apiKey,
          name: 'uid',
          in: :header
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The swagger_docs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.swagger_format = :yaml
end
