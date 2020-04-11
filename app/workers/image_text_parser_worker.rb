class ImageTextParserWorker
  include Sidekiq::Worker

  def perform(name, count)
    puts "name #{name}"
    puts "count #{count}"
  end
end
