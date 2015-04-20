module TwitterRenderer

  def render_twitter_widget
    _twitter_accounts = object.twitter_accounts
    # raise "Error: " + object.to_s
    # raise "Error: " + _twitter_accounts.to_s
    if _twitter_accounts.present?
      h.render inline: <<-HAML , type: :haml , locals: { twitter_accounts: _twitter_accounts , twitter_title: twitter_title }
- twitter_accounts.each do | twitter_account |
  %div{ class: :twitter }
    - # = twitter_title
    = twitter_account.decorate.render( twitter_title )
      HAML
    end
  end

end