class BarrierFreeFacilityServiceDetailPattern < ActiveRecord::Base

  has_many :barrier_free_facility_service_details
  has_many :barrier_free_facility_infos , class: ::BarrierFreeFacility::Info , through: :barrier_free_facility_service_details
  belongs_to :operation_day

  [ :start_before_first_train , :end_after_last_train ].each do | method_base_name |
    [ method_base_name , "service_#{ method_base_name }?" , "#{ method_base_name }?" ].each do | method_name |
      eval <<-DEF
        def #{ method_name }
          service_#{ method_base_name }
        end
      DEF
    end
  end

  def has_specific_service_start_time_info?
    [ service_start_time_hour , service_start_time_min ].all?( &:integer? )
  end

  def has_specific_service_end_time_info?
    [ service_end_time_hour , service_end_time_min ].all?( &:integer? )
  end

  def has_service_time_info?
    !( service_start_before_first_train? and service_end_after_last_train? )
  end

  def has_any_info?
    operation_day_id.present? or has_service_time_info?
  end

end