# coding: utf-8
class Hospital
  include Mongoid::BaseModel
  before_save :gen_slug

  paginates_per 10

  field :slug
  field :city
  field :name
  field :alias, :default => []
  field :level
  field :url
  field :code
  field :categories, :default => []
  field :qualify
  field :edu_qualify
  field :qualify_period
  field :edu_qualify_period
  field :phone, :default => []
  field :address

  validates_presence_of :name
  validates_uniqueness_of :name, :scope => [:url]

  index city: 1
  index name: 1
  
  def gen_slug
    self.slug = slug_process(self.name) if not self.slug
  end

end
