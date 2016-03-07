class HospitalsController < ApplicationController

  def index
    hospitals = params[:name] ? search_hospitals(params[:name]) : Hospital.all
    hospitals = hospitals.where(:city => params[:city]) if params[:city]
    hospitals = hospitals.where(:categories => params[:cat]) if params[:cat]
    @hospitals = hospitals.desc(:city).page(params[:page])
    @all_cities = [['所有地區', {:href => hospitals_path(:cat => params[:cat])}]] + hospitals.only(:city).map(:city).uniq.map{|s| [s, {:href => hospitals_path(:city => s, :cat => params[:cat])}]}
    @all_categories = [['所有科別', {:href => hospitals_path(:city => params[:city])}]] + hospitals.only(:categories).map(:categories).flatten.uniq.map{|s| [s, {:href => hospitals_path(:cat => s, :city => params[:city])}]}
    hospitals_seo
  end

  def show
    key = params[:id]
    hospitals = key ? search_hospitals(key) : Hospital.all.desc(:city)
    @hospital = hospitals.first
    Track.add('view_hospital', @hospital.name) if (@hospital && !is_bot?)
    all_doctors = Doctor.where(:hospital => @hospital.name)
    if params[:cat]
      @doctors = Doctor.where(:hospital => @hospital.name, :skills => params[:cat])
    else
      @doctors = all_doctors
    end
    @categories = [['所有科別', {:href => hospital_path(:id => @hospital.name)}]] + all_doctors.map(&:skills).flatten.uniq.select{|s| s =~ /\p{Han}/}.map{|s| [s, {:href => hospital_path(:id => @hospital.name, :cat => s)}]}
    # @categories = @doctors.map(&:skills).flatten.uniq.map{|s| [s, "?cat=s"]}
    hospitals_seo(key, hospitals_url(slug_process(key)))
  end

  def search_hospitals(key)
    Track.add('search', key) if not is_bot?
    hospitals = Hospital.where(:slug => key)
    hospitals = Hospital.where(:name => /#{key}/) if hospitals.empty?
    hospitals = Hospital.where(:city => /#{key}/) if hospitals.empty?
    hospitals = Hospital.where(:categories => /#{key}/) if hospitals.empty?
    return hospitals
  end

  def hospitals_seo(title=nil, link=nil, new_keywords=nil, summary=nil, image=nil)
    image ||= "#{Setting.domain}/assets/logo.png"
    summary ||= '醫據網。選擇最適合您的醫院'
    link ||= hospitals_url
    title ||= '醫據網'
    keywords = "醫據, 醫院, 醫院評價, 醫院評等"
    keywords = "#{new_keywords}, #{keywords}" if new_keywords
    page_seo(title, link, image, summary, keywords)
  end

end
