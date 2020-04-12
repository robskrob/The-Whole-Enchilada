class ImageTextParserWorker
  include Sidekiq::Worker

  def perform(image_id)
#    image = Image.find(image_id)
#
#    image = RTesseract.new(image.path)
#
#    @text = image.to_s
#
#    @text.split("\n").each do |line|
#      # save into parsed line rows
#      # potentially offload into another job(s)
#    end
  end
end
