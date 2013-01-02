script = <<SCRIPT
while true do
  true
end
SCRIPT

individual_command = 'ruby -e "' + script + '"'
group_command = (1..8).to_a.collect {individual_command}.join("&")

`#{group_command}`
