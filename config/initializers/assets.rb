# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
# Rails.application.config.assets.precompile += %w( search.js )
Rails.application.config.assets.precompile += %w( ckeditor/*)
Rails.application.config.assets.precompile += ['theme.js']
SpreeEditor::Config.tap do |config|
  config.ids = 'product_description page_body event_body magazine_content order_message blog_body'

  # change the editor to CKEditor
  config.current_editor = 'CKEditor'
end
