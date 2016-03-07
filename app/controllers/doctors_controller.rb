class DoctorsController < ApplicationController

  def index
    doctors = params[:name] ? search_doctors(params[:name]) : Doctor.all.desc(:edu_phd)
    @cities = [['所有地區', {:href => doctors_path(:name => params[:name])}]] + Hospital.only(:city).map(&:city).uniq.map{|c| [c, {:href => doctors_path(:city => c, :name => params[:name])}]}
    if doctors.empty?
      redirect_to hospitals_path(:name => params[:name])
    else
      @doctors = doctors
      skills = @doctors.only(:skills).map(&:skills).flatten.uniq.select{|s| s =~ /\p{Han}/}
      @all_skills = [['所有專長', {:href => doctors_path(:city => params[:city])}]] + skills.map{|s| [s, {:href => doctors_path(:city => params[:city], :name => s)}]}.sort
      doctors_seo
    end
    @doctors = @doctors.where(:city => params[:city]) if params[:city]
    @doctors = @doctors.page(params[:page])
  end

  def show
    @doctors = params[:id] ? search_doctors(params[:id]) : Doctor.all.desc(:edu_phd)
    @doctor = @doctors.first
    Track.add('view_doctor', @doctor.name) if (@doctor && !is_bot?)
    doctors_seo(params[:id], doctor_url(slug_process(params[:id])))
  end

  def search_doctors(key)
    Track.add('search', key) if not is_bot?
    doctors = Doctor.where(:slug => key)
    doctors = Doctor.where(:name => /#{key}/) if doctors.empty?
    doctors = Doctor.where(:category => /#{key}/) if doctors.empty?
    doctors = Doctor.where(:skills => /#{key}/) if doctors.empty?
    return doctors.desc(:edu_phd)
  end


  def doctors_seo(title=nil, link=nil, new_keywords=nil, summary=nil, image=nil)
    image ||= "#{Setting.domain}/assets/logo.png"
    summary ||= '醫據網。選擇最適合您的醫師'
    link ||= doctors_url
    title ||= '醫據網'
    keywords = "醫據, 醫師, 醫師評價, 醫師評等"
    keywords = "#{new_keywords}, #{keywords}" if new_keywords
    page_seo(title, link, image, summary, keywords)
  end


end
