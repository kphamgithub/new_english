class RemoveAudioFromMultichoicequestion < ActiveRecord::Migration
  def change
    remove_column :multichoicequestions, :audio, :string
  end
end
