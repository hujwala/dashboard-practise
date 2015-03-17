require 'octokit'

SCHEDULER.every '1m', :first_in => 0 do |job|
  client = Octokit::Client.new(:access_token => "96e0347661f735cc7367f335dc7f0bd3ff8b5d35")
  my_organization = "Qwinix"
  repos = client.organization_repositories(my_organization).map { |repo| repo.name }

  open_pull_requests = repos.inject([]) { |pulls, repo|

     if repo == "bournville-htmls"
    client.pull_requests("#{my_organization}/#{repo}", :state => 'Close').each do |pull|
      pulls.push({
        title: pull.title,
        repo: repo,
        updated_at: pull.updated_at.strftime("%b %-d %Y, %l:%m %p"),
        creator: "@" + pull.user.login,
        })
     end
    end
     pulls 

  }

  send_event('pull_request', { header: "Open Pull Requests", pulls: open_pull_requests })
end
