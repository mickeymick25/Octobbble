module OctopodApi
  module V0
    class Client
      API_ENDPOINT = 'https://octopod.octo.com/api/v0/'.freeze
      OAUTH_ENDPOINT = "https://octopod.octo.com/api/oauth".freeze

      attr_reader :oauth_token

      def initialize
        @connection ||= Faraday::Connection.new(API_ENDPOINT)
      end

      def project project_id
        response = authenticated_connection.get("projects/#{project_id}")
        response_hash = Oj.load(response.body).deep_symbolize_keys
        if (response_hash.has_key?(:id))
          OctopodApi::V0::Project.new(response_hash)
        else
          nil
        end
      end

      def activities project_id
        response = authenticated_connection.get("projects/#{project_id}/activities")
        response_hash = JSON.parse(response.body, symbolize_names: true)
      end

      private

      def authenticated_connection
        @connection.headers = {'Authorization': "bearer #{get_token}"}
        @connection
      end

      def get_token
        token_connection = Faraday::Connection.new(OAUTH_ENDPOINT)
        response = token_connection.post do |req|
          req.headers = {'Content-Type' => 'application/x-www-form-urlencoded', 'Accept' => 'application/json'}
          req.url "#{OAUTH_ENDPOINT}/token"
          req.body = "grant_type=client_credentials&client_id=#{ENV['OCTOPOD_CLIENT_ID']}&client_secret=#{ENV['OCTOPOD_CLIENT_SECRET']}"
        end
        response_hash = Oj.load(response.body).symbolize_keys
        response_hash[:access_token]
      end
    end

    class Project
      attr_reader :customer, :name, :business_contact, :description
      def initialize options
        @customer = options[:customer][:name]
        @name = options[:name]
        @business_contact = options[:business_contact][:nickname]
        @description = options[:mission_description]
      end
    end

    class People
      attr_reader :activity_title, :last_name, :first_name, :nickname
      attr_accessor :photo
      def initialize options
        @activity_title = options[:title]
        @last_name = options[:last_name]
        @first_name = options[:first_name]
        @nickname   = options[:nickname]
      end
    end

  end
end
