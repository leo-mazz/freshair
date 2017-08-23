class SettingsService

    def self.get(key)
      setting = Setting.find_by_key(key)
      unless setting.nil?
        return setting.value
      end
    end

end
