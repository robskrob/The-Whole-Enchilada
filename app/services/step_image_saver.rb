class StepImageSaver
  def initialize(file, step_instance)
    @file = file
    @step_instance = step_instance
  end

  def run
    if file.present?
      image = Image.create(attachable_id: step_instance.id, attachable_type: 'Step')

      tmp_path = "#{Rails.root}/tmp/storage/#{file.original_filename}"

      File.open("#{tmp_path}",'wb') do |f|
        f.write file.read
      end

      image.file.attach(
        io: File.open(file.path),
        filename: file.original_filename,
        content_type: file.content_type
      )

    end
  end

  attr_accessor :step_instance

  private

  attr_accessor :file
end
