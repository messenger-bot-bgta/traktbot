include Facebook::Messenger

Bot.on :message do |message|

  user = User.first_or_create(messenger_id: message.sender['id'])

  message.reply(text: 'Hello, human!')

  client = OAuth2::Client.new('58204fc7a1d802e428755a14e4ce59840dcc1b8ac6add88ead921e8f129b71c1', '17883f09805b0adc71e007b63a0ffd057727d217ab9322fe3e7fe0565c56e601', site: 'https://api.trakt.tv')
  url = client.auth_code.authorize_url(:redirect_uri => 'https://708fd9b2.ngrok.io/oauth2/callback')

  message.reply({
    attachment:{
      type:"template",
      payload:{
        template_type:"button",
        text:"What do you want to do next?",
        buttons:[
          {
            type:"web_url",
            url: url,
            title:"View Item",
            webview_height_ratio: "tall",
            webview_share_button: "hide",
            messenger_extensions: true
          }
        ]
      }
    }
  })


end

Bot.on :postback do |postback|

  user = User.first_or_create(messenger_id: postback.sender['id'])

  postback.reply(text: 'Hello, human!')
end
