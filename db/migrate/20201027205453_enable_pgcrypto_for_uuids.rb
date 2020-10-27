# frozen_string_literal: true

class EnablePgcryptoForUuids < ActiveRecord::Migration[6.0]
  def up
    enable_extension 'pgcrypto'
  end

  def down
    disable_extension 'pgcrypto'
  end
end
