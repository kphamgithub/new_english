class RemoveAudioFromFillquestion < ActiveRecord::Migration
  def change
    remove_column :fillquestions, :audio, :string
  end
end
