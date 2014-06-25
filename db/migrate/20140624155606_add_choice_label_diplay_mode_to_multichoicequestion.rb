class AddChoiceLabelDiplayModeToMultichoicequestion < ActiveRecord::Migration
  def change
    add_column :multichoicequestions, :choice_label_display_mode, :string
  end
end
