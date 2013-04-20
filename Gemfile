
# ===================================================
# Declare any app specific gems in the AppGemfile
# ===================================================
#
#
# Install gems for AppGemfile
app_gemfile = File.join(File.dirname(__FILE__), "AppGemfile")
eval(IO.read(app_gemfile), binding)

# Install gems from dust core
core_gemfile = File.join(File.dirname(__FILE__), 'vendor', 'gems', 'dust', "Gemfile")
eval(IO.read(core_gemfile), binding)
