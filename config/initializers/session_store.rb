# frozen_string_literal: true

::WebChat::Application.config.session_store(
  :redis_store,
  servers: ["#{ENV.fetch('REDIS_URL')}/session"],
  expire_after: 90.minutes,
  key: "_#{Rails.application.class.module_parent_name.downcase}_session"
)
