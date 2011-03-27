#!/usr/bin/env ruby

# Copyright (C) 2008-2011 Torsten Becker <torsten.becker@gmail.com>.
# All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to
# deal in the Software without restriction, including without limitation the
# rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
# sell copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER 
# IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#
# any-scm.rb, created on 2008-Jun-19.

# See README.md for information


DEBUG_PATH = false


def detect_scm from_where
  
  path = File.expand_path(from_where)
  
  loop do
    print "(#{path}) " if DEBUG_PATH
    
    if File.exists? "#{path}/.svn"
      puts "  ★ Subversion"
      return :svn
      
    elsif File.exists? "#{path}/.git"
      puts "  ★ Git"
      return :git
    
    elsif File.exists? "#{path}/.hg"
      puts "  ★ Mercurial"
      return :hg
    
    else
      # If it did not work, terminate
      raise "Did not find any known version control system."  if path == '.'
      
      # Remove the last path component
      new_path = path.gsub(%r{/[^/]*$}, '')
      
      # If nothing got removed it did not have any slashes, so lets try .
      if new_path == path
        path = '.'
      else
        path = new_path
      end
      
    end
    
  end
  
end


begin
  command = $0.sub(/^.*\//, '').to_sym
  
  case command
  
  # Status
  when :st
    case detect_scm(($*[0] or Dir.getwd))
    when :svn
      exec('svn', 'st', *$*)
    when :git
      exec('git', 'status', '-sb', *$*)
    when :hg
      exec('hg', 'status', *$*)
    end
    
  # Add
  when :add
    case detect_scm($*[0])
    when :svn
      exec('svn', 'add', *$*)
    when :git
      exec('git', 'add', *$*)
    when :hg
      exec('hg', 'add', *$*)
    else
      raise "Not implemented"
    end
    
  # Commit
  when :ci
    case detect_scm(($*[0] or Dir.getwd))
    when :svn
      exec('svn', 'ci', *$*)
    when :git
      unless $*[0]
        exec('git', 'commit', '-a', '-v')
      else
        exec('git', 'commit', '-v', *$*)
      end
    when :hg
      exec('hg', 'commit', *$*)
    else
      raise "Not implemented"
    end
    
  when :revert
    case detect_scm($*[0])
    when :svn
      exec('svn', 'revert', *$*)
    when :git
      exec('git', 'checkout', '--', *$*)
    when :hg
      exec('hg', 'revert', *$*)
    else
      raise "Not implemented"
    end
  
  else
    raise "Sorry, any-scm.rb does not know anything about a '#{command}' command."
  end 
  
rescue
  puts "#{$!.class}: #{$!.message}"
  
end
