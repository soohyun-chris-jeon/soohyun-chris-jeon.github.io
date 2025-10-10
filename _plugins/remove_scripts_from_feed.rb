# _plugins/clean_feed.rb
Jekyll::Hooks.register :site, :post_write do |site|
  feed_files = ['feed.xml', 'atom.xml']
  feed_files.each do |file|
    path = File.join(site.dest, file)
    if File.exist?(path)
      content = File.read(path)
      content.gsub!(/<script[\s\S]*?<\/script>/, '')
      File.write(path, content)
    end
  end
end
