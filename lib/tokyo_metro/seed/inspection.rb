module TokyoMetro::Seed::Inspection

  def self.title( class_name , indent: 0 )
    puts " " * indent * 4 + "● #{ class_name.name }"
  end

  def self.title_with_method( class_name , method_name , indent: 0 , whole: nil , now_at: nil , other: nil )
    info_v = [ whole , now_at ]
    raise "Error" unless info_v.all? { |i| i == nil } or info_v.all? { |i| i.kind_of?( Numeric ) }

    str = " " * indent * 4 + "○ #{ str_of_class_name( class_name ) }\##{ method_name.to_s }"
    if info_v.all? { |i| i.kind_of?( Numeric ) }
      str += ( " " * 2 + "(#{now_at}/#{whole})" )
    end
    if other.present?
      str += " #{other}"
    end
    puts str
    unless other.nil?
      puts other
    end
    puts ""
  end

  def self.time( time_begin , time_end = Time.now , indent: 0 )
    t = time_end - time_begin
    t = ( t * 100 ).round * 1.0 / 100
    puts " " * indent * 4 + "#{t.to_s.rjust(8)} sec / End: #{time_end.to_s}"
    puts ""
  end

  class << self

    private

    def str_of_class_name( class_name )
      if class_name.instance_of?( ::String )
        class_name
      else
        class_name.name
      end
    end

  end

end