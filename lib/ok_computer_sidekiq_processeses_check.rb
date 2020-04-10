require "ok_computer_sidekiq_processeses_check/version"

module OkComputerSidekiqProcessesesCheck
  class Error < StandardError; end
  
  class Base < OkComputer::Check
    def check
      ps = Sidekiq::ProcessSet.new
      ps.size
  
      if ps.size == 0
        mark_failure
        mark_message "No process running"
      else
        message = ""
        ps.each do |process|
          message += "busy: #{process['busy']} hostname: #{process['hostname']} pid: #{process['pid']}"
          message += " "
        end
  
        mark_message message
      end
    end
  end
end
