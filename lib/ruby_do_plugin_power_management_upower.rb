class Ruby_do_plugin_power_management_upower < Ruby_do::Plugin::Base
  def start
    self.register_static_result(
      :id_str => "suspend",
      :title => _("Suspend"),
      :descr => _("Suspend the computer to RAM."),
      :icon_path => File.realpath("#{File.dirname(__FILE__)}/../gfx/system-suspend.png"),
      :data => {
        :mode => :suspend
      }
    )
    self.register_static_result(
      :id_str => "shutdown",
      :title => _("Shutdown"),
      :descr => _("Shutdown the computer."),
      :icon_path => File.realpath("#{File.dirname(__FILE__)}/../gfx/system-shutdown.png"),
      :data => {
        :mode => :shutdown
      }
    )
    self.register_static_result(
      :id_str => "reboot",
      :title => _("Reboot"),
      :descr => _("Reboot the computer."),
      :icon_path => File.realpath("#{File.dirname(__FILE__)}/../gfx/system-reboot.png"),
      :data => {
        :mode => :shutdown
      }
    )
    self.register_static_result(
      :id_str => "hibernate",
      :title => _("Hibernate"),
      :descr => _("Suspend to computer to harddrive."),
      :icon_path => File.realpath("#{File.dirname(__FILE__)}/../gfx/system-suspend-hibernate.png"),
      :data => {
        :mode => :shutdown
      }
    )
  end
  
  def execute_static_result(args)
    if args[:sres].data[:mode] == :suspend
      Knj::Os.subproc("dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Suspend")
    elsif args[:sres].data[:mode] == :shutdown
      Knj::Os.subproc("dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Shutdown")
    elsif args[:sres].data[:mode] == :reboot
      Knj::Os.subproc("dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Reboot")
    elsif args[:sres].data[:mode] == :hibernate
      Knj::Os.subproc("dbus-send --system --print-reply --dest=\"org.freedesktop.UPower\" /org/freedesktop/UPower org.freedesktop.UPower.Hibernate")
    else
      raise sprintf(_("Unknown mode: '%s'."), args[:sres].data[:mode])
    end
    
    return :close_win_main
  end
end