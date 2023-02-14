require 'discordrb/webhooks'
require 'discordrb'
require 'yaml'


webhook = YAML.load_file('webhook.yml')
token = YAML.load_file('token.yml')


bot = Discordrb::Bot.new token: token
a = ["stealer","grabber","rat","scam","https","blitzed","child","cp","porn"]

File.readlines('naughtywords.txt').each do |line|
    a.append(line)
end



prefix = "."

WEBHOOK_CLIENT = Discordrb::Webhooks::Client.new(url: webhook).freeze


def SendWebhook(username,message,url)
    WEBHOOK_CLIENT.execute do |builder|
        builder.content = message
        builder.username =  username
        builder.avatar_url = url
      end
end


bot.message do |event|
    a.each do |esex|
        if event.message.content.include? esex then
            if event.message.webhook? == false then
                event.message.delete("Wanted to")
                SendWebhook(event.message.author.username,event.message.content,event.message.author.avatar_url)
            end
        end
    end
end


bot.message(with_text: prefix + 'cat') do |event|

end

bot.run
