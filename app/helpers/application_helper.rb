module ApplicationHelper
  def svg(name)
    file_path = "#{Rails.root}/public/icons/#{name}.svg"
    return File.read(file_path).html_safe if File.exists?(file_path)
    '(not found)'
  end
end
