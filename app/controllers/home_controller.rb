class HomeController < ApplicationController

  def index
    # SEO
    image = ''
    summary = '醫據網。選擇最適合您的醫師'
    link = doctors_url
    title = '醫據網'
    keywords = "醫據, 醫師, 醫院, 醫師評價, 醫院評價"
    keywords += ", #{params[:name]}" if params[:name]
    page_seo(title, link, image, summary, keywords)
  end


end
