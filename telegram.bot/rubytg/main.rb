require "telegram/bot"

token = ENV["TG_TOKEN"]

puts token

Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |msg| 
		case msg.text
		when Telegram::Bot::Types::CallbackQuery
			case msg.data
			when "touch"
				bot.api.send_message(chat_id: msg.from.id, text: "Don't touch me!")
			end
		when "/start"
			bot.api.send_message(chat_id: msg.chat.id, text: "Hello, #{msg.from.first_name}")
		when "/help"
			commands = Telegram::Bot::Types::ReplyKeyboardMarkup.new(
					keyboard: [
						[{text: '/start'}, {text: '/keyboard'}],
						[{text: '/menu'}, {text: '/faq'}]
					],
					on_time_keyboard: true
				)
			bot.api.send_message(chat_id: msg.chat.id, text: "Choose your command!", reply_markup: commands)
		when "/menu"
			kb = [[
				Telegram::Bot::Types::InlineKeyboardButton.new(text: "Go to my blog", url: "https://webgtx.me"),
				Telegram::Bot::Types::InlineKeyboardButton.new(text: "Touch me", callback_data: "touch")
			]]
			markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
			bot.api.send_message(chat_id: msg.chat.id, text: 'Welcome to the dashboard, have fun!', reply_markup: markup)
		end
	end
end

