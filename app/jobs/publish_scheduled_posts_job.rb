class PublishScheduledPostsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    Post.scheduled.where("publish_at <= ?", Time.current).find_each do |post|
      post.update(published: true)
    end
  end
end
