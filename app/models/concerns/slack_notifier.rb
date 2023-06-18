class SlackNotifier
  attr_reader :client

  # 環境SLACK_WEBHOOK_URLにwebhook urlを格納
  WEBHOOK_URL = ENV['SLACK_WEBHOOK_URL']
  CHANNEL = "#communicator_app"

  def send(message)
    Slack::Notifier.new(WEBHOOK_URL, channel: CHANNEL).ping('message')
  end
end