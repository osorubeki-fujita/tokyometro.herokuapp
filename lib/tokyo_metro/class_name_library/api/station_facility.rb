# 駅施設情報 odpt:StationFacility を扱うクラスのリスト
module TokyoMetro::ClassNameLibrary::Api::StationFacility

  extend ::ActiveSupport::Concern

  module ClassMethods

    # @!group クラスメソッド (1) - メタデータ

    # クラス指定 - odpt:StationFacility
    # @return [String]
    def rdf_type
      "odpt:StationFacility"
    end

    # JSON-LD 仕様に基づく context のURL - URL
    # @return [String]
    def context
      "http://vocab.tokyometroapp.jp/context_odpt_StationFacility.jsonld"
    end

    # @!group 生成するクラスの情報

    # トップレベルのクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility )]
    def toplevel_namespace
      ::TokyoMetro::Api::StationFacility
    end

    # 配列のクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility::List )]
    def list_class
      ::TokyoMetro::Api::StationFacility::List
    end

    # 配列の要素となるインスタンスのクラス
    # @return [Const ( ::TokyoMetro::Api::StationFacility::Info )]
    def info_class
      ::TokyoMetro::Api::StationFacility::Info
    end

    def barrier_free_top_level_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree
    end

    def barrier_free_list_class
      TokyoMetro::Api::StationFacility::Info::BarrierFree::List
    end

    def barrier_free_meta_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Info
    end

    def barrier_free_elevator_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Elevator::Info
    end

    def barrier_free_escalator_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info
    end

    def barrier_free_link_for_mobility_scooter_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::LinkForMobilityScooter::Info
    end

    def barrier_free_stairlift_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Stairlift::Info
    end

    def barrier_free_toilet_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info
    end

    def barrier_free_toilet_assinstant_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant
    end

    def barrier_free_service_detail_list_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::List
    end

    def barrier_free_service_detail_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info
    end

    def escalator_service_detail_list_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::List
    end

    def escalator_service_detail_info_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Info
    end

    def escalator_service_detail_direction_class
      ::TokyoMetro::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction
    end

    def platform_list_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::List
    end

    def platform_info_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info
    end

    def platform_transfer_list_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::List
    end

    def platform_transfer_info_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::Transfer::Info
    end

    def platform_barrier_free_list_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::BarrierFree::List
    end

    def platform_barrier_free_info_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::BarrierFree::Info
    end

    def platform_surrounding_area_list_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::SurroundingArea::List
    end

    def platform_surrounding_area_info_class
      ::TokyoMetro::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info
    end

    # @!group Factory Pattern のクラスの情報

    # API からデータを取得するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Get::Api::DataSearch::StationFacility )]
    def factory_for_getting
      ::TokyoMetro::Factory::Get::Api::DataSearch::StationFacility
    end

    # API から取得したデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::StationFacility::EachFile )]
    def factory_for_saving_to_each_file
      ::TokyoMetro::Factory::Save::Api::StationFacility::EachFile
    end

    # グループ化されたデータを保存するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Save::Api::StationFacility::Group )]
    def factory_for_saving_datas_of_each_group
      ::TokyoMetro::Factory::Save::Api::StationFacility::Group
    end

    def list_class_for_saving_grouped_infos
      ::TokyoMetro::Factory::Save::Api::StationFacility::Group::List
    end

    def file_info_class_for_saving
      ::TokyoMetro::Factory::Save::Api::StationFacility::Group::FileInfo
    end

    # JSON をパースして得られた配列の要素である Hash からインスタンスを作成するメソッドための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::StationFacility::Info )]
    def factory_for_generating_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info
    end

    # @note {::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Info} でないことに注意
    def factory_for_generating_barrier_free_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info
    end

    def factory_for_generating_barrier_free_service_detail_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::ServiceDetail::Info
    end

    def factory_for_generating_barrier_free_elevator_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Elevator
    end

    def factory_for_generating_barrier_free_escalator_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator
    end

    def factory_for_generating_barrier_free_escalator_service_detail_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator::ServiceDetail::Info
    end

    def factory_for_generating_barrier_free_escalator_service_detail_direction
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Escalator::ServiceDetail::Direction
    end

    def factory_for_generating_barrier_free_link_for_mobility_scooter_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::LinkForMobilityScooter
    end

    def factory_for_generating_barrier_free_stairlift_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Stairlift
    end

    def factory_for_generating_barrier_free_toilet_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Toilet
    end

    def factory_for_generating_barrier_free_toilet_assistant_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::BarrierFree::Info::Facility::Toilet::Assistant
    end

    def factory_for_generating_platform_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info
    end

    def factory_for_generating_platform_barrier_free_info_from_string
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::BarrierFree::Info
    end

    def factory_for_generating_platform_transfer_info_from_hash
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::Transfer::Info
    end

    def factory_for_generating_platform_surrounding_area_info_from_string
      ::TokyoMetro::Factory::Generate::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info
    end

    # 保存済みの情報を処理しインスタンスを復元するための Factory Pattern クラス
    # @return [Const ( ::TokyoMetro::Factory::Generate::Api::StationFacility::List )]
    def factory_for_generating_from_saved_file
      ::TokyoMetro::Factory::Generate::Api::StationFacility::List
    end

    # @!group DB

    def factory_for_seeding_list
      ::TokyoMetro::Factory::Seed::Api::StationFacility::List
    end

    def factory_for_seeding_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info
    end

    def factory_for_seeding_barrier_free_facilities
      ::TokyoMetro::Factory::Seed::Api::StationFacility::List::BarrierFree
    end

    def factory_for_seeding_barrier_free_facilities_of_each_station
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::List
    end

    def factory_for_seeding_barrier_free_facility_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Info
    end

    def factory_for_seeding_barrier_free_facility_escalator_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::Info
    end

    def factory_for_seeding_barrier_free_facility_toilet_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Info
    end

    def factory_for_seeding_barrier_free_facility_service_detail_list
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::List
    end

    def factory_for_seeding_barrier_free_facility_service_detail_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::ServiceDetail::Info
    end

    def factory_for_seeding_escalator_service_detail_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Info
    end

    def factory_for_seeding_escalator_service_detail_direction
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Escalator::ServiceDetail::Direction
    end

    def factory_for_seeding_toilet_service_detail_assistant_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::BarrierFree::Facility::Toilet::Assistant
    end

    def factory_for_seeding_platform_infos
      ::TokyoMetro::Factory::Seed::Api::StationFacility::List::Platform
    end

    def factory_for_seeding_platform_infos_of_each_station
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::List
    end

    def factory_for_seeding_platform_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info
    end

    def factory_for_seeding_platform_info_transfer_list
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Transfer::List
    end

    def factory_for_seeding_platform_info_transfer_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::Transfer::Info
    end

    def factory_for_seeding_platform_info_barrier_free_list
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::BarrierFree::List
    end

    def factory_for_seeding_platform_info_barrier_free_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::BarrierFree::Info
    end

    def factory_for_seeding_platform_info_surrounding_area_list
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::SurroundingArea::List
    end

    def factory_for_seeding_platform_info_surrounding_area_info
      ::TokyoMetro::Factory::Seed::Api::StationFacility::Info::Platform::Info::SurroundingArea::Info
    end

    # API の情報（generate_instance が true のときの、インスタンスの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def method_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_generated
      :same_as
    end

    # API の情報（ハッシュの配列）の各成分をディレクトリ分けするときに使用するキーの設定
    # @return [String or Symbol]
    def key_name_for_determining_dir_when_saving_grouped_infos_and_instance_is_not_generated
      "owl:sameAs"
    end

    # ファイル名を作成する際に削除する部分を示す正規表現
    # @return [Regexp]
    def regexp_indicating_deleted_part_of_value_and_used_when_determine_saved_file_name
      /\Aodpt\.StationFacility\:/
    end

    def db_instance_class
      ::StationFacility
    end

    def db_instance_class_of_barrier_free_facility_info
      ::BarrierFreeFacility::Info
    end

    def db_instance_class_of_barrier_free_service_detail
      ::BarrierFreeFacilityServiceDetail
    end

    def db_instance_class_of_barrier_free_service_detail_pattern
      ::BarrierFreeFacilityServiceDetailPattern
    end

    def db_instance_class_of_escalator_direction
      ::BarrierFreeFacilityEscalatorDirection
    end

    def db_instance_class_of_escalator_direction_pattern
      ::BarrierFreeFacilityEscalatorDirectionPattern
    end

    def db_instance_class_of_toilet_assistant
      ::BarrierFreeFacilityToiletAssistant
    end

    def db_instance_class_of_platform_info
      ::StationFacilityPlatformInfo
    end

    def db_instance_class_of_platform_info_transfer_info
      ::StationFacilityPlatformInfoTransferInfo
    end

    def db_instance_class_of_platform_info_barrier_free_facility
      ::StationFacilityPlatformInfoBarrierFreeFacility
    end

    def db_instance_class_of_platform_info_surrounding_area
      ::StationFacilityPlatformInfoSurroundingArea
    end

    # @!endgroup

    private

    # @!group クラスメソッド - データの取得・保存

    # データを保存するディレクトリ
    # @return [String]
    def db_dirname_sub
      "station_facility"
    end

  end

end