class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def page_seo(title, link, image, summary, keywords)
    # meta
    set_meta_tags :title => "#{title}", :description => summary, :keywords => keywords, :reverse => true
    set_meta_tags :og => {
      :title    => title,
      :type     => 'article',
      :url      => link,
      :site_name => Setting.app_name,
      :description => summary,
      :image    => image,
    }
  end

  def slug_process(slug)
    slug = Pinyin.t(slug, splitter: '_').gsub(/[^\w]/, "_").downcase.gsub(/__*/, '_')[0..127]
  end
  
  def is_bot?
    return (request.user_agent.downcase =~ /bot|crawler|spider|disqus|facebook|google|linode/)
  end
  helper_method :is_bot?

end

