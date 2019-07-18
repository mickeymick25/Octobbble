# require 'net/http'
# require 'json'
# require 'digest/hmac'

class AskbobClient
#   BASE_URL = "https://askbob.octo.com/oauth/token";

#   def initialize(apiKey, secretKey)
# 		@apiKey = apiKey
# 		@secKey = secretKey
# 	end

#   def sendRequest(method, url, params, files = {})
# 		# create full url
# 		fullUrl = BASE_URL + url
# 		# calculate signature
# 		sig = calculateSignature(method, fullUrl, params)
# 		# create request object
# 		urlObj = URI.parse(BASE_URL + url)

# 		case method
# 		when 'GET'
# 			req = Net::HTTP::Get.new(urlObj.to_s)
# 		when 'POST'
# 			req = Net::HTTP::Post.new(urlObj.to_s)
# 		when 'PUT'
# 			req = Net::HTTP::Put.new(urlObj.to_s)
# 		when 'DELETE'
# 			req = Net::HTTP::Delete.new(urlObj.to_s)
# 		end

# 		# add key headers
# 		req.add_field('key', @apiKey)
# 		req.add_field('sig', sig)

# 		if method == "POST"
# 			postparams = []
# 			files.each do |key, value|
# 				postparams << [key, value]
# 			end
# 			params.each do |key, value|
# 				postparams << [key, value]
# 			end
# 			req.set_form postparams, 'multipart/form-data'
# 		else
# 			if params.length
# 				req.body = hash_to_querystring(params)
# 			end
# 		end

# 		# make the request
# 		res = Net::HTTP.start(urlObj.host, urlObj.port) {|http|
# 			http.request(req)
# 		}

# 		json = JSON.parse(res.body)
# 		return json
# 	end

#   def calculateSignature(method, url, params)
# 		paramsStr = ''
# 		params.sort.map do |key,value|
# 		  paramsStr = paramsStr + value.to_s
# 		end
# 		hmacBase = method + url + paramsStr
# 		sig = Digest::HMAC.hexdigest(hmacBase, @secKey, Digest::SHA256)
# 		return sig
# 	end

#   def hash_to_querystring(hash)
# 		hash.keys.inject('') do |query_string, key|
# 			if key.respond_to?('gsub')
# 				query_sitring << '&' unless key == hash.keys.first
# 				query_string << "#{URI.encode(key.to_s)}=#{URI.encode(hash[key])}"
# 			end
# 		end
# 	end

#   def _get(url)
# 		return sendRequest('GET', url, {})
# 	end

# 	def _post(url, params = {}, files = {})
# 		return sendRequest('POST', url, params, files)
# 	end

# 	def _put(url, params = {})
# 		return sendRequest('PUT', url, params)
# 	end

# 	def _delete(url, params = {})
# 		return sendRequest('DELETE', url, params)
# 	end

end
