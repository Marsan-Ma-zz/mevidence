# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'creek'
require 'open-uri'

Doctor.delete_all
Hospital.delete_all

def get_files
  files = {
    'doctors' => 'https://docs.google.com/spreadsheets/d/10OHDzxVRymo08PtR3DD7XnI6z36Q62G9ey5KvaKYj8c/edit?usp=sharing',
    'hospitals' => 'https://docs.google.com/spreadsheets/d/1ud8q2XmLJIDkydG6oeZ2APshopxjSu8EZ0aUFjuLOXY/edit?usp=sharing'
  }
  files.each do |k,v|
    File.open("./db/raw/#{k}.xlsx", "wb") do |saved_file|
      open(v, "rb") do |read_file|
        saved_file.write(read_file.read)
      end
    end
  end
end

def parsein_doctors
  creek = Creek::Book.new "./db/raw/doctors.xlsx"
  for sheet in creek.sheets
    p "[Doctor] #{Doctor.count} doctors before parsed in @ #{Time.now.to_s[0..18]}."
    start_of_data = false
    sheet.rows.each do |r|
      row = r.values
      start_of_data = true if (row[0] == 'START_OF_DATA')
      break if (row[0] == 'END_OF_DATA')
      if start_of_data
        d = Doctor.new(
          :hospital => row[0], 
          :category => row[1], 
          :title => row[2],
          :name => row[3],
          :edu_ms => row[5],
          :edu_phd => row[6], 
          :skills => (row[7] ? row[7].split(/,|、|，/).uniq : []),
          :url => row[8],
        )
        d.save
      end
    end
  end
  p "[Doctor] #{Doctor.count} doctors after parsed in @ #{Time.now.to_s[0..18]}."
end

def parsein_hospitals
  creek = Creek::Book.new "./db/raw/hospitals.xlsx"
  for sheet in creek.sheets
    p "[Hospital] #{Hospital.count} hospitals before parsed in @ #{Time.now.to_s[0..18]}."
    start_of_data = false
    sheet.rows.each do |r|
      row = r.values
      start_of_data = true if (row[0] == 'START_OF_DATA')
      break if (row[0] == 'END_OF_DATA')
      if start_of_data
        cats = row[7] ? row[7].split('、') : []
        d = Hospital.new(
          :city => row[0], 
          :name => row[1], 
          :alias => row[2],
          :level => row[3], 
          :url => row[4],
          :phone => row[5], 
          :address => row[6],
          :categories => cats, 
          # :code => row[4], 
          # :qualify => row[8], 
          # :edu_qualify => row[9],
          # :qualify_period => row[10], 
          # :edu_qualify_period => row[11], 
          )
        d.save
      end
    end
  end
  p "[Hospital] #{Hospital.count} hospitals after parsed in @ #{Time.now.to_s[0..18]}."
end

# get_files
parsein_doctors
parsein_hospitals
Doctor.fix_doctors_cities
