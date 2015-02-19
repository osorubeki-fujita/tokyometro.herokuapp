module TokyoMetro::Modules::Api::Convert::Customize::TrainInfos::MarunouchiBranchLine::Info

  def initialize( *variables )
    super( *variables )
    convert_railway_line_name_of_marunouchi_branch_line_train
  end

  private

  def convert_railway_line_name_of_marunouchi_branch_line_train
    if operated_only_on_marunouchi_branch_line_including_invalid?
      @railway_line = "odpt.Railway:TokyoMetro.MarunouchiBranch"
    end
  end

end