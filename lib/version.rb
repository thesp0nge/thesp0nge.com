def version
  return @@version if defined?(@@version)
  numbers = File.read('VERSION').strip.split('.').map {|n| n =~ /^[0-9]+$/ ? n.to_i : n}
  @@version = {
    :major => numbers[0],
    :minor => numbers[1],
    :patch => numbers[2]
  }
  if numbers[3].is_a?(String)
    @@version[:patch] = -1
    @@version[:prerelease] = numbers[3]
    @@version[:prerelease_number] = numbers[4]
  end
  @@version[:number] = numbers.join('.')
  @@version[:string] = @@version[:number].dup

  rev = revision
  @@version[:rev] = rev
  unless rev[0] == ?(
    @@version[:string] << "." << rev[0...7]
  end

  @@version
end

def revision
  if File.exists?('REVISION')
    rev = File.read('REVISION').strip
    return rev unless rev =~ /^([a-f0-9]+|\(.*\))$/ || rev == '(unknown)'
  end

  return unless File.exists?('.git/HEAD')
  rev = File.read('.git/HEAD').strip
  return rev unless rev =~ /^ref: (.*)$/

    ref_name = $1
  ref_file = "./.git/#{ref_name}"
  info_file = "./.git/info/refs"
  return File.read(ref_file).strip if File.exists?(ref_file)
  return unless File.exists?(info_file)
  File.open(info_file) do |f|
    f.each do |l|
      sha, ref = l.strip.split("\t", 2)
      next unless ref == ref_name
      return sha
    end
  end
  return nil
end
