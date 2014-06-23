class AddAudioToMatch < ActiveRecord::Migration
  def change
    add_column :matches, :audio, :string
  end
end
