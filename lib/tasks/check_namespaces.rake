namespace :tokyo_metro do
  namespace :check_namespaces do

    desc "名前空間の名称のチェック"
    task :rename_table => :environment do
      files = ::TokyoMetro::Rake::CheckNamespace::RenameTable.files

      namespaces = ARGV[1..-1].delete_if { |v| /\A-/ === v }
      puts namespaces.to_s

      namespaces.each do | namespace |
        ::TokyoMetro::Rake::CheckNamespace::RenameTable::Namespace.new( namespace , files ).search.display
      end

      a = nil
    end

  end
end
