require 'logger'
require 'formatter'
require 'default_configuration'
require 'configuration'

module KLog
  class Log
    extend Configuration
    define_setting :active, true
    define_setting :logger, DefaultConfiguration.logger
    define_setting :label, "Default Logging"
    define_setting :level, :info

    attr_writer :active, :level

    def active?
      @@active
    end

    def level(level = @@level)
      @level = level
    end

    def log(msg)
      logger.send(level, "(#{@@label})\n#{msg}\n\n") if active?
    end

    def write
      @@logger.close
    end

    def log_request(request, url)
      log formatter.format_request(request, url)
    end

    def log_response(response)
      log formatter.format_response(response)
    end

    private
    def formatter
      @formatter ||= KLog::HTTPFormatter.new
    end

    def logger
      @@logger ||= DefaultConfiguration.logger
    end
  end
end
