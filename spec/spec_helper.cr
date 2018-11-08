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

def wait_or_timeout(proc, time)
  d = delay(time) do
    io = IO::Memory.new
    Process.run("pgrep", args: ["-P #{proc.pid}"], output: io)
    child_pid = io.to_s.to_i
    Process.kill(Signal::TERM, proc.pid, child_pid)
  end
  case proc.wait
  when .normal_exit?
    d.cancel
  when .signal_exit?
    raise Timeout.new("Timout exceeded")
  end
end

def run_test(filename)
  with_temp("temp") do
    crystal_in_path = __DIR__ + "/input/" + filename
    base_name = File.basename(crystal_in_path, ".cr")

    crystal_out_path = __DIR__ + "/temp/" + base_name + ".cr_out"
    crystal_out = File.new(crystal_out_path, mode: "w")

    proc = Process.new("crystal", args: ["run", crystal_in_path], output: crystal_out, error: STDERR)
    wait_or_timeout(proc, 2.seconds)

    js_in_path = __DIR__ + "/temp/" + base_name + ".js"
    File.write(js_in_path, CrystalScript.convert(File.read(crystal_in_path)))

    js_out_path = __DIR__ + "/temp/" + base_name + ".js_out"
    js_out = File.new(js_out_path, mode: "w")

    proc = Process.new("node", args: [js_in_path], output: js_out, error: STDERR)
    wait_or_timeout(proc, 2.seconds)

    File.read(crystal_out_path).should eq File.read(js_out_path)
  ensure
    File.delete(js_in_path.as(String))
    crystal_out.delete unless crystal_out.nil?
    js_out.delete unless js_out.nil?
  end
end
