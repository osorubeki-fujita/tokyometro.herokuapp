module TopContentHelper

  def top_content
    render inline: <<-HAML , type: :haml , locals: { method_name: __method__ }
- # %div{ id: method_name }
- #   %div.text
- #     = top_content_title
= remark_now_developing
    HAML
  end

  private

  def top_content_title
    render inline: <<-HAML , type: :haml
%div.title<
  %div.tokyo_metro<
    = "Tokyo Metro"
  %div.open_data_contest<
    = "Open Data in 2014"
    HAML
  end

  def remark_now_developing
    render inline: <<-HAML , type: :haml
%div{id: :now_developing }<
  = "ただいま開発中につき"
  = tag( :br )
  = "間違っている情報が"
  = tag( :br )
  = "含まれている場合があります"
    HAML
  end

end