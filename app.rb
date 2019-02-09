require 'exifr/jpeg'
require 'csv'

def clear_output_csv
  File.open('output.csv', 'w+') {}
end

# Input: absolute path to a directory to search for .jpg images
# Output: Array containing filepaths to discovered images
def get_image_paths(directory)
  Dir["#{directory}/**/*.jpg"]
end

# Input: array of image filepaths
def extract_exif_from_images(images)
  images.each { |image| extract_exif_from_image image }
end

# Input: image filename and coordinates
def write_to_csv(filename, latitude, longitude)
  CSV.open('output.csv', 'a+') do |csv|
    csv << [filename, latitude, longitude]
  end
end

# Input: absolute filename path to a .jpg image
def extract_exif_from_image(image)
  filename = File.basename(image)
  latitude = ''
  longitude = ''
  object = EXIFR::JPEG.new(image)

  unless object.gps.nil?
    latitude = object.gps.latitude
    longitude = object.gps.longitude
  end

  write_to_csv(filename, latitude, longitude)
end

directory = Dir.pwd

unless ARGV.empty?
  # Use input directory if it exists, otherwise use default
  input_dir = ARGV[0]
  if Dir.exist?(input_dir)
    directory = input_dir
  else
    puts "Directory: \"#{input_dir}\" not found"
    puts "Defaulting to: #{directory}"
  end
end

puts "Executing image scan in: #{directory}"

clear_output_csv
image_paths = get_image_paths(directory)
extract_exif_from_images(image_paths)

puts 'Script completed'
