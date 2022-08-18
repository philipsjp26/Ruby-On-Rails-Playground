Dir["%s/app/lib/oauth/*.rb" % [Rails.root.to_s]].sort.each do |source_file|
  require source_file
end
