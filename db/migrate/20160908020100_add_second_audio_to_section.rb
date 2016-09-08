class AddSecondAudioToSection < ActiveRecord::Migration
  def change
    add_column :sections, :second_audio, :string
  end
end
