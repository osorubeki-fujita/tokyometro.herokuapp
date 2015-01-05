module RailwayLineMatrixHelper

  def make_railway_line_matrixes_whole( with_yf: false , make_link_to_line: true )
    h_locals = {
      with_yf: with_yf ,
      make_link_to_line: make_link_to_line
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ id: :railway_line_matrixes }
  - ::RailwayLine.tokyo_metro.each do | railway_line |
    = make_railway_line_matrix( railway_line , make_link_to_line: make_link_to_line )
  - if with_yf
    = make_yf_matrix( make_link_to_line )
    HAML
  end

  def make_railway_line_matrix( railway_line , make_link_to_line: true , size: :normal )
    case size
    when :normal
      class_names = [ :railway_line_matrix , :each_line , railway_line.css_class_name ]
    when :small
      class_names = [ :railway_line_matrix_small , :each_line , railway_line.css_class_name ]
    end

    h_locals = {
      railway_line: railway_line ,
      make_link_to_line: make_link_to_line ,
      size: size ,
      class_names: class_names
    }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: class_names }
  - if make_link_to_line
    = link_to( "" , "#{railway_line.css_class_name}_line" )
  - case size
  - when :normal
    %div{ class: :info }
      = make_railway_line_code( railway_line )
      = make_railway_line_matrixes_railway_line_name( railway_line )
  - when :small
    %div{ class: :info }
      = make_railway_line_code( railway_line )
      %div{ class: :text }
        = make_railway_line_matrixes_railway_line_name( railway_line )
    HAML
  end

  private

  def make_railway_line_code( railway_line )
    render inline: <<-HAML , type: :haml , locals: { railway_line: railway_line }
- if railway_line.name_code.present?
  %div{ class: :railway_line_code_outer }
    = railway_line_code( railway_line )
    HAML
  end

  def make_yf_matrix( make_link_to_line )
    h_locals = { make_link_to_line: make_link_to_line }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: [ :railway_line_matrix , :multiple_lines , :yurakucho_fukutoshin ] }
  - if make_link_to_line
    = link_to( "" , "yurakucho_and_fukutoshin_line" )
  %div{ class: :info }
    %div{ class: :railway_line_codes }<
      %div{ class: :railway_line_code_block }
        - [ [ "Y" , :yurakucho ] , [ "F" , :fukutoshin ] ].each do | railway_line_code , css_class_name |
          %div{ class: css_class_name }<
            %div{ class: :railway_line_code_outer }<
              = railway_line_code( nil , letter: railway_line_code )
    %div{ class: :text_ja }<
      = "有楽町線・副都心線"
    %div{ class: :text_en }<
      = "Yurakucho and Fukutoshin Line"
    HAML
  end

  def make_railway_line_matrixes_railway_line_name( railway_line )
    h_locals = { railway_line: railway_line }

    render inline: <<-HAML , type: :haml , locals: h_locals
%div{ class: :text_ja }<
  = railway_line.name_ja
%div{ class: :text_en }<
  = railway_line.name_en
    HAML
  end

end