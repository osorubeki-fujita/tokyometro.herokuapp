class CreateTrainInformationTexts < ActiveRecord::Migration
  def change
    create_table :train_information_texts do |t|
      t.string :in_api

      t.timestamps null: false
    end
    
    remove_column :train_information_olds , :train_information_text
    remove_column :train_informations , :train_information_text
    add_column :train_information_olds , :train_information_text_id , :integer
    add_column :train_informations , :train_information_text_id , :integer
  end
end
