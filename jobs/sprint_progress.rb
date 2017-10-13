# require 'time'
# require 'net/http'
# require 'json'
# require 'time'
# require 'open-uri'
# require 'cgi'
# host = "https://qwinix.atlassian.net/secure/RapidBoard.jspa?rapidView=275"
# username = "upatel@qwinix.io"
# password = "Qwinix123"
# project = "BB3"
# done = "DONE"
# sprint_name = "Sprint 22"


# options = {
#  :username => username,
#  :password => password,
#  :context_path => '',
#  :site     => host,
#  :auth_type => :basic
# }

# SCHEDULER.every '1s', :first_in => 0 do |job|

#   client = JIRA::Client.new(options)
#   total_points = 0;

#   client.Issue.jql("PROJECT = \"#{project}\" AND SPRINT = \"#{sprint_name}\" AND STATUS = \"#{DONE}\"").each do |issue|
#     closed_points+=1
#   end


#   if total_points == 0
#     percentage = 0

#     moreinfo ="No sprint currently in progress"

#   else
#     percentage = (((closed_points/1.0)/(total_points/1.0))*100).to_i
#     moreinfo = "#{closed_points.to_i} / #{total_points.to_i}"
#   end

#   send_event("sprint_progress", { title: "Sprint Progress", min: 0, value: percentage, max: 100, moreinfo: moreinfo })
# end