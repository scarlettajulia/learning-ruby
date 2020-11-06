class ApplicationController
  def home
    renderer = ERB.new(File.read("./views/homepage.erb"))
    renderer.result(binding)
  end
end