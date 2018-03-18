module SmsTool
  @client = ZenSend::Client.new(ENV['ZENSEND_API_KEY'])

  def self.send_sms(number:, message:)
    @client.send_sms(
      originator: ENV['ZENSEND_ORIGINATOR'],
      numbers: ["#{number}"],
      body: "#{message}"
    )
  end
end