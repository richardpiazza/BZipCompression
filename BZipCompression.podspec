Pod::Spec.new do |s|
  s.name = "BZipCompression"
  s.version = "1.0.2"
  s.summary = "A fork of BZipCompression with support for more platforms."
  s.description = <<-DESC
  An update of BZipCompression that adds all Apple deployment targets and support for SPM.
                     DESC
  s.homepage = "https://github.com/richardpiazza/BZipCompression"
  s.license = 'Apache'
  s.author = { "Richard Piazza" => "github@richardpiazza.com" }
  s.social_media_url = 'https://twitter.com/richardpiazza'

  s.source = { :git => "https://github.com/richardpiazza/BZipCompression.git", :tag => s.version.to_s }
  s.source_files = 'Sources/BZipCompression/include/*.h', 'Sources/BZipCompression/*.m'
  s.frameworks = 'Foundation'
  s.library = 'bz2'
  s.requires_arc = true

  s.osx.deployment_target = "10.13"
  s.ios.deployment_target = "11.0"
  s.tvos.deployment_target = "11.0"
  s.watchos.deployment_target = "4.0"
end
