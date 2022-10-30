if Rails.env == 'production'
  ENV['ELASTICSEARCH_URL'] = ENV['BONSAI_URL']

end

module Elasticsearch
  class Client
    def verify_with_version_or_header(body, version, headers)
      @verified = true
    end
  end
end
