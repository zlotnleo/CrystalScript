require "spec"
require "../src/crystalscript"

def with_temp(name, &block)
  begin
    Dir.mkdir_p(__DIR__ + "/" + name)
    yield
    Dir.rmdir(__DIR__ + "/" + name)
  rescue e : Errno
    STDERR.puts e.to_s
  end
end

class Timeout < Exception
end

# def wait_or_timeout(proc, time)
#   d = delay(time) do
#     puts "Timeout " + proc.pid.to_s
#     io = IO::Memory.new
#     pgrep = Process.new("pgrep", args: ["-P #{proc.pid}"], error: STDERR)
#     status = pgrep.wait
#     puts "pgrep exited with: " + status.exit_code.to_s
#     output = pgrep.output
#     puts output.to_s
#     # child_pid = io.to_s.to_i

#     # puts child_pid
#     # puts "childpid: " + child_pid.to_s
#     # Process.kill(Signal::TERM, child_pid, proc.pid)
#   end
#   case proc.wait
#   when .normal_exit?
#     d.cancel
#   when .signal_exit?
#     raise Timeout.new("Timout exceeded")
#   end
# end

def run_test(filename)
  crystal_in_path = __DIR__ + "/input/" + filename
  base_name = File.basename(crystal_in_path, ".cr")

  crystal_out = File.tempfile("cr_out")

  Process.new("crystal", args: ["run", crystal_in_path], output: crystal_out, error: STDERR).wait.success?.should be_true
  # wait_or_timeout(proc, 2.seconds)

  js_in = File.tempfile("js_in")
  js_in << CrystalScript.from_file(crystal_in_path, "irrelevant")

  js_out = File.tempfile("js_out")

  Process.new("node", args: [js_in.path], output: js_out, error: STDERR).wait.success?.should be_true
  # wait_or_timeout(proc, 2.seconds)

  crystal_out.rewind
  js_out.rewind
  crystal_out.gets_to_end.should eq js_out.gets_to_end
ensure
  crystal_out.delete unless crystal_out.nil?
  js_in.delete unless js_in.nil?
  js_out.delete unless js_out.nil?
end
