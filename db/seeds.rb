# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

::TokyoMetro::Factory::Seed.process
::TokyoMetro::Factory::Scss::TrainType.make

__END__

# すべての駅の駅施設情報
 f = TokyoMetro::Api.station_facilities
 f.class # => TokyoMetro::Api::StationFacility::Array
 
 # 各駅の駅施設情報のクラス
f_class = f.map { |i| i.class }.uniq # => [TokyoMetro::Api::StationFacility::Info]

# すべての駅の platform_info の配列
p = f.map do | facility | ; facility.platform_info ; end
p.class # => Array

# 各駅の platform_info のクラス
p_class = p.map { |i| i.class }.uniq # => [TokyoMetro::Api::StationFacility::Info::Platform::Array]

# 各駅の platform_info の要素のクラス
p_element_class = p.map { |i| i.map { |e| e.class }.uniq }.uniq.flatten # => [TokyoMetro::Api::StationFacility::Info::Platform::Info]

platform_infos = p.flatten
platform_infos.length # => 3041

platform_infos.map { |i| i.transfer_information.class }.uniq # => [NilClass, TokyoMetro::Api::StationFacility::Info::Platform::Transfer::Array]

r = TokyoMetro::Api.station_facilities.map { | facility | facility.platform_info }.flatten.map { |i| i.transfer_information }.select { |i| i.class == ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::Array }.flatten.map { |i| i.railway }.flatten.uniq.sort

d = TokyoMetro::Api.station_facilities.map { | facility | facility.platform_info }.flatten.map { |i| i.transfer_information }.select { |i| i.class == ::TokyoMetro::Api::StationFacility::Info::Platform::Transfer::Array }.flatten.map { |i| i.railway_direction }.flatten.uniq.select { |i| i != nil }.sort