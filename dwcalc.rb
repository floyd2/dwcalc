#!/usr/bin/env ruby
#
# just a little tool to calculate the needed time to download a file by giving the size of the file
# and the bandwith
#


cmd = ARGV

if cmd.size != 2
  puts "invalid parameters"
  puts "dwcalc [bandwith] [download size]"
  exit(1)
end

def bandwith_to_byte(bandwith)
  case bandwith[-1].upcase
  when "K"
    quo = 0
  when "M"
    quo = 2
  when "G"
    quo = 3
  when "T"
    quo = 4
  when "B"
    return bandwith.gsub(bandwith[-1], "").to_f
  end

  bandwith = bandwith.gsub(bandwith[-1], "").to_f
  if quo == 0
    return bandwith * 1000
  else
    return bandwith * (1000 ** quo)
  end
end

def download_size_to_byte(dwsize)
  case dwsize[-1].upcase
  when "K"
    quo = 0
  when "M"
    quo = 2
  when "G"
    quo = 3
  when "T"
    quo = 4
  when "B"
    return dwsize.gsub(dwsize[-1], "").to_f
  end

  dwsize = dwsize.gsub(dwsize[-1], "").to_f
  if quo == 0
    return dwsize * 1024
  else
    return dwsize * (1024 ** quo)
  end
end

bandwith = bandwith_to_byte(ARGV[0])
dwsize = download_size_to_byte(ARGV[1])


sec = (dwsize / bandwith)
sec = sec.to_i

days = (sec / 86400).to_i
sec -= days * 86400

houre = (sec / 3600).to_i
sec -= houre * 3600

min = (sec / 60).to_i
sec -= min * 60

#puts "houre #{houre}"
#puts "min #{min}"
#puts "sec #{sec}"

#sec = dwsize / bandwith
#puts "sec #{sec}"
#
#
#min = sec / 60
#puts "min: #{min}"
#sec = sec - (min * 60)
#
#houre = min / 60
#puts "houre: #{houre}"
#min = min - (houre * 60)

time = ""
if days != 0
  if days < 10
    time = "0#{days} Days and "
  else
    time = "#{days} Days and "
  end
end

if houre != 0
  if houre < 10
    time = "#{time}0#{houre}:"
  else
    time = "#{time}#{houre}:"
  end
end

if min != 0
  if min < 10
    time = "#{time}0#{min}:"
  else
    time = "#{time}#{min}:"
  end
end

if sec < 10
  time = "#{time}0#{sec}"
else
  time = "#{time}#{sec}"
end



puts "Time: #{time} for #{ARGV[1]} with #{ARGV[0]}/s"
#puts "Time: #{houre.to_i}:#{min.to_i}:#{sec.to_i} for #{ARGV[1]} with #{ARGV[0]}"



