# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
# Add Yarn node_modules folder to the asset load path.
Rails.application.config.assets.paths << Rails.root.join('node_modules')

# Precompile additional assets.
# application.js, application.scss, and all non-JS/CSS in the app/assets
# folder are already added.
Rails.application.config.assets.precompile += %w( bootstrap.min.css font-awesome.min.css animate.min.css imagehover.min.css
 normalize.css owl.carousel.min.css owl.transitions.css magnific-popup.css style.css responsive.css skin/blue.css jquery.min.js bootstrap.min.js jquery.mixitup.js
jquery.magnific-popup.min.js jquery.waypoints.min.js jquery.ajaxchimp.min.js main_script.js)
