#!/usr/bin/env ruby

def green(string)
  "\033[32m#{string}\033[0m"
end

def yellow(string)
  "\033[33m#{string}\033[0m"
end

def red(string)
  "\033[31m#{string}\033[0m"
end

basedir = "#{File.dirname(__FILE__)}/config"
homedir = ENV['HOME']
symlinks = {}
Dir.glob("#{basedir}/*").each do |item|
  symlinks[item] = "#{homedir}/.#{File.basename(item)}"
end

desc "Symlink vim config files to default locations"
task :symlink do

  # TODO Make this bit smarter, ignoring symlinks and dying on regular files.
  symlinks.each_value do |item|
    if File.exists?(item)
      raise <<-eos
        Error: Existing vim configuration detected. Please
        remove all vim configuration files before attempting to
        install this configuration.

        Offending files: #{green(item)}"
      eos
    end
  end

  symlinks.each_pair do |src, dest|
    begin
      File.symlink(src, dest)
      puts "Symlinking from #{green(src)} to #{green(dest)}"
    rescue NotImplementedError
      puts "Error: Symlinks are not supported on your system"
    end
  end
end


desc "Remove configuration symlinks if they exist"
task :uninstall do
  symlinks.each_pair do |src, dest|
    if File.exists?(dest)
      File.unlink(dest)
      puts "Unlinking symlink #{yellow(src)}"
    end
  end
end

task :default => :symlink
