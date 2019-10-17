module OctopodApi
  module V0
    class Client
      API_ENDPOINT = 'https://octopod.octo.com/api/v0/'.freeze

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

      private

      def authenticated_connection
        @connection.headers = {'Authorization': "bearer #{get_token}"}
        @connection
      end

      def get_token
        "nfV41-sIRr1gLOpVJP9AZMxvgvjIG6KWGbA2NUntriM"
        #curl -X POST --header 'Content-Type: application/x-www-form-urlencoded' --header 'Accept: application/json' --header 'Authorization: Bearer >put your access token here<' -d 'grant_type=client_credentials&client_id=q9_6u_RYcigV6P1YLNDc0wCFjqoxc78UMiTVDwf_oRU&client_secret=tjXNqYIv-trHuJy2DzW89iLNnb9HFmXhu3vvbPQ8sNY' 'https://octopod.octo.com/api/oauth/token'
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
  end
end

# {"id"=>2146908867, 
# "url"=>"https://octopod.octo.com/api/v0/projects/2146908867", 
# "name"=>"Accompagnement Fonctionnel sur les API", 
# "kind"=>"fixed_price", 
# "reference"=>"2019-0865F", 
# "status"=>"mission_signed",
# "customer"=>{
## "id"=>1423, 
## "name"=>"BNP Paribas Personal Finance", 
## "sector"=>{"id"=>21, "name"=>"FS - Banking", "sector_group"=>{"id"=>3, "name"=>"FS"}}, 
## "subsidiary"=>{"id"=>1, "name"=>"OCTO France", "region"=>"fr", "chrono_prefix"=>"FR", "locale"=>"fr", "timezone"=>"Europe/Paris", "active"=>true, "url"=>"https://octopod.octo.com/api/v0/subsidiaries/1", "currency"=>{"symbol"=>"€"}}, 
## "customer_group"=>{"id"=>239, "name"=>"BNP PARIBAS"}}, 
# "customer_contract_reference"=>"BNP PARIBAS PERSONAL FINANCE\r\nEAA97 Direction Digitale\r\nTSA 10001\r\n14913 CAEN Cedex 9\r\n\r\nV/Contacts : Grégory Desfosses et Ludovic BONNARD", 
# "comment"=>"N/A", 
# "mission_description"=>"<p>API, opportunit&eacute;s business</p><p>Guidelines partag&eacute;es entre les pays &quot;PF as a service&quot; &gt; technical guidelines</p><p>(pas de partie gouvernance)</p><p>B2B2C</p><p>Commencer la partie design fonctionnel</p><p><em>Installment Loan</em> &gt; bien pr&eacute;sent dans tous les pays &gt; insights r&eacute;cup&eacute;r&eacute;s aupr&egrave;s d&#39;un partenaire (on a les parcours clients, les data)</p><p></p><p>&gt; r&eacute;aliser le design de cette API&gt; pattern d&#39;architecture &gt; qu&#39;est ce qu&#39;on peut standardiser ?</p><p>&gt; organisation</p><p></p><p><strong>&Eacute;tat des lieux</strong> : tour des partenaires, des &eacute;quipes business et de l&#39;IT</p><p>C&#39;est quoi le probl&egrave;me auquel on essaie de r&eacute;pondre ? votre besoin ? Que demande les partenaires ?</p><p></p><p>&gt; Identifier un PO c&ocirc;t&eacute; BNPP PF&nbsp;</p><p>&gt; le design d&#39;un parcours client installment loan</p><p></p><p><strong>Livrables du forfait :</strong>&nbsp;</p><p>- Fournir des principes/des guidelines</p><p>- Mod&egrave;le de donn&eacute;es qui permettent de le faire ou pas&nbsp;</p><p>- Une API use case :&nbsp;installment loan&nbsp;</p><p></p>",
# "competition_type"=>"competitive", 
# "success_probability"=>25, 
# "nature"=>"consulting", 
# "mission_maker"=>"octo_only", 
# "amount"=>"35000.0", 
# "decision_maker"=>"Jérémy Segura", 
# "project_group"=>nil, 
# "business_contact"=>{"id"=>2142664779, "last_name"=>"Gros", "first_name"=>"Clara", "nickname"=>"CGR", "url"=>"https://octopod.octo.com/api/v0/people/2142664779"}, 
# "mission_director"=>{"id"=>2142664836, "last_name"=>"Mino", "first_name"=>"Quentin", "nickname"=>"QUEN", "url"=>"https://octopod.octo.com/api/v0/people/2142664836"}, 
# "proposal_link"=>"https://driveway-prod.herokuapp.com/drive/2146908867", 
# "created_at"=>"2019-04-24T07:51:53Z", 
# "updated_at"=>"2019-10-14T09:21:56Z", 
# "start_date"=>"2019-10-08", 
# "end_date"=>"2019-12-31", 
# "locations"=>"Paris, Levallois", 
# "wbs"=>"BISHK001"}

