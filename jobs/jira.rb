require 'jira-ruby'
require 'pry'


host = "https://qwinix.atlassian.net/secure/RapidBoard.jspa?rapidView=275&projectKey=BB3&view=detail"
username = "upatel@qwinix.io"
password = "Qwinix123"
 project = "BB3"
status = "IN PROGRESS"

options = {
            :username => username,
            :password => password,
            :context_path => '',
            :site     => host,
            :auth_type => :basic
          }

SCHEDULER.every '10m', :first_in => 0 do |job|

  client = JIRA::Client.new(options)
  num = 0;

  client.Issue.jql("PROJECT = \"#{project}\" AND STATUS = \"#{status}\"").each do |issue|
      num+=1
  end
  send_event('jira', { current: num})
end