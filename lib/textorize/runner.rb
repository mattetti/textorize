module Textorize
  class Runner
    
    def initialize(string, output, options)
      app = NSApplication.sharedApplication
      app.delegate = RunnerApplication.new(string, output, options)
      app.run
    end
    
  end

  class RunnerApplication

    def initialize(string, output, options)
      @window = NSWindow.alloc.initWithContentRect([-2000, -2000, 2000, 2000], styleMask: NSBorderlessWindowMask, backing: 2, defer: 0)
      @string = string
      @output = output
      @options = options
    end
    
    def applicationDidFinishLaunching(notification)
      renderer = Renderer.new(@window, @string, @options)
      Saver.new(renderer).write_to_file(@output)
      NSApplication.sharedApplication.terminate(nil)
    end
    
  end

end
