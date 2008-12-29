require "rubygems"
require "rake"
require "active_support"

desc "Creates a new _posts file using TITLE='the title' and today's date. JEKYLL_EXT=markdown by default"
task :post do
  ext = ENV['JEKYLL_EXT'] || "markdown"
  unless title = ENV['TITLE']
    puts "USAGE: rake post TITLE='the post title'"
    exit(1)
  end
  post_title = "#{Date.today.to_s(:db)}-#{title.downcase.gsub(/[^\w]+/, '-')}"
  File.open(File.dirname(__FILE__) + "/_posts/#{post_title}.#{ext}", "w") do |f|
    f << <<-EOS.gsub(/^    /, '')
    ---
    layout: post
    title: #{title}
    ---
    
    EOS
  end
end