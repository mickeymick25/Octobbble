module AskbobApi
  module V2
    class Client
      API_ENDPOINT = 'https://askbob.octo.com/api/v2'.freeze
      OAUTH_ENDPOINT = "https://askbob.octo.com/oauth".freeze

      attr_reader :oauth_token

      def initialize
        @connection ||= Faraday::Connection.new(API_ENDPOINT)
      end

      def person trigram
        response = authenticated_connection.get("people/#{trigram}")
        response_hash = Oj.load(response.body).deep_symbolize_keys
        #Rails.logger.info("info photo :: "+response_hash[:data][:photo])
        response_hash
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
          req.body = "grant_type=client_credentials&client_id=#{ENV['ASKBOB_CLIENT_ID']}&client_secret=#{ENV['ASKBOB_CLIENT_SECRET']}"
        end
        response_hash = Oj.load(response.body).symbolize_keys
        response_hash[:access_token]
      end

    end
  end
end
