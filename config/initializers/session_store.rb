# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pardal_session',
  :secret      => 'ca9fef0884f2c18ae02f6c78cf9d089a62734e28ea9bca446eaa7d91da9e4c33b56ed6182baeae83cbaf26f48e4795a5069eac2369957f5a6d9d7fa0bdce81b0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
