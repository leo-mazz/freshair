ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
          para "Welcome, #{current_user.first_name}!"
          para 'The following are some quick links tailored to you. You can find all administration options accessible with your privileges using the top navigation.'
      end
    end

    columns do
      column do
        panel "Recent posts of yours" do
          posts = Post.unscoped.where(author: current_user).order(created_at: :desc).limit(5)
          if posts.count > 0
            ul do
              posts.map do |post|
                if post.is_published
                  li link_to(post.title, admin_post_path(post))
                else
                  li link_to("[NOT PUBLISHED] #{post.title}", admin_post_path(post))
                end
              end
            end
          else
            em "No post"
          end

        end
      end

      column do
        panel "Recent updates from your shows" do
          podcasts = current_user.podcasts.order(created_at: :desc).limit(5)
          if podcasts.count > 0
            div strong 'Podcasts'
            ul do
              podcasts.map do |podcast|
                li link_to("#{podcast.show.title}: #{podcast.title} (#{format_date_small (podcast.broadcast_date || podcast.created_at)})", admin_post_path(podcast))
              end
            end
          else
            em "No podcast"
            br
          end


          posts = current_user.show_posts.order(created_at: :desc).limit(5)
          if posts.count > 0
            div strong 'Posts'
            ul do
              posts.map do |post|
                li link_to("#{post.show.title}: #{post.title} (#{format_date_small post.created_at})", admin_post_path(post))
              end
            end
          else
            em "No posts"
          end

        end
      end

    end

    columns do
      column do
        panel "Posts from your teams you might have missed" do
          if current_user.teams.blank?
            em "You're not in a team"
          else
            current_user.teams.map do |team|
              div strong team.name
              p = team.posts.where.not(author: current_user).order(created_at: :desc).limit(5)
              if p.count > 0
                ul do
                  p.map do |post|
                    li link_to(post.title, post)
                  end
                end
              else
                em 'Nothing to show'
              end
            end
          end
        end
      end

      column do
        panel "Recording Studio bookings for next 7 days" do
          bookings = Booking.recording_studio_next_7_days.map
          if bookings.count > 0
            ul do
              bookings.map do |booking|
                li "#{format_date_time booking.start} - #{format_time booking.end.to_time} (#{booking.user.name})"
              end
            end
          else
            em "No booking"
          end
        end
      end

    end # columns
  end # content
end
