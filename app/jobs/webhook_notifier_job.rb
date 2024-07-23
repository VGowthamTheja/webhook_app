class WebhookNotifierJob < ApplicationJob
  queue_as :default

  def perform(url, data_change)
    payload = {
      id: data_change.id,
      name: data_change.name,
      data: data_change.data,
      timestamp: Time.now
    }
    signature = generate_signature(payload)

    response = HTTParty.post(url, body: payload.to_json, headers: {
      'Content-Type' => 'application/json',
      'X-Signature' => signature
    })
  end

  private

  def generate_signature(payload)
    secret = Rails.application.credentials.webhook_secret
    OpenSSL::HMAC.hexdigest('SHA256', secret, payload.to_json)
  end
end
