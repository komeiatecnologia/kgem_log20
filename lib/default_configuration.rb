module KLog
  class DefaultConfiguration
    def self.logger
      begin
        return Rails.logger
      rescue Exception => e
        return Logger.new(STDOUT)
      end
    end
  end
end
