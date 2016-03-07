# coding: utf-8
# general use for all models
module Mongoid
  module BaseModel
    extend ActiveSupport::Concern
    included do
      include Mongoid::Document
      include Mongoid::Timestamps

      # scope :latest, desc(:created_at)
      # scope :recent, desc(:updated_at)

      index :created_at => -1
      index :updated_at => -1
    end

  
    def slug_sanitize
      self.slug = slug_process(self.slug)
    end

    def slug_process(slug)
      slug = Pinyin.t(slug, splitter: '_').gsub(/[^\w]/, "_").downcase.gsub(/__*/, '_')[0..127]
    end

  end
end

