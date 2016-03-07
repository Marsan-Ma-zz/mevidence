# coding: utf-8
class Doctor
  include Mongoid::BaseModel
  before_save :gen_slug

  paginates_per 10

  field :slug
  field :city
  field :name
  field :hospital
  field :category, :default => []
  field :title
  field :edu_ms
  field :edu_phd
  field :url
  field :skills, :default => []

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:url]

  index hospital: 1
  index category: 1
  index name: 1
  
  def gen_slug
    self.slug = slug_process(self.name) if not self.slug
  end

  # Doctor.fix_doctors_cities
  def self.fix_doctors_cities
    Hospital.each do |h|
      Doctor.where(:hospital => h.name).each do |d|
        d.city = h.city
        d.save
      end
    end
  end

end
