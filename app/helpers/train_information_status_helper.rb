module TrainInformationStatusHelper

  private

  def train_information_status_on_time
    content_tag( :div , class: [ :status , :on_time ] ) do
      concat train_information_status_on_time_image
      concat train_information_status_on_time_text
      concat train_information_additional_info
    end
  end

  def train_information_status_on_time_image
    content_tag( :div , class: :image ) do
      concat image_tag( "train_information/status/on_time.png" )
    end
  end

  def train_information_status_on_time_text
    content_tag( :div , class: :text ) do
      concat content_tag( :p , "平常運転" , class: :text_ja )
      concat content_tag( :p , "Now on time" , class: :text_en )
    end
  end

  def train_information_nearly_on_time
    content_tag( :div , class: [ :status , :nearly_on_time ] ) do
      concat train_information_nearly_on_time_image
      concat train_information_nearly_on_time_text
      concat train_information_additional_info( "遅れ：最大 1分30秒" )
    end
  end

  def train_information_nearly_on_time_image
    content_tag( :div , class: :image ) do
      concat image_tag( "train_information/status/nearly_on_time.png" )
    end
  end

  def train_information_nearly_on_time_text
    content_tag( :div , class: :text ) do
      concat content_tag( :p , "ほぼ平常運転" , class: :text_ja )
      concat content_tag( :p , "Now on time" , class: :text_en )
    end
  end

  def train_information_delay
    content_tag( :div , class: [ :status , :delay ] ) do
      concat train_information_delay_image
      concat train_information_delay_text
      concat train_information_additional_info( "遅れ：最大 15分" )
    end
  end

  def train_information_delay_image
    content_tag( :div , class: :image ) do
      concat image_tag( "train_information/status/delay.png" )
    end
  end

  def train_information_delay_text
    content_tag( :div , class: :text ) do
      concat content_tag( :p , "遅れあり" , class: :text_ja )
      concat content_tag( :p , "Delay" , class: :text_en )
    end
  end

  def train_information_status_suspended
    content_tag( :div , class: [ :status , :suspended ] ) do
      concat train_information_status_suspended_image
      concat train_information_status_suspended_text
      concat train_information_additional_info( "運転再開予定：15:30" )
    end
  end

  def train_information_status_suspended_image
    content_tag( :div , class: :image ) do
      concat image_tag( "train_information/status/suspended.png" )
    end
  end

  def train_information_status_suspended_text
    content_tag( :div , class: :text ) do
      concat content_tag( :p , "運転見合わせ" , class: :text_ja )
      concat content_tag( :p , "Operation suspended" , class: :text_en )
    end
  end

end