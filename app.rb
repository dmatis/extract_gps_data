directory = Dir.pwd
# puts directory
puts ARGV.length
if ARGV.length > 0
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

