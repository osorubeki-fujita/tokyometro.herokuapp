namespace :temp do
  namespace :completed do

    desc 'Create ::BarrierFreeFacility::Remark'
    task :update_barrier_free_facility_remark_20150713 => :environment do
      infos = ::BarrierFreeFacility::Info.all.to_a

      for i in 0..( infos.length - 1 )
        info = infos[i]
        remark_txt = info.remark

        if remark_txt.present?
          remark_in_db = ::BarrierFreeFacility::Remark.find_by( ja: remark_txt )

          if remark_in_db.present?
            remark_id_new = remark_in_db.id
          else
            ids = ::BarrierFreeFacility::Remark.all.pluck(:id)
            if ids.present?
              new_id = ids.max + 1
            else
              new_id = 1
            end

            remark_in_db = ::BarrierFreeFacility::Remark.create( id: new_id , ja: remark_txt )
            remark_id_new = remark_in_db.id

          end

          info.update( remark_id: remark_id_new )

        else
          nil
        end

      end
    end

    desc "Add patch to ::BarrierFreeFacility::Remark"
    task :add_patch_to_barrier_free_facility_remark_20150713 => :environment do
      remarks = ::BarrierFreeFacility::Remark.all.to_a

      for i in 0..( remarks.length - 1 )
        remark = remarks[i]
        remark_ja = remark.ja

        class << remark_ja
          include ::TokyoMetro::Factory::Convert::Patch::ForString::BarrierFreeFacility::Info::Remark
        end

        remark.update( ja: remark_ja.process )
      end
    end


  end
end
