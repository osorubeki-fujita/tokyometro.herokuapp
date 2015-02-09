module TokyoMetro::Document::MakeExamples::Static

  def self.process
    file_for_making_examples.each do | filename |
      EachFile.new( filename ).process
    end
  end

  class << self

    private

    def file_for_making_examples
      ::Dir.glob( "#{::TokyoMetro::DEV_DIR}/make_examples_in_document/base/**.txt" )
    end

  end

end