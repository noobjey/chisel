# $ ruby ./lib/chisel.rb my_input.markdown my_output.html
# Converted my_input.markdown (6 lines) to my_output.html (8 lines)
require './lib/renderer'

input_markdown_file_name = ARGV[0]
output_html_file_name = ARGV[1]

markdown_file = File.open(input_markdown_file_name)
html_file = File.open(output_html_file_name,'w+')

markdown = markdown_file.read

renderer = Renderer.new(markdown)

html = renderer.render

html_file.write(html)

html_file.rewind
markdown_file.rewind
puts "Converted my_input.markdown (#{markdown_file.readlines.count.to_s} lines) to my_output.html (#{html_file.readlines.count.to_s} lines)"

