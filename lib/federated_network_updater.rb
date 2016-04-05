module FederatedNetworkUpdater
  require 'json'
  require 'net/http'
  require './app/models/federated_network'

  def import_json
    source = 'http://directory.noosfero.org/all.json'
    begin
      resp = Net::HTTP.get_response(URI.parse(source))
    rescue Exception => ex
      Rails.logger.error "Import Federated Networks Error: #{ex}"
    end
    @data = JSON.parse(resp.body)
  end

  def process_data
    import_json
    @data['sites'].each do |site|
      federated_network = FederatedNetwork.find_or_create_by(url: site['url'])
      federated_network.update(name: site['name'],
                               identifier: site['id'],
                               screenshot: site['screnshot'],
                               thumbnail: site['thumbnail'])
    end
  end
end
