require 'octokit'
require 'pry'

SCHEDULER.every '10m', :first_in => 0 do |job|
  client = Octokit::Client.new(:access_token => "27642503f0c3f1bc8be77fe6d2142cbf274deab5")
  my_organization = "Qwinix"
  repos = client.organization_repositories(my_organization).map { |repo| repo.name }

  open_pull_requests = repos.inject([]) { |pulls, repo|
    client.pull_requests("#{my_organization}/#{repo}", :state => 'open').each do |pull|
      pulls.push({
        title: pull.title,
        repo: repo,
        updated_at: pull.updated_at.strftime("%b %-d %Y, %l:%m %p"),
        creator: "@" + pull.user.login,
        })
    end
    pulls
  }

  send_event('AuthToken', { header: "Open Pull Requests", pulls: open_pull_requests })
end

