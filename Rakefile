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

  symlinks.each_pair do |src, dest|
    if File.exists?(dest) and not File.symlink?(dest)
      raise "Error: File conflict, cowardly refusing to squash #{red(dest)}"
    elsif File.symlink?(dest)
      puts "File #{yellow(dest)} already a symlink, skipping"
    else
      begin
        File.symlink(src, dest)
        puts "Symlinking #{green(dest)}"
      rescue NotImplementedError
        puts "Error: Symlinks are not supported on your system."
      end
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
