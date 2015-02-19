class RailsTokyoMetro::Application::RequiredFiles

  def initialize( set_all_files_under_the_top_namespace: true )
    @array = ::Array.new
    @set_all_files_under_the_top_namespace = set_all_files_under_the_top_namespace
    set_array
  end

  attr_reader :array
  alias :files :array
  alias :required_files :array

  private

  def set_array
    @array << self.class.top_file
    set_other_files
    if @set_all_files_under_the_top_namespace
      @array += self.class.all_files_under_the_top_namespace
    end
  end

  def set_other_files
    _other_files = self.class.other_files
    if _other_files.present?
      [ _other_files ].flatten.each do |f|
        set_files(f)
      end
    end
  end

  def set_files( *files )
    files.flatten.each do | file |
      filename_without_extension = file.gsub( /\.rb\Z/ , "" )
      filename_with_extension = filename_without_extension + ".rb"
      if File.exist?( filename_with_extension ) and !( @array.include?( filename_without_extension ) )
        @array << filename_without_extension
      end
    end
  end

  def set_files_starting_with( *dir_root )
    set_files( self.class.files_starting_with( *dir_root ) )
  end

  def self.files
    self.new.files
  end

  def self.top_file
    raise "This method \'#{self.name}.#{ __method__ }\' is not defined yet."
  end

  def self.other_files
    nil
  end

  class << self
    alias :required_files :files
  end

  def self.all_files_under_the_top_namespace
    ::Dir.glob( "#{ top_file }/**/**.rb" ).sort
  end

  def self.files_not_be_required
    ( all_files_under_the_top_namespace.map { | str | str.gsub( /\.rb\Z/ , "" ) } - required_files.map { | str | str.gsub( /\.rb\Z/ , "" ) } ).sort
  end

  def self.files_starting_with( *dir_root )
    d_root = dir_root.flatten
    [ ::File.join( *dir_root ) ] + ::Dir.glob( "#{ d_root.join( "/" ) }/**/**.rb" ).sort
  end

end