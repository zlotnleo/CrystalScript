module CrystalScript
  class_property logger = Logger.new(STDERR,
    progname: "CrystalScript",
    formatter: Logger::Formatter.new do |severity, datetime, progname, message, io|
      label = severity.unknown? ? "ANY" : severity.to_s
      io << progname << label.rjust(5) << ": " << message
    end
  )
end
