class CreateTagsThemesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tags_themes, id: false do |t|
      t.belongs_to :tag, index: true
      t.belongs_to :theme, index: true
    end
  end
end
