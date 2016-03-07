# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://www.mevidence.life"
SitemapGenerator::Sitemap.sitemaps_path = 'sitemap/'
SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
  # Add '/articles'
  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'

  # Events
  add root_path, :changefreq => 'daily'

  # # Bullets
  # Bullet.recent_week.latest.only(:slug, :created_at).each do |b|
  #   bday = b.created_at
  #   add bullet_path(b.slug), :lastmod => bday
  # end

  # Doctors
  Doctor.only(:slug).each do |d|
    add doctor_path(d.slug), :lastmod => Time.now.beginning_of_week
  end

  Doctor.only(:skills).map(&:skills).flatten.uniq.compact.select{|s| s =~ /\p{Han}/}.each do |s|
    add doctors_path(:id => s), :lastmod => Time.now.beginning_of_week
  end

  # Hospitals
  Hospital.only(:slug).each do |h|
    add hospital_path(:id => h.slug), :lastmod => Time.now.beginning_of_week
  end

  Hospital.only(:categories).map(&:categories).flatten.uniq.compact.select{|s| s =~ /\p{Han}/}.each do |c|
    add hospitals_path(:name => c), :lastmod => Time.now.beginning_of_week
  end

end
