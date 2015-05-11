require 'octokit'

SCHEDULER.every '25m', :first_in => 0 do |job|
  client = Octokit::Client.new(:access_token => "b1d3dfeb056ff5df332e08336910a29e2883923e")
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