module AuthProvider
  class OAuthSession < ApplicationRecord
    self.table_name = :oauth_sessions

    scope :valid, -> { where(revoked_at: nil) }

    belongs_to :resource_owner, polymorphic: true
    has_many :oauth_access_tokens

    def valid?(*args)
      super(*args) && !revoked?
    end

    def revoked?
      revoked_at.present?
    end

    def revoke!
      update_attributes!(revoked_at: Time.current)
    end
  end
end
