class AddAudioToMatchquestion < ActiveRecord::Migration
  def change
    add_column :matchquestions, :audio, :string
  end
end
