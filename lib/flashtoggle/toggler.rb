module Flashtoggle
  class Toggler

    attr_accessor :plugins_dir, :backup_dir, :error

    def initialize(plugins_dir, backup_dir)
      self.plugins_dir = plugins_dir
      self.backup_dir = backup_dir
    end
    
    def toggle!
      if self.flash_off?
        self.enable_flash!
      else
        self.disable_flash!
      end
    end
        
    def enable_flash!
      return if flash_on?
      begin
        Flashtoggle::FLASH_PLUGIN_FILES.each do |file|
          FileUtils.mv "#{self.backup_dir}/#{file}", "#{self.plugins_dir}/#{file}"
        end
      rescue Errno::EACCES => e
        self.error = "You must run this script by using -  sudo flashtoggle on"
      rescue Errno::ENOENT => e
        self.error = "That folder can't be found"
      end
    end

    def disable_flash!
      return if flash_off?
      begin
        FileUtils.mkdir_p self.backup_dir
        Flashtoggle::FLASH_PLUGIN_FILES.each do |file|
          FileUtils.mv "#{self.plugins_dir}/#{file}", "#{self.backup_dir}/#{file}"
        end
      rescue Errno::EACCES => e
        self.error = "You must run this script by using -  sudo flashtoggle off"
      rescue Errno::ENOENT => e
        self.error = "That folder can't be found"
      end
    end

    def flash_on?
      File.exists?("#{self.plugins_dir}/#{Flashtoggle::FLASH_PLUGIN_FILES[0]}")
    end

    def flash_off?
      File.exists?("#{self.backup_dir}/#{ Flashtoggle::FLASH_PLUGIN_FILES[0]}")
    end
    
  end
end