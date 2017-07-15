include Facebook::Messenger

Bot.on :message do |message|

  user = User.first_or_create(messenger_id: message.sender['id'])

  message.reply(text: 'Hello, human!')
end

Bot.on :postback do |postback|

  user = User.first_or_create(messenger_id: postback.sender['id'])

  postback.reply(text: 'Hello, human!')
end
