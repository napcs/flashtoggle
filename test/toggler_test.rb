require 'rubygems'
require 'test/unit'
require 'mocha'
require 'lib/flashtoggle'

class TogglerTest < Test::Unit::TestCase

  def setup
    @plugins_dir = File.expand_path("tmp/plugins")
    @backup_dir = File.expand_path("tmp/disabledplugins")
    FileUtils.mkdir_p @plugins_dir
    FileUtils.mkdir_p @backup_dir
  end

  def teardown
    FileUtils.rm_rf @plugins_dir
    FileUtils.rm_rf @backup_dir
  end

  def test_toggler_enable  
    
    Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
      FileUtils.touch "#{@plugins_dir}/#{f}"
    end
    
    toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
    toggler.enable_flash!
    
    Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
      assert !File.exists?("#{@backup_dir}/#{f}")
      assert File.exists?("#{@plugins_dir}/#{f}")
    end
    
  end
  
  def test_toggler_disable

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       FileUtils.touch "#{@backup_dir}/#{f}"
     end

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     toggler.disable_flash!

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       assert File.exists?("#{@backup_dir}/#{f}")
       assert !File.exists?("#{@plugins_dir}/#{f}")
     end

   end
  
   def test_toggler_toggle_disables_flash_when_currently_enabled

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       FileUtils.touch "#{@plugins_dir}/#{f}"
     end

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     toggler.toggle!

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       assert File.exists?("#{@backup_dir}/#{f}")
       assert !File.exists?("#{@plugins_dir}/#{f}")
     end

   end
   
   def test_toggler_toggle_enables_flash_when_currently_disabled

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       FileUtils.touch "#{@backup_dir}/#{f}"
     end

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     toggler.toggle!

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       assert !File.exists?("#{@backup_dir}/#{f}")
       assert File.exists?("#{@plugins_dir}/#{f}")
     end

   end
   
   def test_toggler_toggle_catches_file_missing_errors

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     toggler.toggle!

     assert_not_nil toggler.error

   end
   
   def test_toggler_toggle_catches_file_access_errors

     toggler = Flashtoggle::Toggler.new("/Library", @backup_dir)
     toggler.toggle!
     assert_not_nil toggler.error
   end
  
   def test_toggler_status_message_is_disabled_when_disabled

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       FileUtils.touch "#{@backup_dir}/#{f}"
     end

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     assert_equal "Flash is currently disabled", toggler.status
   end
   
   def test_toggler_status_message_is_enabled_when_enabled

     Flashtoggle::FLASH_PLUGIN_FILES.each do |f|
       FileUtils.touch "#{@plugins_dir}/#{f}"
     end

     toggler = Flashtoggle::Toggler.new(@plugins_dir, @backup_dir)
     assert_equal "Flash is currently enabled", toggler.status
   end
  
end

