begin
  script = <<SCRIPT
while true do
  true
end
SCRIPT

  individual_command = 'ruby -e "' + script + '"'
  group_command = (1..32).to_a.collect {individual_command}.join("&")

  `#{group_command}`
rescue SystemExit, Interrupt
  `ps aux | grep ruby | grep while | cut -d' ' -f 2 | xargs kill`
end
