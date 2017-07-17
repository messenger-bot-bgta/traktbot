include Facebook::Messenger

Bot.on :message do |message|

  user = User.first_or_create(messenger_id: message.sender['id'])

  actions = {

    send: -> (request, response) {
      message.reply(text: response['text'])
    },

    last_watched: -> (request) {
      puts("Last watched")

      request['context']['movies'] = Trakt.new({}).watched

      return request['context']
    },

    show_last_watched: -> (request) {
      puts("Show last watched")

      Tmdb::Api.key("2152d9a34c711f3e1570bc0c8c8285aa")

      elements = request['context']['movies'].map do |movie|
        detail = Tmdb::Movie.detail(movie['movie']['ids']['tmdb'])
        {
          title: movie['movie']['title'],
          image_url: "https://image.tmdb.org/t/p/w500/#{detail['poster_path']}",
          subtitle: movie['movie']['year']
        }
      end

      puts elements


      message.reply(
        attachment:{
          type:"template",
          payload:{
            template_type:"generic",
            image_aspect_ratio: 'square',
            elements:elements
          }
        }
      )

      return request['context']
    },

  }

  wit_client = Wit.new(access_token: 'EMKOS5HR4IHDIRZURA2GXSCIES35ZV6P', actions: actions)

  rsp = wit_client.run_actions(message.sender["id"], message.text)

end

Bot.on :postback do |postback|

  user = User.first_or_create(messenger_id: postback.sender['id'])

  postback.reply(text: 'Hello, human!')
end
