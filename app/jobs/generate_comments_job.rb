class GenerateCommentsJob < ApplicationJob
  queue_as :default

  def perform
    weighted_order = "RANDOM() * (EXTRACT(EPOCH FROM NOW()) - EXTRACT(EPOCH FROM created_at))"
    posts = Post.order(Arel.sql(weighted_order)).limit((User.count * 0.2).ceil)

    # Loop through each post and create 1 comment for each
    posts.each do |post|
      WriteCommentJob.perform_later(post.id)
    end
  end
end
