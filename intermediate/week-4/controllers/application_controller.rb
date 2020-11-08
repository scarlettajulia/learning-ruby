class ApplicationController
  def self.home
    renderer = ERB.new(File.read("./views/homepage.erb"))
    renderer.result(binding)
  end
end