class GithubSearch
  def initialize(github_token)
    @github_token = github_token
  end

  def user_repos
    service.pull_repos.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def user_followers
    service.pull_followers.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  def user_followings
    service.pull_followings.map do |following_data|
      Following.new(following_data)
    end
  end

  def service
    GithubService.new(@github_token)
  end
end
